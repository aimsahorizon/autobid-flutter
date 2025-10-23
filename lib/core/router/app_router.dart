import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/auth/entry_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/forgot_password_screen.dart';
import '../../presentation/screens/auth/signup_screen.dart';
import '../../presentation/screens/auth/signup/signup_step1_account.dart';
import '../../presentation/screens/auth/signup/signup_step2_otp.dart';
import '../../presentation/screens/auth/signup/signup_step2_personal.dart';
import '../../presentation/screens/auth/signup/signup_step3_address.dart';
import '../../presentation/screens/auth/signup/signup_step4_primary_id.dart';
import '../../presentation/screens/auth/signup/signup_step5_secondary_id.dart';
import '../../presentation/screens/auth/signup/signup_step6_selfie.dart';
import '../../presentation/screens/auth/signup/signup_step7_proof_address.dart';
import '../../presentation/screens/auth/signup/signup_step8_review.dart';
import '../../presentation/screens/auth/signup/signup_success_screen.dart';
import '../../presentation/screens/verification/verification_levels_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/profile/edit_profile_screen.dart';
import '../../presentation/screens/profile/security_settings_screen.dart';
import '../../presentation/screens/profile/help_support_screen.dart';
import '../../presentation/screens/kyc/kyc_intro_screen.dart';
import '../../presentation/screens/kyc/kyc_upload_screen.dart';
import '../../presentation/screens/kyc/kyc_status_screen.dart';
import '../../presentation/screens/listings/create/create_listing_step1_basic.dart';
import '../../presentation/screens/listings/create/create_listing_step2_mechanical.dart';
import '../../presentation/screens/listings/create/create_listing_step3_dimensions.dart';
import '../../presentation/screens/listings/create/create_listing_step4_exterior.dart';
import '../../presentation/screens/listings/create/create_listing_step5_condition.dart';
import '../../presentation/screens/listings/create/create_listing_step6_documentation.dart';
import '../../presentation/screens/listings/create/create_listing_step7_photos.dart';
import '../../presentation/screens/listings/create/create_listing_step8_review.dart';
import '../../presentation/screens/listings/create/create_listing_step9_summary.dart';
import '../../presentation/screens/listings/create/listing_success_screen.dart';
import '../../presentation/screens/browse/browse_cars_screen.dart';
import '../../presentation/screens/browse/search_screen.dart';
import '../../presentation/screens/browse/car_detail_screen.dart';
import '../../presentation/screens/auction/auction_detail_screen.dart';
import '../../presentation/screens/seller/seller_auction_detail_screen.dart';
import '../../presentation/screens/payment/payment_screen.dart';
import '../../presentation/screens/deposit/deposit_payment_screen.dart';
import '../../presentation/screens/payment/transactions_screen.dart';
import '../../presentation/screens/transaction/transaction_detail_screen.dart';
import '../../presentation/screens/transaction/submit_transfer_evidence_screen.dart';
import '../../presentation/screens/transaction/request_refund_screen.dart';
import '../../presentation/screens/review/submit_review_screen.dart';
import '../../presentation/screens/review/seller_reviews_screen.dart';
import '../../presentation/screens/notifications/notifications_screen.dart';
import '../../presentation/screens/guest/guest_view_screen.dart';
import '../../presentation/screens/admin/admin_debug_panel.dart';
import '../../presentation/screens/pre_transaction/pre_transaction_discussion_screen.dart';
import '../../presentation/screens/pre_transaction/pre_transaction_confirmation_form_screen.dart';
import '../../presentation/screens/pre_transaction/pre_transaction_status_screen.dart';
import '../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../presentation/screens/listings/my_listings/sold_listing_detail_screen.dart';
import '../../presentation/screens/listings/my_listings/cancelled_listing_detail_screen.dart';
import '../../presentation/screens/listings/my_listings/pending_listing_detail_screen.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/providers/onboarding_provider.dart';
import '../constants/string_constants.dart';

/// Helper class to refresh GoRouter when auth state changes
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (_) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final authService = ref.watch(authServiceProvider);

  return GoRouter(
    initialLocation: StringConstants.splashRoute,
    refreshListenable: GoRouterRefreshStream(
      authService.authStateChanges,
    ),
    redirect: (context, state) {
      // Optimized: Cache frequently accessed values
      final path = state.uri.path;
      final authState = ref.read(authStateChangesProvider);
      final isAuthenticated = authState.value != null;

      // Early return: Skip redirect check for already-authenticated deep links
      if (isAuthenticated && !path.startsWith('/auth') && !path.startsWith('/splash') && !path.startsWith('/onboarding')) {
        return null;
      }

      // Cache route checks (avoid repeated string comparisons)
      final isOnSplash = path == StringConstants.splashRoute;
      final isOnOnboarding = path == StringConstants.onboardingRoute;
      final isOnAuth = path == StringConstants.loginRoute || path == StringConstants.signupRoute;

      // Check onboarding status (sync)
      final hasCompletedOnboarding = ref.read(onboardingCompletedProvider);

      // Redirect logic with early returns
      if (!hasCompletedOnboarding && !isOnSplash && !isOnOnboarding) {
        return StringConstants.onboardingRoute;
      }

      if (isAuthenticated && (isOnAuth || isOnSplash || isOnOnboarding)) {
        return StringConstants.homeRoute;
      }

      if (!isAuthenticated && !isOnAuth && !isOnSplash && !isOnOnboarding && authState.hasValue) {
        return StringConstants.loginRoute;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: StringConstants.splashRoute,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: StringConstants.onboardingRoute,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/entry',
        name: 'entry',
        builder: (context, state) => const EntryScreen(),
      ),
      GoRoute(
        path: StringConstants.loginRoute,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: StringConstants.signupRoute,
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/signup/step1',
        name: 'signup-step1',
        builder: (context, state) => const SignupStep2Personal(),
      ),
      GoRoute(
        path: '/signup/step2',
        name: 'signup-step2',
        builder: (context, state) => const SignupStep1Account(),
      ),
      GoRoute(
        path: '/signup/step3',
        name: 'signup-step3-otp',
        builder: (context, state) => const SignupStep2Otp(),
      ),
      GoRoute(
        path: '/signup/step4',
        name: 'signup-step4-address',
        builder: (context, state) => const SignupStep3Address(),
      ),
      GoRoute(
        path: '/signup/step5',
        name: 'signup-step5-primary',
        builder: (context, state) => const SignupStep4PrimaryId(),
      ),
      GoRoute(
        path: '/signup/step6',
        name: 'signup-step6-secondary',
        builder: (context, state) => const SignupStep5SecondaryId(),
      ),
      GoRoute(
        path: '/signup/step7',
        name: 'signup-step7-selfie',
        builder: (context, state) => const SignupStep6Selfie(),
      ),
      GoRoute(
        path: '/signup/step8',
        name: 'signup-step8-proof',
        builder: (context, state) => const SignupStep7ProofAddress(),
      ),
      GoRoute(
        path: '/signup/step9',
        name: 'signup-step9-review',
        builder: (context, state) => const SignupStep8Review(),
      ),
      GoRoute(
        path: '/signup/success',
        name: 'signup-success',
        builder: (context, state) => const SignupSuccessScreen(),
      ),
      GoRoute(
        path: '/verification-levels',
        name: 'verification-levels',
        builder: (context, state) => const VerificationLevelsScreen(),
      ),
      GoRoute(
        path: StringConstants.homeRoute,
        name: 'home',
        builder: (context, state) {
          final tabParam = state.uri.queryParameters['tab'];
          final subTabParam = state.uri.queryParameters['subTab'];
          final initialTab = tabParam != null ? (int.tryParse(tabParam) ?? 0) : 0;
          final initialSubTab = subTabParam != null ? (int.tryParse(subTabParam) ?? 0) : 0;
          return HomeScreen(
            initialTabIndex: initialTab,
            initialSubTabIndex: initialSubTab,
          );
        },
      ),
      GoRoute(
        path: StringConstants.profileRoute,
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/profile/edit',
        name: 'edit-profile',
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/profile/security',
        name: 'security-settings',
        builder: (context, state) => const SecuritySettingsScreen(),
      ),
      GoRoute(
        path: '/profile/help',
        name: 'help-support',
        builder: (context, state) => const HelpSupportScreen(),
      ),
      GoRoute(
        path: '/kyc-intro',
        name: 'kyc-intro',
        builder: (context, state) => const KycIntroScreen(),
      ),
      GoRoute(
        path: '/kyc-upload',
        name: 'kyc-upload',
        builder: (context, state) => const KycUploadScreen(),
      ),
      GoRoute(
        path: '/kyc-status',
        name: 'kyc-status',
        builder: (context, state) => const KycStatusScreen(),
      ),
      // Browse & Search Routes
      GoRoute(
        path: '/browse',
        name: 'browse',
        builder: (context, state) => const BrowseCarsScreen(),
      ),
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/car/:id',
        name: 'car-detail',
        builder: (context, state) {
          final carId = state.pathParameters['id']!;
          return CarDetailScreen(carId: carId);
        },
      ),
      GoRoute(
        path: '/watchlist',
        name: 'watchlist',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Watchlist Screen')),
        ),
      ),
      // Auction Routes
      GoRoute(
        path: '/auction/:id',
        name: 'auction',
        builder: (context, state) {
          final auctionId = state.pathParameters['id']!;
          final isSeller = state.uri.queryParameters['isSeller'] == 'true';
          final isCarId = state.uri.queryParameters['isCarId'] == 'true';
          return AuctionDetailScreen(
            auctionId: auctionId,
            isSeller: isSeller,
            isCarId: isCarId,
          );
        },
      ),
      // Seller Auction Management Route
      GoRoute(
        path: '/seller/auction/:id',
        name: 'seller-auction',
        builder: (context, state) {
          final auctionId = state.pathParameters['id']!;
          final isCarId = state.uri.queryParameters['isCarId'] == 'true';
          return SellerAuctionDetailScreen(
            auctionId: auctionId,
            isCarId: isCarId,
          );
        },
      ),
      // Pre-Transaction Routes
      GoRoute(
        path: '/preTransaction/:auctionId',
        name: 'preTransaction',
        builder: (context, state) {
          final auctionId = state.pathParameters['auctionId']!;
          final carTitle = state.uri.queryParameters['carTitle'] ?? 'Vehicle';
          final winningBid = double.tryParse(
                  state.uri.queryParameters['winningBid'] ?? '0') ??
              0;
          final isSeller = state.uri.queryParameters['isSeller'] == 'true';
          return PreTransactionDiscussionScreen(
            auctionId: auctionId,
            carTitle: carTitle,
            winningBid: winningBid,
            isSeller: isSeller,
          );
        },
      ),
      GoRoute(
        path: '/preTransactionForm/:auctionId',
        name: 'preTransactionForm',
        builder: (context, state) {
          final auctionId = state.pathParameters['auctionId']!;
          final carTitle = state.uri.queryParameters['carTitle'] ?? 'Vehicle';
          final winningBid = double.tryParse(
                  state.uri.queryParameters['winningBid'] ?? '0') ??
              0;
          return PreTransactionConfirmationFormScreen(
            auctionId: auctionId,
            carTitle: carTitle,
            winningBid: winningBid,
          );
        },
      ),
      GoRoute(
        path: '/preTransactionStatus/:auctionId',
        name: 'preTransactionStatus',
        builder: (context, state) {
          final auctionId = state.pathParameters['auctionId']!;
          final carTitle = state.uri.queryParameters['carTitle'] ?? 'Vehicle';
          final winningBid = double.tryParse(
                  state.uri.queryParameters['winningBid'] ?? '0') ??
              0;
          return PreTransactionStatusScreen(
            auctionId: auctionId,
            carTitle: carTitle,
            winningBid: winningBid,
          );
        },
      ),
      // Payment Routes
      GoRoute(
        path: '/payment/:auctionId',
        name: 'payment',
        builder: (context, state) {
          final auctionId = state.pathParameters['auctionId']!;
          final carTitle = state.uri.queryParameters['carTitle'] ?? 'Vehicle';
          final winningBid = double.tryParse(
                  state.uri.queryParameters['winningBid'] ?? '0') ??
              0;
          return PaymentScreen(
            auctionId: auctionId,
            carTitle: carTitle,
            winningBid: winningBid,
          );
        },
      ),
      GoRoute(
        path: '/deposit/payment',
        name: 'deposit-payment',
        builder: (context, state) => const DepositPaymentScreen(),
      ),
      GoRoute(
        path: '/transaction/:id',
        name: 'transaction',
        builder: (context, state) {
          final transactionId = state.pathParameters['id']!;
          return TransactionDetailScreen(transactionId: transactionId);
        },
      ),
      GoRoute(
        path: '/transactions',
        name: 'transactions',
        builder: (context, state) => const TransactionsScreen(),
      ),
      GoRoute(
        path: '/submit-evidence/:transactionId',
        name: 'submit-evidence',
        builder: (context, state) {
          final transactionId = state.pathParameters['transactionId']!;
          final carTitle = state.uri.queryParameters['carTitle'] ?? 'Unknown Vehicle';
          return SubmitTransferEvidenceScreen(
            transactionId: transactionId,
            carTitle: carTitle,
          );
        },
      ),
      GoRoute(
        path: '/request-refund/:transactionId',
        name: 'request-refund',
        builder: (context, state) {
          final transactionId = state.pathParameters['transactionId']!;
          final carTitle = state.uri.queryParameters['carTitle'] ?? 'Unknown Vehicle';
          return RequestRefundScreen(
            transactionId: transactionId,
            carTitle: carTitle,
          );
        },
      ),
      GoRoute(
        path: '/submit-review/:transactionId',
        name: 'submit-review',
        builder: (context, state) {
          final transactionId = state.pathParameters['transactionId']!;
          final carTitle = state.uri.queryParameters['carTitle'] ?? 'Unknown Vehicle';
          final sellerName = state.uri.queryParameters['sellerName'] ?? 'Unknown Seller';
          return SubmitReviewScreen(
            transactionId: transactionId,
            carTitle: carTitle,
            sellerName: sellerName,
          );
        },
      ),
      GoRoute(
        path: '/seller-reviews/:sellerId',
        name: 'seller-reviews',
        builder: (context, state) {
          final sellerId = state.pathParameters['sellerId']!;
          final sellerName = state.uri.queryParameters['sellerName'] ?? 'Seller';
          return SellerReviewsScreen(
            sellerId: sellerId,
            sellerName: sellerName,
          );
        },
      ),
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/guest',
        name: 'guest',
        builder: (context, state) {
          final tabParam = state.uri.queryParameters['tab'];
          final initialTab = tabParam != null ? (int.tryParse(tabParam) ?? 0) : 0;
          return GuestViewScreen(initialTab: initialTab);
        },
      ),
      GoRoute(
        path: '/admin-debug',
        name: 'admin-debug',
        builder: (context, state) => const AdminDebugPanel(),
      ),
      // Listings Routes (9 Steps)
      GoRoute(
        path: '/listing/create/step1',
        name: 'create-listing-step1',
        builder: (context, state) => const CreateListingStep1Basic(),
      ),
      GoRoute(
        path: '/listing/create/step2',
        name: 'create-listing-step2',
        builder: (context, state) => const CreateListingStep2Mechanical(),
      ),
      GoRoute(
        path: '/listing/create/step3',
        name: 'create-listing-step3',
        builder: (context, state) => const CreateListingStep3Dimensions(),
      ),
      GoRoute(
        path: '/listing/create/step4',
        name: 'create-listing-step4',
        builder: (context, state) => const CreateListingStep4Exterior(),
      ),
      GoRoute(
        path: '/listing/create/step5',
        name: 'create-listing-step5',
        builder: (context, state) => const CreateListingStep5Condition(),
      ),
      GoRoute(
        path: '/listing/create/step6',
        name: 'create-listing-step6',
        builder: (context, state) => const CreateListingStep6Documentation(),
      ),
      GoRoute(
        path: '/listing/create/step7',
        name: 'create-listing-step7',
        builder: (context, state) => const CreateListingStep7Photos(),
      ),
      GoRoute(
        path: '/listing/create/step8',
        name: 'create-listing-step8',
        builder: (context, state) => const CreateListingStep8Review(),
      ),
      GoRoute(
        path: '/listing/create/step9',
        name: 'create-listing-step9',
        builder: (context, state) => const CreateListingStep9Summary(),
      ),
      GoRoute(
        path: '/listing/create/success',
        name: 'listing-success',
        builder: (context, state) => const ListingSuccessScreen(),
      ),
      // My Listings Detail Routes
      GoRoute(
        path: '/listing/pending/:id',
        name: 'pending-listing-detail',
        builder: (context, state) {
          final carId = state.pathParameters['id']!;
          return PendingListingDetailScreen(carId: carId);
        },
      ),
      GoRoute(
        path: '/listing/sold/:id',
        name: 'sold-listing-detail',
        builder: (context, state) {
          final carId = state.pathParameters['id']!;
          return SoldListingDetailScreen(carId: carId);
        },
      ),
      GoRoute(
        path: '/listing/cancelled/:id',
        name: 'cancelled-listing-detail',
        builder: (context, state) {
          final carId = state.pathParameters['id']!;
          return CancelledListingDetailScreen(carId: carId);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
});
