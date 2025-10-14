import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/color_constants.dart';
import '../../widgets/custom_button.dart';

/// Entry/Welcome Screen
/// First screen users see with options to login, signup, or browse as guest
class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo/Icon
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: ColorConstants.primaryGreen.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.directions_car,
                  size: 80,
                  color: ColorConstants.primaryGreen,
                ),
              ),

              const SizedBox(height: 40),

              // App Name
              Text(
                'AutoBID',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primaryGreen,
                    ),
              ),

              const SizedBox(height: 12),

              // Tagline
              Text(
                'Your trusted marketplace for\nreused car auctions',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 60),

              // Login Button
              CustomButton(
                text: 'Login',
                onPressed: () => context.go('/login'),
              ),

              const SizedBox(height: 16),

              // Signup Button
              CustomButton(
                text: 'Create Account',
                onPressed: () => context.go('/signup/step1'),
                isOutlined: true,
              ),

              const SizedBox(height: 32),

              // Divider
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 32),

              // Guest Button
              TextButton.icon(
                onPressed: () => context.go('/guest'),
                icon: Icon(
                  Icons.visibility_outlined,
                  color: ColorConstants.primaryGreen,
                ),
                label: Text(
                  'Browse as Guest',
                  style: TextStyle(
                    color: ColorConstants.primaryGreen,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Info Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Limited features available in guest mode',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[500],
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
