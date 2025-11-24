import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/onboarding_page_model.dart';
import '../../data/services/onboarding_service.dart';

part 'onboarding_provider.g.dart';

/// Provider for onboarding service
@riverpod
OnboardingService onboardingService(Ref ref) {
  return OnboardingService();
}

/// Provider for onboarding completion status
@riverpod
Future<bool> hasCompletedOnboarding(Ref ref) async {
  final service = ref.watch(onboardingServiceProvider);
  return service.hasCompletedOnboarding();
}

/// Sync state provider for onboarding status (for router redirect)
/// This provider is used by the router for synchronous access to onboarding status
@Riverpod(keepAlive: true)
class OnboardingCompleted extends _$OnboardingCompleted {
  @override
  bool build() {
    return false;
  }

  void setCompleted(bool value) {
    state = value;
  }
}

/// Provider for onboarding pages data
@riverpod
List<OnboardingPageModel> onboardingPages(Ref ref) {
  return [
    const OnboardingPageModel(
      id: 'welcome',
      title: 'Welcome to AutoBID',
      description:
          'Your trusted platform for buying and selling pre-owned vehicles through secure online auctions.',
      imagePath: 'assets/images/onboarding/welcome.png',
    ),
    const OnboardingPageModel(
      id: 'browse',
      title: 'Browse Quality Vehicles',
      description:
          'Discover a wide selection of verified pre-owned cars. Filter by brand, model, price range, and more.',
      imagePath: 'assets/images/onboarding/browse.png',
    ),
    const OnboardingPageModel(
      id: 'bid',
      title: 'Place Your Bids',
      description:
          'Participate in real-time auctions or use auto-bidding to secure your dream car at the best price.',
      imagePath: 'assets/images/onboarding/bid.png',
    ),
    const OnboardingPageModel(
      id: 'secure',
      title: 'Secure Transactions',
      description:
          'All transactions are protected with escrow service and verified documentation for your peace of mind.',
      imagePath: 'assets/images/onboarding/secure.png',
    ),
    const OnboardingPageModel(
      id: 'win',
      title: 'Drive Away Happy',
      description:
          'Complete your purchase with confidence and drive away in your new vehicle. Start your journey today!',
      imagePath: 'assets/images/onboarding/win.png',
    ),
  ];
}
