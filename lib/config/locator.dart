import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api/api_service.dart';
import '../services/api/auth_interceptor.dart';
import '../services/auth/auth_service.dart';

final getIt = GetIt.instance;

/// Initialize all dependencies for dependency injection
Future<void> setupLocator() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  
  const secureStorage = FlutterSecureStorage();
  getIt.registerSingleton<FlutterSecureStorage>(secureStorage);

  // Dio instance
  final dio = Dio();
  getIt.registerSingleton<Dio>(dio);

  // Auth Interceptor
  getIt.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(
      dio: getIt<Dio>(),
      secureStorage: getIt<FlutterSecureStorage>(),
    ),
  );

  // API Service
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(
      dio: getIt<Dio>(),
      authInterceptor: getIt<AuthInterceptor>(),
    ),
  );

  // Auth Service
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(
      apiService: getIt<ApiService>(),
      secureStorage: getIt<FlutterSecureStorage>(),
      sharedPreferences: getIt<SharedPreferences>(),
    ),
  );

  // Add more services here as needed
  // Example:
  // getIt.registerLazySingleton<DestinationService>(() => DestinationService(apiService: getIt<ApiService>()));
  // getIt.registerLazySingleton<HotelService>(() => HotelService(apiService: getIt<ApiService>()));
}
