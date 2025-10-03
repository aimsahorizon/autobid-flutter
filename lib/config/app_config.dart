class AppConfig {
  // Environment
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  static bool get isDevelopment => environment == 'development';
  static bool get isProduction => environment == 'production';

  // API Configuration
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.autobid.com',
  );

  // Firebase Configuration (these should be configured in your Firebase project)
  static const String firebaseApiKey = String.fromEnvironment('FIREBASE_API_KEY');
  static const String firebaseAppId = String.fromEnvironment('FIREBASE_APP_ID');
  static const String firebaseMessagingSenderId = String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID');
  static const String firebaseProjectId = String.fromEnvironment('FIREBASE_PROJECT_ID');

  // Feature Flags
  static const bool enableGoogleSignIn = true;
  static const bool enableAppleSignIn = false;
  static const bool enableBiometrics = true;

  // App Configuration
  static const int requestTimeout = 30; // seconds
  static const int maxRetryAttempts = 3;
}
