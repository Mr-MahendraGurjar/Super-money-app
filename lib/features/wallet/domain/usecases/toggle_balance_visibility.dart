import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:send_money_app/core/errors/failures.dart';
import 'package:send_money_app/core/usecases/usecase.dart';
import 'package:send_money_app/features/wallet/domain/entities/wallet.dart';
import 'package:send_money_app/features/wallet/domain/repositories/wallet_repository.dart';

class ToggleBalanceVisibility extends UseCase<Wallet, ToggleBalanceParams> {
  final WalletRepository repository;

  ToggleBalanceVisibility(this.repository);

  @override
  Future<Either<Failure, Wallet>> call(ToggleBalanceParams params) async {
    return await repository.updateWalletVisibility(params.isVisible);
  }
}

class ToggleBalanceParams extends Equatable {
  final bool isVisible;

  const ToggleBalanceParams({required this.isVisible});

  @override
  List<Object?> get props => [isVisible];
} 