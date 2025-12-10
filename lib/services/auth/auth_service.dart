import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/environment.dart';
import '../../data/models/user_model.dart';
import '../api/api_service.dart';
import '../api/endpoints.dart';

/// Authentication Service
class AuthService {
  final ApiService apiService;
  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  AuthService({
    required this.apiService,
    required this.secureStorage,
    required this.sharedPreferences,
  });

  /// Login (Traveler or Provider)
  Future<ApiResponse<AuthResponse>> login({
    required String email,
    required String password,
    bool isProvider = false,
  }) async {
    final endpoint = isProvider ? ApiEndpoints.providerLogin : ApiEndpoints.login;
    
    final response = await apiService.post<Map<String, dynamic>>(
      endpoint,
      data: {
        'email': email,
        'password': password,
      },
    );

    if (response.success && response.data != null) {
      final authResponse = AuthResponse.fromJson(response.data!);
      await _saveAuthData(authResponse);
      
      return ApiResponse<AuthResponse>(
        success: true,
        data: authResponse,
        message: response.message,
      );
    }

    return ApiResponse<AuthResponse>(
      success: false,
      message: response.message,
      error: response.error,
    );
  }

  /// Register Traveler
  Future<ApiResponse<AuthResponse>> registerTraveler({
    required String fullName,
    required String email,
    required String phone,
    required String country,
    required String preferredLanguage,
    required String password,
  }) async {
    final response = await apiService.post<Map<String, dynamic>>(
      ApiEndpoints.registerTraveler,
      data: {
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'country': country,
        'preferredLanguage': preferredLanguage,
        'password': password,
      },
    );

    if (response.success && response.data != null) {
      final authResponse = AuthResponse.fromJson(response.data!);
      await _saveAuthData(authResponse);
      
      return ApiResponse<AuthResponse>(
        success: true,
        data: authResponse,
        message: response.message,
      );
    }

    return ApiResponse<AuthResponse>(
      success: false,
      message: response.message,
      error: response.error,
    );
  }

  /// Register Provider
  Future<ApiResponse<AuthResponse>> registerProvider({
    required String businessName,
    required String category,
    required String country,
    required String city,
    required String email,
    required String phone,
    required String password,
  }) async {
    final response = await apiService.post<Map<String, dynamic>>(
      ApiEndpoints.registerProvider,
      data: {
        'businessName': businessName,
        'category': category,
        'country': country,
        'city': city,
        'email': email,
        'phone': phone,
        'password': password,
      },
    );

    if (response.success && response.data != null) {
      final authResponse = AuthResponse.fromJson(response.data!);
      await _saveAuthData(authResponse);
      
      return ApiResponse<AuthResponse>(
        success: true,
        data: authResponse,
        message: response.message,
      );
    }

    return ApiResponse<AuthResponse>(
      success: false,
      message: response.message,
      error: response.error,
    );
  }

  /// Forgot Password
  Future<ApiResponse<void>> forgotPassword({required String email}) async {
    final response = await apiService.post(
      ApiEndpoints.forgotPassword,
      data: {'email': email},
    );

    return response;
  }

  /// Logout
  Future<void> logout() async {
    await apiService.post(ApiEndpoints.logout);
    await _clearAuthData();
  }

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final accessToken = await secureStorage.read(key: Environment.accessTokenKey);
    return accessToken != null && accessToken.isNotEmpty;
  }

  /// Get current user type
  Future<String?> getUserType() async {
    return sharedPreferences.getString(Environment.userTypeKey);
  }

  /// Get current user data
  Future<UserModel?> getCurrentUser() async {
    final userDataString = sharedPreferences.getString(Environment.userDataKey);
    
    if (userDataString != null) {
      final userDataJson = jsonDecode(userDataString);
      return UserModel.fromJson(userDataJson);
    }
    
    return null;
  }

  /// Get current provider data
  Future<ProviderModel?> getCurrentProvider() async {
    final providerDataString = sharedPreferences.getString(Environment.userDataKey);
    
    if (providerDataString != null) {
      final providerDataJson = jsonDecode(providerDataString);
      return ProviderModel.fromJson(providerDataJson);
    }
    
    return null;
  }

  /// Save authentication data
  Future<void> _saveAuthData(AuthResponse authResponse) async {
    // Save tokens securely
    await secureStorage.write(
      key: Environment.accessTokenKey,
      value: authResponse.accessToken,
    );
    await secureStorage.write(
      key: Environment.refreshTokenKey,
      value: authResponse.refreshToken,
    );

    // Save user type
    await sharedPreferences.setString(
      Environment.userTypeKey,
      authResponse.userType,
    );

    // Save user/provider data
    if (authResponse.user != null) {
      await sharedPreferences.setString(
        Environment.userDataKey,
        jsonEncode(authResponse.user!.toJson()),
      );
    } else if (authResponse.provider != null) {
      await sharedPreferences.setString(
        Environment.userDataKey,
        jsonEncode(authResponse.provider!.toJson()),
      );
    }
  }

  /// Clear authentication data
  Future<void> _clearAuthData() async {
    await secureStorage.delete(key: Environment.accessTokenKey);
    await secureStorage.delete(key: Environment.refreshTokenKey);
    await sharedPreferences.remove(Environment.userTypeKey);
    await sharedPreferences.remove(Environment.userDataKey);
  }
}
