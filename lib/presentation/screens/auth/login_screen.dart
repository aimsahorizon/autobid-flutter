import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/constants/color_constants.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import 'login_dual_otp_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
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

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
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

    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      final identifier = _identifierController.text.trim();
      final password = _passwordController.text;

      // Step 1: Validate credentials
      final passwordResult = await authService.signInWithEmail(identifier, password);

      if (!mounted) return;

      if (!passwordResult.success) {
        if (passwordResult.accountLocked) {
          _showAccountLockedDialog(passwordResult.errorMessage);
        } else {
          _showError(passwordResult.errorMessage ?? 'Invalid credentials');
        }
        return;
      }

      final user = passwordResult.user;
      if (user == null) {
        _showError('User data not available');
        return;
      }

      // Sign out temporarily - OTP verification required
      await authService.signOut();
      if (!mounted) return;

      // Step 2: Request OTPs
      final emailOtpResult = await authService.requestLoginOtp(user.email);
      if (!emailOtpResult.success) {
        _showError(emailOtpResult.errorMessage ?? 'Failed to send email OTP');
        return;
      }

      String? debugPhoneOtp;
      if (user.phoneNumber != null && user.phoneNumber!.isNotEmpty) {
        final phoneOtpResult = await authService.requestLoginOtp(user.phoneNumber!);
        if (!phoneOtpResult.success) {
          _showError(phoneOtpResult.errorMessage ?? 'Failed to send phone OTP');
          return;
        }
        debugPhoneOtp = phoneOtpResult.debugOtp;
      }

      if (!mounted) return;

      // Step 3: Show dual OTP verification screen
      final verified = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (context) => LoginDualOtpScreen(
            email: user.email,
            phoneNumber: user.phoneNumber,
            debugEmailOtp: emailOtpResult.debugOtp,
            debugPhoneOtp: debugPhoneOtp,
            onVerifyEmail: (otp) async {
              final result = await authService.otpService.verifyOtp(
                identifier: user.email,
                otp: otp,
              );
              if (!result.success) {
                throw Exception(result.errorMessage ?? 'Invalid email OTP');
              }
            },
            onVerifyPhone: (otp) async {
              final result = await authService.otpService.verifyOtp(
                identifier: user.phoneNumber!,
                otp: otp,
              );
              if (!result.success) {
                throw Exception(result.errorMessage ?? 'Invalid phone OTP');
              }
            },
            onResendEmail: () async {
              final result = await authService.requestLoginOtp(user.email);
              return result.success;
            },
            onResendPhone: () async {
              final result = await authService.requestLoginOtp(user.phoneNumber!);
              return result.success;
            },
          ),
        ),
      );

      if (verified != true || !mounted) return;

      // Step 4: Complete login
      final loginResult = await authService.signInWithEmail(identifier, password);

      if (!mounted) return;

      if (loginResult.success) {
        _showSuccess('Login successful!');
        // Small delay for user to see success message
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          context.go('/home');
        }
      } else {
        _showError(loginResult.errorMessage ?? 'Login failed');
      }
    } catch (e) {
      if (mounted) {
        _showError('Error: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ColorConstants.error,
      ),
    );
  }

  void _showSuccess(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ColorConstants.primaryGreen,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showAccountLockedDialog(String? message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.lock,
          color: ColorConstants.error,
          size: 48,
        ),
        title: const Text('Account Locked'),
        content: Text(
          message ?? 'Your account has been locked due to too many failed attempts.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Contact Support'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
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
                      _showSuccess('Email copied');
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
                      _showSuccess('Password copied');
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
                      setState(() => _obscurePassword = !_obscurePassword);
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
                    onPressed: _isLoading ? null : () => context.push('/forgot-password'),
                    child: const Text(
                      StringConstants.forgotPassword,
                      style: TextStyle(color: ColorConstants.primaryGreen),
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
                      onPressed: _isLoading ? null : () => context.go('/signup/step1'),
                      child: const Text(
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
                    onPressed: _isLoading ? null : () => context.go('/guest'),
                    child: const Text(
                      'Continue as Guest',
                      style: TextStyle(
                        color: ColorConstants.primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
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
