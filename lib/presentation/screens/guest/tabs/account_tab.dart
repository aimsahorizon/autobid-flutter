import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/utils/validators.dart';
import '../../../../data/services/local/local_storage_service.dart';
import '../../../../data/models/user_model.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_button.dart';
import '../widgets/account_status_card.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({super.key});

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());

  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _showOtpField = false;
  UserModel? _currentUser;

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _otpFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final storage = await LocalStorageService.getInstance();
      final emailOrPhone = _emailOrPhoneController.text.trim();
      final password = _passwordController.text;

      // Verify credentials
      final isValid = storage.verifyCredentials(emailOrPhone, password);

      if (!isValid) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid credentials'),
            backgroundColor: ColorConstants.error,
          ),
        );
        setState(() => _isLoading = false);
        return;
      }

      // Get user
      final user = storage.getUserByEmailOrPhone(emailOrPhone);
      if (user == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not found'),
            backgroundColor: ColorConstants.error,
          ),
        );
        setState(() => _isLoading = false);
        return;
      }

      // Check if account is locked
      if (user.accountStatus == AccountStatus.locked) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account locked. Please contact support.'),
            backgroundColor: ColorConstants.error,
          ),
        );
        setState(() => _isLoading = false);
        return;
      }

      // Check if verified
      if (user.accountStatus == AccountStatus.verified) {
        // Navigate to home
        if (!mounted) return;
        context.go('/home');
        return;
      }

      // Show OTP field for pending/rejected users
      setState(() {
        _showOtpField = true;
        _currentUser = user;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred'),
          backgroundColor: ColorConstants.error,
        ),
      );
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleVerifyOtp() async {
    final otp = _otpControllers.map((c) => c.text).join();

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter complete OTP'),
          backgroundColor: ColorConstants.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Mock OTP verification (accept any 6 digits for demo)
    await Future.delayed(const Duration(seconds: 1));

    try {
      final storage = await LocalStorageService.getInstance();

      if (otp.length == 6) {
        // OTP verified, show status
        setState(() {
          _showOtpField = false;
          _isLoading = false;
        });
      } else {
        // Invalid OTP, increment failure count
        await storage.updateOtpFailureCount(
          _currentUser!.email,
          _currentUser!.otpFailureCount + 1,
        );

        final updatedUser = storage.getUserByEmailOrPhone(_currentUser!.email);
        setState(() => _currentUser = updatedUser);

        if (updatedUser!.otpFailureCount >= 3) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account locked due to too many failed attempts'),
              backgroundColor: ColorConstants.error,
            ),
          );
        } else {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid OTP. Try again.'),
              backgroundColor: ColorConstants.error,
            ),
          );
        }
        setState(() => _isLoading = false);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred'),
          backgroundColor: ColorConstants.error,
        ),
      );
      setState(() => _isLoading = false);
    }
  }

  Widget _buildOtpField(int index) {
    return SizedBox(
      width: 45,
      height: 55,
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _otpFocusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: ColorConstants.primaryGreen, width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            _otpFocusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _otpFocusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser != null && !_showOtpField) {
      return AccountStatusCard(user: _currentUser!);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Check Application Status',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primaryGreen,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Login to view your registration status',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 24),
            if (!_showOtpField) ...[
              CustomTextField(
                controller: _emailOrPhoneController,
                label: 'Email or Phone',
                hint: 'Enter your email or phone',
                prefixIcon: const Icon(Icons.person_outline),
                validator: Validators.validateRequired,
                textInputAction: TextInputAction.next,
                enabled: !_isLoading,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _passwordController,
                label: 'Password',
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
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
                validator: Validators.validatePassword,
                textInputAction: TextInputAction.done,
                enabled: !_isLoading,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Login',
                onPressed: _handleLogin,
                isLoading: _isLoading,
              ),
            ] else ...[
              Text(
                'Enter OTP',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter the 6-digit code sent to ${_currentUser?.email}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) => _buildOtpField(index)),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Verify OTP',
                onPressed: _handleVerifyOtp,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  setState(() {
                    _showOtpField = false;
                    _currentUser = null;
                    for (var controller in _otpControllers) {
                      controller.clear();
                    }
                  });
                },
                child: const Text('Back to Login'),
              ),
            ],
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account? ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextButton(
                  onPressed: () => context.go('/signup/step1'),
                  child: Text(
                    'Register',
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
    );
  }
}
