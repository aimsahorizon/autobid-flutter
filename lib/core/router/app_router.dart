import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/signup_screen.dart';
import '../../presentation/screens/auth/signup/signup_step1_account.dart';
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
import '../../presentation/screens/listings/create/listing_success_screen.dart';
import '../../presentation/screens/browse/browse_cars_screen.dart';
import '../../presentation/screens/browse/search_screen.dart';
import '../../presentation/screens/browse/car_detail_screen.dart';
import '../../presentation/screens/auction/auction_detail_screen.dart';
import '../../presentation/screens/payment/payment_screen.dart';
import '../../presentation/screens/payment/transactions_screen.dart';
import '../../presentation/screens/transaction/transaction_detail_screen.dart';
import '../../presentation/screens/transaction/submit_transfer_evidence_screen.dart';
import '../../presentation/providers/auth_provider.dart';
import '../constants/string_constants.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateChangesProvider);

  return GoRouter(
    initialLocation: StringConstants.splashRoute,
    redirect: (context, state) {
      final isAuthenticated = authState.value != null;
      final isOnSplash = state.uri.path == StringConstants.splashRoute;
      final isOnAuth = state.uri.path == StringConstants.loginRoute ||
          state.uri.path == StringConstants.signupRoute;

      // If authenticated and on auth screens, redirect to home
      if (isAuthenticated && (isOnAuth || isOnSplash)) {
        return StringConstants.homeRoute;
      }

      // If not authenticated and not on auth/splash screens, redirect to login
      if (!isAuthenticated &&
          !isOnAuth &&
          !isOnSplash &&
          authState.hasValue) {
        return StringConstants.loginRoute;
      }

      return null; // No redirect
    },
    routes: [
      GoRoute(
        path: StringConstants.splashRoute,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: StringConstants.loginRoute,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: StringConstants.signupRoute,
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/signup/step1',
        name: 'signup-step1',
        builder: (context, state) => const SignupStep1Account(),
      ),
      GoRoute(
        path: '/signup/step2',
        name: 'signup-step2',
        builder: (context, state) => const SignupStep2Personal(),
      ),
      GoRoute(
        path: '/signup/step3',
        name: 'signup-step3',
        builder: (context, state) => const SignupStep3Address(),
      ),
      GoRoute(
        path: '/signup/step4',
        name: 'signup-step4',
        builder: (context, state) => const SignupStep4PrimaryId(),
      ),
      GoRoute(
        path: '/signup/step5',
        name: 'signup-step5',
        builder: (context, state) => const SignupStep5SecondaryId(),
      ),
      GoRoute(
        path: '/signup/step6',
        name: 'signup-step6',
        builder: (context, state) => const SignupStep6Selfie(),
      ),
      GoRoute(
        path: '/signup/step7',
        name: 'signup-step7',
        builder: (context, state) => const SignupStep7ProofAddress(),
      ),
      GoRoute(
        path: '/signup/step8',
        name: 'signup-step8',
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
          return AuctionDetailScreen(auctionId: auctionId);
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
      // Listings Routes (8 Steps)
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
        path: '/listing/create/success',
        name: 'listing-success',
        builder: (context, state) => const ListingSuccessScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
});
