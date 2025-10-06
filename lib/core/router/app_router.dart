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
import '../../presentation/screens/auth/signup/signup_step7_review.dart';
import '../../presentation/screens/auth/signup/signup_success_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/kyc/kyc_intro_screen.dart';
import '../../presentation/screens/kyc/kyc_upload_screen.dart';
import '../../presentation/screens/kyc/kyc_status_screen.dart';
import '../../presentation/screens/listings/create/create_listing_step1_basic.dart';
import '../../presentation/screens/listings/create/create_listing_step2_details.dart';
import '../../presentation/screens/listings/create/create_listing_step3_documents.dart';
import '../../presentation/screens/listings/create/create_listing_step4_condition.dart';
import '../../presentation/screens/listings/create/create_listing_step5_photos.dart';
import '../../presentation/screens/listings/create/create_listing_step6_review.dart';
import '../../presentation/screens/listings/create/listing_success_screen.dart';
import '../../presentation/screens/browse/browse_cars_screen.dart';
import '../../presentation/screens/browse/search_screen.dart';
import '../../presentation/screens/browse/car_detail_screen.dart';
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
        builder: (context, state) => const SignupStep7Review(),
      ),
      GoRoute(
        path: '/signup/success',
        name: 'signup-success',
        builder: (context, state) => const SignupSuccessScreen(),
      ),
      GoRoute(
        path: StringConstants.homeRoute,
        name: 'home',
        builder: (context, state) {
          final tabParam = state.uri.queryParameters['tab'];
          final initialTab = tabParam != null ? (int.tryParse(tabParam) ?? 0) : 0;
          return HomeScreen(initialTabIndex: initialTab);
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
      // Listings Routes
      GoRoute(
        path: '/listing/create/step1',
        name: 'create-listing-step1',
        builder: (context, state) => const CreateListingStep1Basic(),
      ),
      GoRoute(
        path: '/listing/create/step2',
        name: 'create-listing-step2',
        builder: (context, state) => const CreateListingStep2Details(),
      ),
      GoRoute(
        path: '/listing/create/step3',
        name: 'create-listing-step3',
        builder: (context, state) => const CreateListingStep3Documents(),
      ),
      GoRoute(
        path: '/listing/create/step4',
        name: 'create-listing-step4',
        builder: (context, state) => const CreateListingStep4Condition(),
      ),
      GoRoute(
        path: '/listing/create/step5',
        name: 'create-listing-step5',
        builder: (context, state) => const CreateListingStep5Photos(),
      ),
      GoRoute(
        path: '/listing/create/step6',
        name: 'create-listing-step6',
        builder: (context, state) => const CreateListingStep6Review(),
      ),
      GoRoute(
        path: '/listing/success',
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
