/// Environment configuration for Bedbees app
class Environment {
  static const String _devBaseUrl = 'http://localhost:3000/api';
  static const String _prodBaseUrl = 'https://api.bedbees.com/api';

  static const bool _isDevelopment = true; // Change to false for production

  static String get baseUrl => _isDevelopment ? _devBaseUrl : _prodBaseUrl;
  
  static const String appName = 'Bedbees';
  static const int apiTimeout = 30000; // 30 seconds
  
  // API Keys (Add your actual keys here)
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_KEY';
  static const String openAiApiKey = 'YOUR_OPENAI_KEY';
  
  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userTypeKey = 'user_type';
  static const String userDataKey = 'user_data';
  
  // User Types
  static const String userTypeTraveler = 'traveler';
  static const String userTypeProvider = 'provider';
}
