import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:send_money_app/core/constants/constants.dart';
import 'package:send_money_app/core/errors/exceptions.dart';
import 'package:send_money_app/features/wallet/data/models/transaction_model.dart';
import 'package:send_money_app/features/wallet/domain/entities/transaction.dart';

abstract class WalletRemoteDataSource {
  Future<TransactionModel> sendMoney(double amount);
  Future<List<TransactionModel>> getTransactions();
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final Dio dio;

  WalletRemoteDataSourceImpl({required this.dio});

  @override
  Future<TransactionModel> sendMoney(double amount) async {
    print('🔥 API CALL: Sending money - Amount: \$$amount');
    try {
      // Simulating API call to JSONPlaceholder
      final response = await dio.post(
        '${Constants.baseUrl}${Constants.transactionsEndpoint}',
        data: json.encode({
          'title': 'Send Money Transaction',
          'body': 'Amount: $amount',
          'userId': 1,
        }),
      );

      if (response.statusCode == 201) {
        // Create a transaction model from the response
        final transaction = TransactionModel(
          id: response.data['id'].toString(),
          amount: amount,
          timestamp: DateTime.now(),
          type: TransactionType.send,
          isSuccess: true,
        );
        return transaction;
      } else {
        throw ServerException('Failed to send money');
      }
    } catch (e) {
      throw ServerException('Failed to send money: ${e.toString()}');
    }
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    print('🔥 API CALL: Getting transactions from ${Constants.baseUrl}${Constants.transactionsEndpoint}');
    try {
      // Simulating getting transactions from JSONPlaceholder
      final response = await dio.get(
        '${Constants.baseUrl}${Constants.transactionsEndpoint}',
      );

      if (response.statusCode == 200) {
        // Create realistic transaction history with mock data
        final List<TransactionModel> transactions = [];
        final random = Random();
        
        // Sample transaction descriptions
        final sendDescriptions = [
          'Payment to John Smith',
          'Transfer to Sarah Johnson',
          'Money sent to Mike Wilson',
          'Payment to Emily Davis',
          'Transfer to David Brown',
        ];
        
        final receiveDescriptions = [
          'Payment from Alex Thompson',
          'Transfer from Lisa Garcia',
          'Money received from Tom Miller',
          'Payment from Rachel Lee',
          'Transfer from Chris Anderson',
        ];
        
        // Create mock transactions from the first 10 posts
        for (int i = 0; i < min(10, response.data.length); i++) {
          final isSend = random.nextBool();
          final amount = 25.0 + random.nextDouble() * 175; // Amounts between $25-$200
          
          transactions.add(
            TransactionModel(
              id: response.data[i]['id'].toString(),
              amount: amount,
              timestamp: DateTime.now().subtract(Duration(
                days: i,
                hours: random.nextInt(24),
                minutes: random.nextInt(60),
              )),
              type: isSend ? TransactionType.send : TransactionType.receive,
              isSuccess: random.nextDouble() > 0.1, // 90% success rate
            ),
          );
        }
        
        print('🔥 API CALL: Created ${transactions.length} mock transactions');
        return transactions;
      } else {
        throw ServerException('Failed to get transactions');
      }
    } catch (e) {
      print('🔥 API CALL: Error getting transactions: ${e.toString()}');
      throw ServerException('Failed to get transactions: ${e.toString()}');
    }
  }
} 