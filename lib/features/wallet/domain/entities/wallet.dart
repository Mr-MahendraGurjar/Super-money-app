import 'package:equatable/equatable.dart';

class Wallet extends Equatable {
  final double balance;
  final bool isBalanceVisible;

  const Wallet({
    required this.balance,
    required this.isBalanceVisible,
  });

  Wallet copyWith({
    double? balance,
    bool? isBalanceVisible,
  }) {
    return Wallet(
      balance: balance ?? this.balance,
      isBalanceVisible: isBalanceVisible ?? this.isBalanceVisible,
    );
  }

  @override
  List<Object?> get props => [balance, isBalanceVisible];
} 