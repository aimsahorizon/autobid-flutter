import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/signup_screen.dart';
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
        path: StringConstants.homeRoute,
        name: 'home',
        builder: (context, state) => const Placeholder(), // TODO: Implement HomeScreen
      ),
      GoRoute(
        path: StringConstants.profileRoute,
        name: 'profile',
        builder: (context, state) => const Placeholder(), // TODO: Implement ProfileScreen
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
});
