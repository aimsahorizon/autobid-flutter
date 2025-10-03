import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../constants/string_constants.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: StringConstants.splashRoute,
  routes: [
    GoRoute(
      path: StringConstants.splashRoute,
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: StringConstants.loginRoute,
      name: 'login',
      builder: (context, state) => const Placeholder(), // TODO: Implement LoginScreen
    ),
    GoRoute(
      path: StringConstants.signupRoute,
      name: 'signup',
      builder: (context, state) => const Placeholder(), // TODO: Implement SignupScreen
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
