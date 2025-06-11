import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static final String googleApiKey =
      dotenv.env['google_api_key'] ?? 'AIzaSyDsC9Qkc4tk1fvNl86jPidqM4g0mKGBmWk';
  // API Endpoints
  static const String baseUrl = 'https://api.blinkit.com';

  // Theme Colors
  static const String primaryColor = '#FF6B6B';
  static const String secondaryColor = '#4ECDC4';
  static const String textColor = '#333333';

  // App Version
  static const String appVersion = '1.0.0';
}
