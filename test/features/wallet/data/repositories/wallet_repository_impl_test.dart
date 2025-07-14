import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money_app/core/errors/exceptions.dart';
import 'package:send_money_app/core/errors/failures.dart';
import 'package:send_money_app/features/wallet/data/datasources/wallet_local_data_source.dart';
import 'package:send_money_app/features/wallet/data/datasources/wallet_remote_data_source.dart';
import 'package:send_money_app/features/wallet/data/models/transaction_model.dart';
import 'package:send_money_app/features/wallet/data/models/wallet_model.dart';
import 'package:send_money_app/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:send_money_app/features/wallet/domain/entities/transaction.dart';

import 'wallet_repository_impl_test.mocks.dart';

@GenerateMocks([WalletRemoteDataSource, WalletLocalDataSource])
void main() {
  late WalletRepositoryImpl repository;
  late MockWalletRemoteDataSource mockRemoteDataSource;
  late MockWalletLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockWalletRemoteDataSource();
    mockLocalDataSource = MockWalletLocalDataSource();
    repository = WalletRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('getWallet', () {
    const tWalletModel = WalletModel(
      balance: 500.0,
      isBalanceVisible: true,
    );

    test('should return wallet from local data source', () async {
      // arrange
      when(mockLocalDataSource.getWallet())
          .thenAnswer((_) async => tWalletModel);

      // act
      final result = await repository.getWallet();

      // assert
      expect(result, const Right(tWalletModel));
      verify(mockLocalDataSource.getWallet());
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return CacheFailure when local data source throws exception', () async {
      // arrange
      when(mockLocalDataSource.getWallet())
          .thenThrow(CacheException('Failed to get wallet'));

      // act
      final result = await repository.getWallet();

      // assert
      expect(result, const Left(CacheFailure('Failed to get wallet')));
    });
  });

  group('sendMoney', () {
    const tWalletModel = WalletModel(
      balance: 500.0,
      isBalanceVisible: true,
    );

    final tTransactionModel = TransactionModel(
      id: '1',
      amount: 100.0,
      timestamp: DateTime.now(),
      type: TransactionType.send,
      isSuccess: true,
    );

    test('should send money successfully when balance is sufficient', () async {
      // arrange
      when(mockLocalDataSource.getWallet())
          .thenAnswer((_) async => tWalletModel);
      when(mockRemoteDataSource.sendMoney(any))
          .thenAnswer((_) async => tTransactionModel);
      when(mockLocalDataSource.updateWallet(any))
          .thenAnswer((_) async => Future.value());
      when(mockLocalDataSource.cacheTransaction(any))
          .thenAnswer((_) async => Future.value());

      // act
      final result = await repository.sendMoney(100.0);

      // assert
      expect(result, Right(tTransactionModel));
      verify(mockLocalDataSource.getWallet());
      verify(mockRemoteDataSource.sendMoney(100.0));
      verify(mockLocalDataSource.updateWallet(any));
      verify(mockLocalDataSource.cacheTransaction(tTransactionModel));
    });

    test('should return InsufficientBalanceFailure when balance is insufficient', () async {
      // arrange
      when(mockLocalDataSource.getWallet())
          .thenAnswer((_) async => tWalletModel);

      // act
      final result = await repository.sendMoney(600.0);

      // assert
      expect(result, const Left(InsufficientBalanceFailure('Insufficient balance')));
      verify(mockLocalDataSource.getWallet());
      verifyNever(mockRemoteDataSource.sendMoney(any));
    });

    test('should return ServerFailure when remote data source throws exception', () async {
      // arrange
      when(mockLocalDataSource.getWallet())
          .thenAnswer((_) async => tWalletModel);
      when(mockRemoteDataSource.sendMoney(any))
          .thenThrow(ServerException('Failed to send money'));

      // act
      final result = await repository.sendMoney(100.0);

      // assert
      expect(result, const Left(ServerFailure('Failed to send money')));
    });
  });
} 