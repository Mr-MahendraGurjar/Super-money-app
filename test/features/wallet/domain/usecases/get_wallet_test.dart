import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money_app/core/usecases/usecase.dart';
import 'package:send_money_app/features/wallet/domain/entities/wallet.dart';
import 'package:send_money_app/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:send_money_app/features/wallet/domain/usecases/get_wallet.dart';

import 'get_wallet_test.mocks.dart';

@GenerateMocks([WalletRepository])
void main() {
  late GetWallet usecase;
  late MockWalletRepository mockWalletRepository;

  setUp(() {
    mockWalletRepository = MockWalletRepository();
    usecase = GetWallet(mockWalletRepository);
  });

  const tWallet = Wallet(
    balance: 500.0,
    isBalanceVisible: true,
  );

  test('should get wallet from the repository', () async {
    // arrange
    when(mockWalletRepository.getWallet())
        .thenAnswer((_) async => const Right(tWallet));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, const Right(tWallet));
    verify(mockWalletRepository.getWallet());
    verifyNoMoreInteractions(mockWalletRepository);
  });
} 