import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app/core/usecases/usecase.dart';
import 'package:send_money_app/features/wallet/domain/usecases/get_wallet.dart';
import 'package:send_money_app/features/wallet/domain/usecases/toggle_balance_visibility.dart';
import 'package:send_money_app/features/wallet/presentation/cubit/wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final GetWallet getWallet;
  final ToggleBalanceVisibility toggleBalanceVisibility;

  WalletCubit({
    required this.getWallet,
    required this.toggleBalanceVisibility,
  }) : super(WalletInitial());

  Future<void> loadWallet() async {
    emit(WalletLoading());
    
    final result = await getWallet(NoParams());
    
    result.fold(
      (failure) => emit(WalletError(message: failure.message)),
      (wallet) => emit(WalletLoaded(wallet: wallet)),
    );
  }

  Future<void> toggleBalance() async {
    if (state is WalletLoaded) {
      final currentWallet = (state as WalletLoaded).wallet;
      final result = await toggleBalanceVisibility(
        ToggleBalanceParams(isVisible: !currentWallet.isBalanceVisible),
      );
      
      result.fold(
        (failure) => emit(WalletError(message: failure.message)),
        (wallet) => emit(WalletLoaded(wallet: wallet)),
      );
    }
  }
} 