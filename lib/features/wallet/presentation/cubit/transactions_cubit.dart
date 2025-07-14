import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app/core/usecases/usecase.dart';
import 'package:send_money_app/features/wallet/domain/usecases/get_transactions.dart';
import 'package:send_money_app/features/wallet/presentation/cubit/transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final GetTransactions getTransactions;

  TransactionsCubit({required this.getTransactions}) : super(TransactionsInitial());

  Future<void> loadTransactions() async {
    print('📱 TransactionsCubit: loadTransactions called');
    emit(TransactionsLoading());
    
    final result = await getTransactions(NoParams());
    
    result.fold(
      (failure) {
        print('📱 TransactionsCubit: Error loading transactions - ${failure.message}');
        emit(TransactionsError(message: failure.message));
      },
      (transactions) {
        print('📱 TransactionsCubit: Successfully loaded ${transactions.length} transactions');
        emit(TransactionsLoaded(transactions: transactions));
      },
    );
  }
} 