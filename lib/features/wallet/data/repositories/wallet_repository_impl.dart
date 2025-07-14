import 'package:dartz/dartz.dart';
import 'package:send_money_app/core/errors/exceptions.dart';
import 'package:send_money_app/core/errors/failures.dart';
import 'package:send_money_app/features/wallet/data/datasources/wallet_local_data_source.dart';
import 'package:send_money_app/features/wallet/data/datasources/wallet_remote_data_source.dart';
import 'package:send_money_app/features/wallet/data/models/wallet_model.dart';
import 'package:send_money_app/features/wallet/domain/entities/transaction.dart';
import 'package:send_money_app/features/wallet/domain/entities/wallet.dart';
import 'package:send_money_app/features/wallet/domain/repositories/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource remoteDataSource;
  final WalletLocalDataSource localDataSource;

  WalletRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Wallet>> getWallet() async {
    try {
      final wallet = await localDataSource.getWallet();
      return Right(wallet);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Wallet>> updateWalletVisibility(bool isVisible) async {
    try {
      final currentWallet = await localDataSource.getWallet();
      final updatedWallet = WalletModel(
        balance: currentWallet.balance,
        isBalanceVisible: isVisible,
      );
      await localDataSource.updateWallet(updatedWallet);
      return Right(updatedWallet);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Transaction>> sendMoney(double amount) async {
    try {
      // Check current balance
      final currentWallet = await localDataSource.getWallet();
      
      if (currentWallet.balance < amount) {
        return Left(InsufficientBalanceFailure('Insufficient balance'));
      }

      // Send money via API
      final transaction = await remoteDataSource.sendMoney(amount);
      
      // Update local balance
      final updatedWallet = WalletModel(
        balance: currentWallet.balance - amount,
        isBalanceVisible: currentWallet.isBalanceVisible,
      );
      await localDataSource.updateWallet(updatedWallet);
      
      // Cache transaction
      await localDataSource.cacheTransaction(transaction);
      
      return Right(transaction);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions() async {
    print('🔄 Repository: getTransactions called');
    try {
      // Try to get transactions from API first
      try {
        print('🔄 Repository: Attempting to fetch from API...');
        final apiTransactions = await remoteDataSource.getTransactions();
        print('🔄 Repository: Got ${apiTransactions.length} transactions from API');
        
        // Cache the API transactions
        for (final transaction in apiTransactions) {
          await localDataSource.cacheTransaction(transaction);
        }
        
        // Get all cached transactions (including real ones)
        final cachedTransactions = await localDataSource.getCachedTransactions();
        print('🔄 Repository: Total cached transactions: ${cachedTransactions.length}');
        
        // Sort by timestamp (newest first)
        cachedTransactions.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        
        return Right(cachedTransactions);
      } on ServerException catch (e) {
        print('🔄 Repository: API failed, using cached transactions. Error: ${e.message}');
        // If API fails, return cached transactions
        final cachedTransactions = await localDataSource.getCachedTransactions();
        cachedTransactions.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        return Right(cachedTransactions);
      }
    } on CacheException catch (e) {
      print('🔄 Repository: Cache exception: ${e.message}');
      return Left(CacheFailure(e.message));
    }
  }
} 