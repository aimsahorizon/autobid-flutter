import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/providers/kyc_provider.dart';
import 'presentation/providers/signup_provider.dart';
import 'data/services/mock/mock_kyc_service.dart';

void main() {
  runApp(
    provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider(
          create: (_) => KycProvider(MockKycService()),
        ),
        provider.ChangeNotifierProvider(
          create: (_) => SignupProvider(),
        ),
      ],
      child: const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'AutoBID',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
