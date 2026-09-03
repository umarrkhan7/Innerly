// lib/core/constants/api_constants.dart
class ApiConstants {
  ApiConstants._();
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.innerly.app',
  );
  static const enableLogging = bool.fromEnvironment('DEBUG_LOGGING', defaultValue: true);
}