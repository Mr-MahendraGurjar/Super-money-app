import 'package:dartz/dartz.dart';
import 'package:send_money_app/core/errors/failures.dart';
import 'package:send_money_app/core/usecases/usecase.dart';
import 'package:send_money_app/features/wallet/domain/entities/wallet.dart';
import 'package:send_money_app/features/wallet/domain/repositories/wallet_repository.dart';

class GetWallet extends UseCase<Wallet, NoParams> {
  final WalletRepository repository;

  GetWallet(this.repository);

  @override
  Future<Either<Failure, Wallet>> call(NoParams params) async {
    return await repository.getWallet();
  }
} 