import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../config/environment.dart';

/// Auth Interceptor for handling authentication tokens
class AuthInterceptor extends Interceptor {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  AuthInterceptor({
    required this.dio,
    required this.secureStorage,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get access token from secure storage
    final accessToken = await secureStorage.read(key: Environment.accessTokenKey);

    // Add authorization header if token exists
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    // Add default headers
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Handle 401 Unauthorized - Token expired
    if (err.response?.statusCode == 401) {
      // Try to refresh token
      final refreshed = await _refreshToken();

      if (refreshed) {
        // Retry the original request
        try {
          final options = err.requestOptions;
          final accessToken = await secureStorage.read(key: Environment.accessTokenKey);
          
          options.headers['Authorization'] = 'Bearer $accessToken';
          
          final response = await dio.fetch(options);
          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        }
      } else {
        // Refresh token failed, clear tokens and redirect to login
        await _clearTokens();
        return handler.next(err);
      }
    }

    return handler.next(err);
  }

  /// Refresh the access token using refresh token
  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await secureStorage.read(key: Environment.refreshTokenKey);

      if (refreshToken == null || refreshToken.isEmpty) {
        return false;
      }

      final response = await dio.post(
        '${Environment.baseUrl}/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['accessToken'];
        final newRefreshToken = response.data['refreshToken'];

        await secureStorage.write(key: Environment.accessTokenKey, value: newAccessToken);
        await secureStorage.write(key: Environment.refreshTokenKey, value: newRefreshToken);

        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  /// Clear all tokens
  Future<void> _clearTokens() async {
    await secureStorage.delete(key: Environment.accessTokenKey);
    await secureStorage.delete(key: Environment.refreshTokenKey);
  }
}
