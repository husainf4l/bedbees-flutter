import 'package:dio/dio.dart';

import '../../config/environment.dart';
import 'auth_interceptor.dart';

/// API Service for making HTTP requests
class ApiService {
  final Dio dio;
  final AuthInterceptor authInterceptor;

  ApiService({
    required this.dio,
    required this.authInterceptor,
  }) {
    _configureDio();
  }

  /// Configure Dio instance
  void _configureDio() {
    dio.options = BaseOptions(
      baseUrl: Environment.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );

    // Add interceptors
    dio.interceptors.add(authInterceptor);
    
    // Add logging interceptor in development
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
        error: true,
        logPrint: (obj) => print('[API] $obj'),
      ),
    );
  }

  /// Generic GET request
  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );

      return ApiResponse<T>.fromResponse(response);
    } on DioException catch (e) {
      return ApiResponse<T>.fromError(e);
    } catch (e) {
      return ApiResponse<T>(
        success: false,
        message: 'An unexpected error occurred',
        error: e.toString(),
      );
    }
  }

  /// Generic POST request
  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return ApiResponse<T>.fromResponse(response);
    } on DioException catch (e) {
      return ApiResponse<T>.fromError(e);
    } catch (e) {
      return ApiResponse<T>(
        success: false,
        message: 'An unexpected error occurred',
        error: e.toString(),
      );
    }
  }

  /// Generic PUT request
  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return ApiResponse<T>.fromResponse(response);
    } on DioException catch (e) {
      return ApiResponse<T>.fromError(e);
    } catch (e) {
      return ApiResponse<T>(
        success: false,
        message: 'An unexpected error occurred',
        error: e.toString(),
      );
    }
  }

  /// Generic DELETE request
  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return ApiResponse<T>.fromResponse(response);
    } on DioException catch (e) {
      return ApiResponse<T>.fromError(e);
    } catch (e) {
      return ApiResponse<T>(
        success: false,
        message: 'An unexpected error occurred',
        error: e.toString(),
      );
    }
  }

  /// Upload file
  Future<ApiResponse<T>> uploadFile<T>(
    String endpoint,
    String filePath, {
    Map<String, dynamic>? data,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
        ...?data,
      });

      final response = await dio.post(
        endpoint,
        data: formData,
        onSendProgress: onSendProgress,
      );

      return ApiResponse<T>.fromResponse(response);
    } on DioException catch (e) {
      return ApiResponse<T>.fromError(e);
    } catch (e) {
      return ApiResponse<T>(
        success: false,
        message: 'An unexpected error occurred',
        error: e.toString(),
      );
    }
  }
}

/// API Response wrapper
class ApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final String? error;
  final int? statusCode;

  ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.error,
    this.statusCode,
  });

  /// Create ApiResponse from Dio Response
  factory ApiResponse.fromResponse(Response response) {
    final isSuccess = response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300;

    return ApiResponse<T>(
      success: isSuccess,
      message: response.data['message'] ?? 'Request successful',
      data: response.data['data'] ?? response.data,
      statusCode: response.statusCode,
    );
  }

  /// Create ApiResponse from Dio Error
  factory ApiResponse.fromError(DioException error) {
    String message = 'An error occurred';
    
    if (error.response?.data != null) {
      message = error.response!.data['message'] ?? message;
    } else if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      message = 'Connection timeout. Please try again.';
    } else if (error.type == DioExceptionType.badResponse) {
      message = 'Server error. Please try again later.';
    } else if (error.type == DioExceptionType.cancel) {
      message = 'Request cancelled.';
    } else {
      message = 'Network error. Please check your connection.';
    }

    return ApiResponse<T>(
      success: false,
      message: message,
      error: error.toString(),
      statusCode: error.response?.statusCode,
    );
  }
}
