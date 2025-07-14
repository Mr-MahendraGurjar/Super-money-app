import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money_app/core/errors/failures.dart';
import 'package:send_money_app/features/wallet/domain/entities/transaction.dart';
import 'package:send_money_app/features/wallet/domain/usecases/send_money.dart';

import 'get_wallet_test.mocks.dart';

void main() {
  late SendMoney usecase;
  late MockWalletRepository mockWalletRepository;

  setUp(() {
    mockWalletRepository = MockWalletRepository();
    usecase = SendMoney(mockWalletRepository);
  });

  final tTransaction = Transaction(
    id: '1',
    amount: 100.0,
    timestamp: DateTime.now(),
    type: TransactionType.send,
    isSuccess: true,
  );

  test('should send money when amount is valid', () async {
    // arrange
    when(mockWalletRepository.sendMoney(any))
        .thenAnswer((_) async => Right(tTransaction));

    // act
    final result = await usecase(const SendMoneyParams(amount: 100.0));

    // assert
    expect(result, Right(tTransaction));
    verify(mockWalletRepository.sendMoney(100.0));
    verifyNoMoreInteractions(mockWalletRepository);
  });

  test('should return InvalidInputFailure when amount is zero', () async {
    // act
    final result = await usecase(const SendMoneyParams(amount: 0));

    // assert
    expect(result, const Left(InvalidInputFailure('Amount must be greater than 0')));
    verifyZeroInteractions(mockWalletRepository);
  });

  test('should return InvalidInputFailure when amount is negative', () async {
    // act
    final result = await usecase(const SendMoneyParams(amount: -50));

    // assert
    expect(result, const Left(InvalidInputFailure('Amount must be greater than 0')));
    verifyZeroInteractions(mockWalletRepository);
  });
} 