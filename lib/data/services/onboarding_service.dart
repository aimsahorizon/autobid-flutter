import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing onboarding state and persistence
class OnboardingService {
  static const String _onboardingKey = 'has_completed_onboarding';

  /// Check if user has completed onboarding
  Future<bool> hasCompletedOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  /// Mark onboarding as completed
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  /// Reset onboarding (for testing/debugging)
  Future<void> resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_onboardingKey);
  }
}
