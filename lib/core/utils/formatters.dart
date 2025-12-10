import 'package:intl/intl.dart';

/// Date formatting utilities
class DateFormatter {
  /// Format date to 'MMM dd, yyyy' (e.g., 'Jan 15, 2024')
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }
  
  /// Format date to 'dd/MM/yyyy'
  static String formatDateShort(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
  
  /// Format date to 'EEEE, MMMM dd, yyyy' (e.g., 'Monday, January 15, 2024')
  static String formatDateLong(DateTime date) {
    return DateFormat('EEEE, MMMM dd, yyyy').format(date);
  }
  
  /// Format time to 'hh:mm a' (e.g., '02:30 PM')
  static String formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }
  
  /// Format date and time to 'MMM dd, yyyy at hh:mm a'
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy at hh:mm a').format(dateTime);
  }
  
  /// Get relative time (e.g., '2 hours ago', 'Yesterday')
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }
}

/// Currency formatting utilities
class CurrencyFormatter {
  /// Format amount to currency (e.g., '$1,234.56')
  static String format(double amount, {String symbol = '\$', int decimals = 2}) {
    final formatter = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimals,
    );
    return formatter.format(amount);
  }
  
  /// Format amount without symbol (e.g., '1,234.56')
  static String formatWithoutSymbol(double amount, {int decimals = 2}) {
    final formatter = NumberFormat.decimalPattern();
    return formatter.format(amount);
  }
}

/// String utilities
class StringUtils {
  /// Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
  
  /// Capitalize each word
  static String capitalizeWords(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) => capitalize(word)).join(' ');
  }
  
  /// Truncate text with ellipsis
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
  
  /// Remove HTML tags
  static String removeHtmlTags(String text) {
    final regex = RegExp(r'<[^>]*>');
    return text.replaceAll(regex, '');
  }
}
