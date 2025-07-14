import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String id;
  final double amount;
  final DateTime timestamp;
  final TransactionType type;
  final bool isSuccess;

  const Transaction({
    required this.id,
    required this.amount,
    required this.timestamp,
    required this.type,
    required this.isSuccess,
  });

  @override
  List<Object?> get props => [id, amount, timestamp, type, isSuccess];
}

enum TransactionType { send, receive } 