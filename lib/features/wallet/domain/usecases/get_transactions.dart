import 'package:dartz/dartz.dart';
import 'package:send_money_app/core/errors/failures.dart';
import 'package:send_money_app/core/usecases/usecase.dart';
import 'package:send_money_app/features/wallet/domain/entities/transaction.dart';
import 'package:send_money_app/features/wallet/domain/repositories/wallet_repository.dart';

class GetTransactions extends UseCase<List<Transaction>, NoParams> {
  final WalletRepository repository;

  GetTransactions(this.repository);

  @override
  Future<Either<Failure, List<Transaction>>> call(NoParams params) async {
    return await repository.getTransactions();
  }
} 