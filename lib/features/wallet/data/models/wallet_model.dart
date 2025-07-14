import 'package:send_money_app/features/wallet/domain/entities/wallet.dart';

class WalletModel extends Wallet {
  const WalletModel({
    required double balance,
    required bool isBalanceVisible,
  }) : super(
          balance: balance,
          isBalanceVisible: isBalanceVisible,
        );

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      balance: double.parse(json['balance'].toString()),
      isBalanceVisible: json['isBalanceVisible'] ?? true,
    );
  }

  factory WalletModel.fromEntity(Wallet wallet) {
    return WalletModel(
      balance: wallet.balance,
      isBalanceVisible: wallet.isBalanceVisible,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'isBalanceVisible': isBalanceVisible,
    };
  }
} 