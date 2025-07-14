import 'package:send_money_app/features/wallet/domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  const TransactionModel({
    required String id,
    required double amount,
    required DateTime timestamp,
    required TransactionType type,
    required bool isSuccess,
  }) : super(
          id: id,
          amount: amount,
          timestamp: timestamp,
          type: type,
          isSuccess: isSuccess,
        );

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'].toString(),
      amount: double.parse(json['amount'].toString()),
      timestamp: DateTime.parse(json['timestamp']),
      type: json['type'] == 'send' ? TransactionType.send : TransactionType.receive,
      isSuccess: json['isSuccess'] ?? true,
    );
  }

  factory TransactionModel.fromEntity(Transaction transaction) {
    return TransactionModel(
      id: transaction.id,
      amount: transaction.amount,
      timestamp: transaction.timestamp,
      type: transaction.type,
      isSuccess: transaction.isSuccess,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
      'type': type == TransactionType.send ? 'send' : 'receive',
      'isSuccess': isSuccess,
    };
  }
} 