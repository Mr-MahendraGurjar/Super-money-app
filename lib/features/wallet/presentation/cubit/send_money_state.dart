import 'package:equatable/equatable.dart';
import 'package:send_money_app/features/wallet/domain/entities/transaction.dart';

abstract class SendMoneyState extends Equatable {
  const SendMoneyState();

  @override
  List<Object?> get props => [];
}

class SendMoneyInitial extends SendMoneyState {}

class SendMoneyLoading extends SendMoneyState {}

class SendMoneySuccess extends SendMoneyState {
  final Transaction transaction;

  const SendMoneySuccess({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}

class SendMoneyError extends SendMoneyState {
  final String message;

  const SendMoneyError({required this.message});

  @override
  List<Object?> get props => [message];
} 