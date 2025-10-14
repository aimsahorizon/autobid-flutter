import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
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

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> _handlePasswordLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = ref.read(authServiceProvider);

      // Step 1: Validate password (but don't login yet)
      final passwordResult = await authService.signInWithEmail(
        _identifierController.text.trim(),
        _passwordController.text,
      );

      if (!mounted) return;

      if (!passwordResult.success) {
        // Check for account locked
        if (passwordResult.accountLocked) {
          _showAccountLockedDialog(passwordResult.errorMessage);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(passwordResult.errorMessage ?? 'Invalid credentials'),
              backgroundColor: ColorConstants.error,
            ),
          );
        }
        return;
      }

      // Password is valid, now require OTP verification
      final user = passwordResult.user;
      if (user == null) {
        throw Exception('User data not available');
      }

      // Logout temporarily since we need OTP verification first
      await authService.signOut();

      if (!mounted) return;

      // Step 2: Request and verify EMAIL OTP
      final emailOtpResult = await authService.requestLoginOtp(user.email);

      if (!mounted) return;

      if (!emailOtpResult.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(emailOtpResult.errorMessage ?? 'Failed to send email OTP'),
            backgroundColor: ColorConstants.error,
          ),
        );
        return;
      }

      final emailVerified = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (context) => OtpVerificationScreen(
            identifier: user.email,
            title: 'Verify Email',
            subtitle: 'Enter the 6-digit code sent to your email',
            debugOtp: emailOtpResult.debugOtp,
            onVerify: (otp) async {
              final verifyResult = await authService.verifyLoginOtp(
                user.email,
                otp,
              );

              if (verifyResult.success) {
                if (mounted) {
                  Navigator.of(context).pop(true);
                }
              } else {
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
              final resendResult = await authService.requestLoginOtp(user.email);
              return resendResult.success;
            },
          ),
        ),
      );

      if (emailVerified != true || !mounted) return;

      // Step 3: Request and verify PHONE OTP
      if (user.phoneNumber == null || user.phoneNumber!.isEmpty) {
        // No phone number, complete login
        await authService.signInWithEmail(
          _identifierController.text.trim(),
          _passwordController.text,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login successful!'),
              backgroundColor: ColorConstants.primaryGreen,
            ),
          );
        }
        return;
      }

      final phoneOtpResult = await authService.requestLoginOtp(user.phoneNumber!);

      if (!mounted) return;

      if (!phoneOtpResult.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(phoneOtpResult.errorMessage ?? 'Failed to send phone OTP'),
            backgroundColor: ColorConstants.error,
          ),
        );
        return;
      }

      final phoneVerified = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (context) => OtpVerificationScreen(
            identifier: user.phoneNumber!,
            title: 'Verify Phone Number',
            subtitle: 'Enter the 6-digit code sent to your phone',
            debugOtp: phoneOtpResult.debugOtp,
            onVerify: (otp) async {
              final verifyResult = await authService.verifyLoginOtp(
                user.phoneNumber!,
                otp,
              );

              if (verifyResult.success) {
                if (mounted) {
                  Navigator.of(context).pop(true);
                }
              } else {
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
              final resendResult = await authService.requestLoginOtp(user.phoneNumber!);
              return resendResult.success;
            },
          ),
        ),
      );

      if (phoneVerified != true || !mounted) return;

      // Step 4: Both OTPs verified, complete login
      await authService.signInWithEmail(
        _identifierController.text.trim(),
        _passwordController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login successful!'),
            backgroundColor: ColorConstants.primaryGreen,
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

  Widget _buildCredentialRow(String email, String password) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      email,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: email));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Email copied'),
                          duration: Duration(seconds: 1),
                          backgroundColor: ColorConstants.primaryGreen,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        Icons.copy,
                        size: 14,
                        color: Colors.amber.shade700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      password,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: password));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Password copied'),
                          duration: Duration(seconds: 1),
                          backgroundColor: ColorConstants.primaryGreen,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        Icons.copy,
                        size: 14,
                        color: Colors.amber.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
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
                  'Enter credentials and verify with OTP',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: _identifierController,
                  label: 'Email or Phone Number',
                  hint: 'Enter your email or phone',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: _validateIdentifier,
                  textInputAction: TextInputAction.next,
                  enabled: !_isLoading,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Enter your password',
                  obscureText: _obscurePassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: _validatePassword,
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
                  text: 'Login',
                  onPressed: _handlePasswordLogin,
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
                const SizedBox(height: 24),
                // Test Credentials Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.amber.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.amber.shade700,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Test Credentials',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.amber.shade900,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildCredentialRow('test@autobid.com', 'Test123'),
                      const SizedBox(height: 8),
                      _buildCredentialRow('pending@autobid.com', 'Test123'),
                      const SizedBox(height: 8),
                      _buildCredentialRow('rejected@autobid.com', 'Test123'),
                      const SizedBox(height: 8),
                      _buildCredentialRow('demo@autobid.com', 'Demo123'),
                    ],
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
