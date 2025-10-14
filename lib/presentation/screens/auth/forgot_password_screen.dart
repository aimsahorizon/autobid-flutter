import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/color_constants.dart';
import '../../../data/services/mock/mock_auth_service.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import 'otp_verification_screen.dart';
import 'reset_password_screen.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
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

  Future<void> _handleSendOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = ref.read(authServiceProvider);
      final identifier = _identifierController.text.trim();

      // Request password reset OTP
      final result = await authService.requestPasswordResetOtp(identifier);

      if (!mounted) return;

      if (result.success) {
        // Navigate to OTP verification
        final verified = await Navigator.of(context).push<bool>(
          MaterialPageRoute(
            builder: (context) => OtpVerificationScreen(
              identifier: identifier,
              title: 'Reset Password',
              subtitle: 'Enter the verification code sent to',
              debugOtp: result.debugOtp,
              onVerify: (otp) async {
                final verifyResult = await authService.verifyPasswordResetOtp(
                  identifier,
                  otp,
                );

                if (verifyResult.success) {
                  if (mounted) {
                    Navigator.of(context).pop(true);
                  }
                } else {
                  throw Exception(verifyResult.errorMessage);
                }
              },
              onResend: () async {
                final resendResult =
                    await authService.requestPasswordResetOtp(identifier);
                return resendResult.success;
              },
            ),
          ),
        );

        // If OTP verified, navigate to reset password screen
        if (verified == true && mounted) {
          final resetSuccess = await Navigator.of(context).push<bool>(
            MaterialPageRoute(
              builder: (context) => ResetPasswordScreen(
                identifier: identifier,
              ),
            ),
          );

          if (resetSuccess == true && mounted) {
            // Navigate back to login
            Navigator.of(context).popUntil((route) => route.isFirst);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Password reset successfully! Please login.'),
                backgroundColor: ColorConstants.primaryGreen,
              ),
            );
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.errorMessage ?? 'Failed to send OTP'),
            backgroundColor: ColorConstants.error,
          ),
        );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Icon
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ColorConstants.primaryGreen.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lock_reset,
                      size: 60,
                      color: ColorConstants.primaryGreen,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Title
                Center(
                  child: Text(
                    'Reset Your Password',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 12),

                // Description
                Center(
                  child: Text(
                    'Enter your email or phone number and we\'ll send you a verification code to reset your password.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 40),

                // Identifier Input
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

                const SizedBox(height: 30),

                // Send OTP Button
                CustomButton(
                  text: 'Send Verification Code',
                  onPressed: _handleSendOtp,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: 24),

                // Back to Login
                Center(
                  child: TextButton(
                    onPressed: _isLoading
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: Text(
                      'Back to Login',
                      style: TextStyle(
                        color: ColorConstants.primaryGreen,
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
