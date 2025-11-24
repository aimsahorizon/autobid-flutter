import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/constants/color_constants.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Phone is optional
    }
    final phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
    final cleanedPhone = value.replaceAll(RegExp(r'[\s-]'), '');
    if (!phoneRegex.hasMatch(cleanedPhone)) {
      return 'Enter a valid phone number';
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
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain an uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain a lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain a number';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  double _getPasswordStrength(String password) {
    if (password.isEmpty) return 0.0;

    int strength = 0;
    if (password.length >= 6) strength++;
    if (password.length >= 8) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength++;
    if (RegExp(r'[a-z]').hasMatch(password)) strength++;
    if (RegExp(r'[0-9]').hasMatch(password)) strength++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) strength++;

    return strength / 6;
  }

  Color _getPasswordStrengthColor(double strength) {
    if (strength < 0.33) return ColorConstants.error;
    if (strength < 0.66) return ColorConstants.warning;
    return ColorConstants.success;
  }

  String _getPasswordStrengthText(double strength) {
    if (strength < 0.33) return 'Weak';
    if (strength < 0.66) return 'Medium';
    return 'Strong';
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms and conditions'),
          backgroundColor: ColorConstants.error,
        ),
      );
      return;
    }

    await ref.read(signupStateProvider.notifier).signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          fullName: _fullNameController.text.trim(),
          phoneNumber: _phoneController.text.trim().isNotEmpty
              ? _phoneController.text.trim()
              : null,
        );

    if (mounted) {
      final signupState = ref.read(signupStateProvider);
      signupState.when(
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

  Future<void> _handleGoogleSignUp() async {
    await ref.read(signupStateProvider.notifier).signUpWithGoogle();

    if (mounted) {
      final signupState = ref.read(signupStateProvider);
      signupState.when(
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
    final signupState = ref.watch(signupStateProvider);
    final isLoading = signupState.isLoading;

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
                  'Create Account',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 32,
                        color: ColorConstants.primaryGreen,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign up to get started',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  controller: _fullNameController,
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: _validateFullName,
                  textInputAction: TextInputAction.next,
                  enabled: !isLoading,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _emailController,
                  label: StringConstants.email,
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: _validateEmail,
                  textInputAction: TextInputAction.next,
                  enabled: !isLoading,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _phoneController,
                  label: 'Phone Number (Optional)',
                  hint: '+1234567890',
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone_outlined),
                  validator: _validatePhone,
                  textInputAction: TextInputAction.next,
                  enabled: !isLoading,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _passwordController,
                  label: StringConstants.password,
                  hint: 'Enter your password',
                  obscureText: _obscurePassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: _validatePassword,
                  textInputAction: TextInputAction.next,
                  enabled: !isLoading,
                  onChanged: (value) => setState(() {}),
                ),
                if (_passwordController.text.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: _getPasswordStrength(_passwordController.text),
                          backgroundColor: Colors.grey.shade300,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getPasswordStrengthColor(
                              _getPasswordStrength(_passwordController.text),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _getPasswordStrengthText(
                          _getPasswordStrength(_passwordController.text),
                        ),
                        style: TextStyle(
                          color: _getPasswordStrengthColor(
                            _getPasswordStrength(_passwordController.text),
                          ),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: StringConstants.confirmPassword,
                  hint: 'Confirm your password',
                  obscureText: _obscureConfirmPassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  validator: _validateConfirmPassword,
                  textInputAction: TextInputAction.done,
                  enabled: !isLoading,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _acceptedTerms,
                      onChanged: isLoading
                          ? null
                          : (value) {
                              setState(() {
                                _acceptedTerms = value ?? false;
                              });
                            },
                      activeColor: ColorConstants.primaryGreen,
                    ),
                    Expanded(
                      child: Wrap(
                        children: [
                          Text(
                            'I agree to the ',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          GestureDetector(
                            onTap: () {
                              // TODO: Show terms and conditions
                            },
                            child: Text(
                              'Terms and Conditions',
                              style: TextStyle(
                                color: ColorConstants.primaryGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: StringConstants.signup,
                  onPressed: _handleSignup,
                  isLoading: isLoading,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: StringConstants.signInWithGoogle,
                  onPressed: _handleGoogleSignUp,
                  isLoading: isLoading,
                  isOutlined: true,
                  icon: Image.network(
                    'https://www.google.com/favicon.ico',
                    width: 20,
                    height: 20,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.g_mobiledata,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: isLoading
                          ? null
                          : () => context.go(StringConstants.loginRoute),
                      child: Text(
                        StringConstants.login,
                        style: TextStyle(
                          color: ColorConstants.primaryGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
