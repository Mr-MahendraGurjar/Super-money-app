import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:send_money_app/core/constants/constants.dart';
import 'package:send_money_app/core/errors/exceptions.dart';
import 'package:send_money_app/features/wallet/data/models/transaction_model.dart';
import 'package:send_money_app/features/wallet/data/models/wallet_model.dart';

abstract class WalletLocalDataSource {
  Future<WalletModel> getWallet();
  Future<void> updateWallet(WalletModel wallet);
  Future<void> cacheTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> getCachedTransactions();
}

class WalletLocalDataSourceImpl implements WalletLocalDataSource {
  final SharedPreferences sharedPreferences;

  WalletLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<WalletModel> getWallet() async {
    try {
      final balanceString = sharedPreferences.getString(Constants.balanceKey);
      
      if (balanceString != null) {
        final walletJson = json.decode(balanceString);
        return WalletModel.fromJson(walletJson);
      } else {
        // Return default wallet
        final defaultWallet = WalletModel(
          balance: Constants.initialBalance,
          isBalanceVisible: true,
        );
        await updateWallet(defaultWallet);
        return defaultWallet;
      }
    } catch (e) {
      throw CacheException('Failed to get wallet from cache');
    }
  }

  @override
  Future<void> updateWallet(WalletModel wallet) async {
    try {
      await sharedPreferences.setString(
        Constants.balanceKey,
        json.encode(wallet.toJson()),
      );
    } catch (e) {
      throw CacheException('Failed to update wallet in cache');
    }
  }

  @override
  Future<void> cacheTransaction(TransactionModel transaction) async {
    try {
      final transactionsString = sharedPreferences.getString(Constants.transactionsKey);
      List<TransactionModel> transactions = [];
      
      if (transactionsString != null) {
        final List<dynamic> transactionsJson = json.decode(transactionsString);
        transactions = transactionsJson
            .map((json) => TransactionModel.fromJson(json))
            .toList();
      }
      
      transactions.insert(0, transaction);
      
      await sharedPreferences.setString(
        Constants.transactionsKey,
        json.encode(transactions.map((t) => t.toJson()).toList()),
      );
    } catch (e) {
      throw CacheException('Failed to cache transaction');
    }
  }

  @override
  Future<List<TransactionModel>> getCachedTransactions() async {
    try {
      final transactionsString = sharedPreferences.getString(Constants.transactionsKey);
      
      if (transactionsString != null) {
        final List<dynamic> transactionsJson = json.decode(transactionsString);
        return transactionsJson
            .map((json) => TransactionModel.fromJson(json))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      throw CacheException('Failed to get cached transactions');
    }
  }
} 