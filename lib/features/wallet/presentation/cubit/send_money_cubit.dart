import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app/features/wallet/domain/usecases/send_money.dart';
import 'package:send_money_app/features/wallet/presentation/cubit/send_money_state.dart';

class SendMoneyCubit extends Cubit<SendMoneyState> {
  final SendMoney sendMoney;

  SendMoneyCubit({required this.sendMoney}) : super(SendMoneyInitial());

  Future<void> sendMoneyTransaction(double amount) async {
    emit(SendMoneyLoading());
    
    final result = await sendMoney(SendMoneyParams(amount: amount));
    
    result.fold(
      (failure) => emit(SendMoneyError(message: failure.message)),
      (transaction) => emit(SendMoneySuccess(transaction: transaction)),
    );
  }

  void resetState() {
    emit(SendMoneyInitial());
  }
} 