import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/constants/color_constants.dart';
import '../../../data/services/mock/mock_auth_service.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import 'otp_verification_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController(); // Email or phone
  bool _isLoading = false;

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  String? _validateIdentifier(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email or phone number is required';
    }

    // Check if it's email or phone
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');

    if (!emailRegex.hasMatch(value) && !phoneRegex.hasMatch(value)) {
      return 'Enter a valid email or phone number';
    }
    return null;
  }

  Future<void> _handleRequestOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = ref.read(authServiceProvider);
      final result = await authService.requestLoginOtp(
        _identifierController.text.trim(),
      );

      if (!mounted) return;

      if (result.success) {
        // Navigate to OTP verification screen
        final verified = await Navigator.of(context).push<bool>(
          MaterialPageRoute(
            builder: (context) => OtpVerificationScreen(
              identifier: _identifierController.text.trim(),
              title: 'Verify Your Identity',
              subtitle: 'Enter the 6-digit code sent to',
              debugOtp: result.debugOtp,
              onVerify: (otp) async {
                final verifyResult = await authService.verifyLoginOtp(
                  _identifierController.text.trim(),
                  otp,
                );

                if (verifyResult.success) {
                  if (mounted) {
                    Navigator.of(context).pop(true);
                  }
                } else {
                  // Show account locked dialog if needed
                  if (verifyResult.accountLocked) {
                    if (mounted) {
                      _showAccountLockedDialog(verifyResult.errorMessage);
                      Navigator.of(context).pop(false);
                    }
                  }
                  throw Exception(verifyResult.errorMessage);
                }
              },
              onResend: () async {
                final resendResult = await authService.requestLoginOtp(
                  _identifierController.text.trim(),
                );
                return resendResult.success;
              },
            ),
          ),
        );

        if (verified == true && mounted) {
          // Successfully logged in - router will handle navigation
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login successful!'),
              backgroundColor: ColorConstants.primaryGreen,
            ),
          );
        }
      } else {
        // Check for account locked
        if (result.accountLocked) {
          _showAccountLockedDialog(result.errorMessage);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result.errorMessage ?? 'Failed to send OTP'),
              backgroundColor: ColorConstants.error,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: ColorConstants.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showAccountLockedDialog(String? message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.lock,
          color: ColorConstants.error,
          size: 48,
        ),
        title: Text('Account Locked'),
        content: Text(
          message ?? 'Your account has been locked due to too many failed attempts.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Navigate to support/contact page
            },
            child: Text('Contact Support'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleGoogleSignIn() async {
    await ref.read(loginStateProvider.notifier).signInWithGoogle();

    if (mounted) {
      final loginState = ref.read(loginStateProvider);
      loginState.when(
        data: (_) {
          // Success - navigation handled by router
        },
        loading: () {},
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: ColorConstants.error,
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 32,
                        color: ColorConstants.primaryGreen,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your email or phone to receive OTP',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  controller: _identifierController,
                  label: 'Email or Phone Number',
                  hint: 'Enter your email or phone',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: _validateIdentifier,
                  textInputAction: TextInputAction.done,
                  enabled: !_isLoading,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _isLoading
                        ? null
                        : () => context.push('/forgot-password'),
                    child: Text(
                      StringConstants.forgotPassword,
                      style: TextStyle(
                        color: ColorConstants.primaryGreen,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Send OTP',
                  onPressed: _handleRequestOtp,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: _isLoading
                          ? null
                          : () => context.go('/signup/step1'),
                      child: Text(
                        StringConstants.signup,
                        style: TextStyle(
                          color: ColorConstants.primaryGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: _isLoading
                        ? null
                        : () => context.go('/guest'),
                    child: Text(
                      'Continue as Guest',
                      style: TextStyle(
                        color: ColorConstants.primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
