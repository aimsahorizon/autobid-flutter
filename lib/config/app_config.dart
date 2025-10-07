import 'package:flutter/foundation.dart';

/// Application-wide configuration
///
/// IMPORTANT FOR PRODUCTION:
/// - Set enableDemoData to false when deploying
/// - Update demoUserId to use real authentication
/// - Switch to real backend implementation
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

  // ==================== AUCTION DEMO MODE ====================

  /// Enable demo auction data for development and testing
  ///
  /// When true:
  /// - Mock auctions are pre-populated with user bids
  /// - Watchlist contains sample items
  /// - Won/Lost auction history is generated
  ///
  /// When false:
  /// - Only real user interactions are shown
  /// - Backend data is used
  ///
  /// Default: Enabled in debug mode, disabled in release mode
  static const bool enableDemoData = bool.fromEnvironment(
    'DEMO_MODE',
    defaultValue: kDebugMode,
  );

  /// Demo user ID for testing
  ///
  /// TODO: Replace with real authentication in production
  /// Example: final userId = FirebaseAuth.instance.currentUser?.uid ?? AppConfig.demoUserId;
  static const String demoUserId = 'demo_user_123';

  /// Check if app is running in demo mode
  static bool get isDemoMode => kDebugMode && enableDemoData;
}
