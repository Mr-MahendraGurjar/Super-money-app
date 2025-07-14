import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:send_money_app/core/errors/failures.dart';
import 'package:send_money_app/core/usecases/usecase.dart';
import 'package:send_money_app/features/wallet/domain/entities/transaction.dart';
import 'package:send_money_app/features/wallet/domain/repositories/wallet_repository.dart';

class SendMoney extends UseCase<Transaction, SendMoneyParams> {
  final WalletRepository repository;

  SendMoney(this.repository);

  @override
  Future<Either<Failure, Transaction>> call(SendMoneyParams params) async {
    if (params.amount <= 0) {
      return Left(InvalidInputFailure('Amount must be greater than 0'));
    }
    return await repository.sendMoney(params.amount);
  }
}

class SendMoneyParams extends Equatable {
  final double amount;

  const SendMoneyParams({required this.amount});

  @override
  List<Object?> get props => [amount];
} 