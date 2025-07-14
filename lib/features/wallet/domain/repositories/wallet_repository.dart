import 'package:dartz/dartz.dart';
import 'package:send_money_app/core/errors/failures.dart';
import 'package:send_money_app/features/wallet/domain/entities/transaction.dart';
import 'package:send_money_app/features/wallet/domain/entities/wallet.dart';

abstract class WalletRepository {
  Future<Either<Failure, Wallet>> getWallet();
  Future<Either<Failure, Wallet>> updateWalletVisibility(bool isVisible);
  Future<Either<Failure, Transaction>> sendMoney(double amount);
  Future<Either<Failure, List<Transaction>>> getTransactions();
} 