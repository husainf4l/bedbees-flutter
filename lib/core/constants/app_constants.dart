/// App Constants
class AppConstants {
  // App Info
  static const String appName = 'Bedbees';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Your Travel Companion';
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Image Sizes
  static const double maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int imageQuality = 85;
  
  // Timeout
  static const Duration requestTimeout = Duration(seconds: 30);
  static const Duration connectionTimeout = Duration(seconds: 30);
  
  // Debounce
  static const Duration searchDebounce = Duration(milliseconds: 500);
  
  // Supported Languages
  static const List<String> supportedLanguages = [
    'English',
    'Arabic',
    'French',
    'Spanish',
    'German',
    'Italian',
    'Portuguese',
    'Russian',
    'Chinese',
    'Japanese',
  ];
  
  // Business Categories
  static const List<String> businessCategories = [
    'Hotel',
    'Car Rental',
    'Tour Guide',
    'Taxi Company',
    'Tour Operator',
    'Vacation Rental',
    'Walking Tour Guide',
  ];
  
  // Destination Categories
  static const List<String> destinationCategories = [
    'Beaches',
    'Mountains',
    'Cities',
    'Nature',
    'Historic',
    'Islands',
    'Desert',
    'Countryside',
  ];
  
  // Trip Types
  static const List<String> tripTypes = [
    'Adventure',
    'Relaxation',
    'Cultural',
    'Family',
    'Romantic',
    'Business',
    'Solo',
    'Group',
  ];
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int minNameLength = 2;
  static const int maxNameLength = 100;
  static const int minDescriptionLength = 10;
  static const int maxDescriptionLength = 5000;
  
  // Regex Patterns
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phonePattern = r'^\+?[1-9]\d{1,14}$';
  static const String urlPattern = r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$';
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Cache Duration
  static const Duration shortCache = Duration(minutes: 5);
  static const Duration mediumCache = Duration(hours: 1);
  static const Duration longCache = Duration(days: 1);
}
