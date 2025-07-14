import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:send_money_app/features/wallet/data/datasources/wallet_local_data_source.dart';
import 'package:send_money_app/features/wallet/data/datasources/wallet_remote_data_source.dart';
import 'package:send_money_app/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:send_money_app/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:send_money_app/features/wallet/domain/usecases/get_transactions.dart';
import 'package:send_money_app/features/wallet/domain/usecases/get_wallet.dart';
import 'package:send_money_app/features/wallet/domain/usecases/send_money.dart';
import 'package:send_money_app/features/wallet/domain/usecases/toggle_balance_visibility.dart';
import 'package:send_money_app/features/wallet/presentation/cubit/send_money_cubit.dart';
import 'package:send_money_app/features/wallet/presentation/cubit/transactions_cubit.dart';
import 'package:send_money_app/features/wallet/presentation/cubit/wallet_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  sl.registerFactory(
    () => WalletCubit(
      getWallet: sl(),
      toggleBalanceVisibility: sl(),
    ),
  );

  sl.registerFactory(
    () => SendMoneyCubit(sendMoney: sl()),
  );

  sl.registerFactory(
    () => TransactionsCubit(getTransactions: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetWallet(sl()));
  sl.registerLazySingleton(() => ToggleBalanceVisibility(sl()));
  sl.registerLazySingleton(() => SendMoney(sl()));
  sl.registerLazySingleton(() => GetTransactions(sl()));

  // Repository
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<WalletLocalDataSource>(
    () => WalletLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  
  sl.registerLazySingleton(() {
    final dio = Dio();
    
    // Add logging interceptor for debugging
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      logPrint: (object) => print(object),
    ));
    
    return dio;
  });
} 