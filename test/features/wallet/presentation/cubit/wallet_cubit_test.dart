import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money_app/core/errors/failures.dart';
import 'package:send_money_app/core/usecases/usecase.dart';
import 'package:send_money_app/features/wallet/domain/entities/wallet.dart';
import 'package:send_money_app/features/wallet/domain/usecases/get_wallet.dart';
import 'package:send_money_app/features/wallet/domain/usecases/toggle_balance_visibility.dart';
import 'package:send_money_app/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:send_money_app/features/wallet/presentation/cubit/wallet_state.dart';

import 'wallet_cubit_test.mocks.dart';

@GenerateMocks([GetWallet, ToggleBalanceVisibility])
void main() {
  late WalletCubit cubit;
  late MockGetWallet mockGetWallet;
  late MockToggleBalanceVisibility mockToggleBalanceVisibility;

  setUp(() {
    mockGetWallet = MockGetWallet();
    mockToggleBalanceVisibility = MockToggleBalanceVisibility();
    cubit = WalletCubit(
      getWallet: mockGetWallet,
      toggleBalanceVisibility: mockToggleBalanceVisibility,
    );
  });

  tearDown(() {
    cubit.close();
  });

  const tWallet = Wallet(
    balance: 500.0,
    isBalanceVisible: true,
  );

  group('loadWallet', () {
    test('initial state should be WalletInitial', () {
      expect(cubit.state, WalletInitial());
    });

    blocTest<WalletCubit, WalletState>(
      'emits [WalletLoading, WalletLoaded] when loadWallet is successful',
      build: () {
        when(mockGetWallet(any))
            .thenAnswer((_) async => const Right(tWallet));
        return cubit;
      },
      act: (cubit) => cubit.loadWallet(),
      expect: () => [
        WalletLoading(),
        const WalletLoaded(wallet: tWallet),
      ],
      verify: (_) {
        verify(mockGetWallet(NoParams()));
      },
    );

    blocTest<WalletCubit, WalletState>(
      'emits [WalletLoading, WalletError] when loadWallet fails',
      build: () {
        when(mockGetWallet(any))
            .thenAnswer((_) async => const Left(CacheFailure('Failed')));
        return cubit;
      },
      act: (cubit) => cubit.loadWallet(),
      expect: () => [
        WalletLoading(),
        const WalletError(message: 'Failed'),
      ],
    );
  });

  group('toggleBalance', () {
    const tWalletHidden = Wallet(
      balance: 500.0,
      isBalanceVisible: false,
    );

    blocTest<WalletCubit, WalletState>(
      'emits [WalletLoaded] with toggled visibility when toggleBalance is successful',
      build: () {
        when(mockToggleBalanceVisibility(any))
            .thenAnswer((_) async => const Right(tWalletHidden));
        return cubit;
      },
      seed: () => const WalletLoaded(wallet: tWallet),
      act: (cubit) => cubit.toggleBalance(),
      expect: () => [
        const WalletLoaded(wallet: tWalletHidden),
      ],
      verify: (_) {
        verify(mockToggleBalanceVisibility(
          const ToggleBalanceParams(isVisible: false),
        ));
      },
    );

    blocTest<WalletCubit, WalletState>(
      'does nothing when state is not WalletLoaded',
      build: () => cubit,
      seed: () => WalletInitial(),
      act: (cubit) => cubit.toggleBalance(),
      expect: () => [],
      verify: (_) {
        verifyNever(mockToggleBalanceVisibility(any));
      },
    );
  });
} 