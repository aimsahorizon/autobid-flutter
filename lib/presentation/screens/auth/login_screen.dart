import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/constants/color_constants.dart';
import '../../../data/models/user_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
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

      // Check account status before proceeding with OTP
      // For pending/rejected accounts, show status dialog immediately
      if (user.accountStatus == AccountStatus.pending) {
        _showPendingStatusDialog();
        return;
      }

      if (user.accountStatus == AccountStatus.rejected) {
        _showRejectedStatusDialog(user.rejectionReason);
        return;
      }

      // Sign out temporarily - OTP verification required for verified/guest accounts
      await authService.signOut();
      if (!mounted) return;

      // Step 2: Request OTPs (only for verified/guest accounts)
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
          // Navigate to home (account status already checked before OTP)
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

  void _showPendingStatusDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.hourglass_empty,
          color: Colors.orange,
          size: 48,
        ),
        title: const Text('Account Pending Review'),
        content: const Text(
          'Your account is currently under review. You have limited access until your KYC verification is approved.\n\n'
          'You can browse listings but cannot participate in auctions or create listings yet.\n\n'
          'Review typically takes 1-3 business days.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/home');
            },
            child: const Text('Continue to Home'),
          ),
        ],
      ),
    );
  }

  void _showRejectedStatusDialog(String? rejectionReason) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.cancel,
          color: ColorConstants.error,
          size: 48,
        ),
        title: const Text('Account Verification Rejected'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your KYC verification has been rejected.',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            if (rejectionReason != null && rejectionReason.isNotEmpty) ...[
              const Text(
                'Reason:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                rejectionReason,
                style: const TextStyle(color: ColorConstants.error),
              ),
              const SizedBox(height: 12),
            ],
            const Text(
              'You can re-submit your verification documents from your profile settings.',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/home');
            },
            child: const Text('Continue to Home'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/profile/kyc');
            },
            child: const Text('Re-submit KYC'),
          ),
        ],
      ),
    );
  }

  void _autoFillCredentials(String email, String password) {
    setState(() {
      _identifierController.text = email;
      _passwordController.text = password;
    });
    _showSuccess('Credentials auto-filled');
  }

  Widget _buildCredentialRow(String email, String password) {
    return InkWell(
      onTap: () => _autoFillCredentials(email, password),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.amber.shade100),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    password,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.login,
              size: 16,
              color: Colors.amber.shade700,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(appThemeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Theme toggle button
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      ref.read(appThemeModeProvider.notifier).toggleTheme();
                    },
                    icon: Icon(
                      isDark ? Icons.light_mode : Icons.dark_mode,
                      color: ColorConstants.primaryGreen,
                    ),
                    tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 32,
                        color: ColorConstants.primaryGreen,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to your AutoBID account',
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
