import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/utils/validators.dart';
import '../../../../data/services/mock/mock_auth_service.dart';
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
  final _authService = MockAuthService();

  bool _obscurePassword = true;
  bool _isLoading = false;
  UserModel? _currentUser;
  String? _errorMessage;

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    _authService.dispose();
    super.dispose();
  }

  Future<void> _handleCheckStatus() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final emailOrPhone = _emailOrPhoneController.text.trim();
      final password = _passwordController.text;

      // Sign in with email and password using MockAuthService
      final result = await _authService.signInWithEmail(emailOrPhone, password);

      if (!mounted) return;

      if (result.success && result.user != null) {
        // Check if account is verified (should redirect to home)
        if (result.user!.accountStatus == AccountStatus.verified) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Account verified! Redirecting to home...'),
              backgroundColor: ColorConstants.success,
            ),
          );
          // Sign out and redirect to login for full auth flow
          await _authService.signOut();
          context.go('/login');
          return;
        }

        // Show account status for pending/rejected/locked accounts
        setState(() {
          _currentUser = result.user;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = result.errorMessage ?? 'Invalid credentials';
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage!),
            backgroundColor: ColorConstants.error,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          backgroundColor: ColorConstants.error,
        ),
      );
    }
  }

  Widget _buildTestCredentialsInfo() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
              const SizedBox(width: 8),
              Text(
                'Test Accounts',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Use any of these test accounts to check status:',
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue[800],
            ),
          ),
          const SizedBox(height: 8),
          _buildTestCredRow('Verified', 'test@autobid.com', 'Test123'),
          _buildTestCredRow('Pending', 'pending@autobid.com', 'Test123'),
          _buildTestCredRow('Rejected', 'rejected@autobid.com', 'Test123'),
        ],
      ),
    );
  }

  Widget _buildTestCredRow(String status, String email, String password) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$email / $password',
              style: TextStyle(
                fontSize: 11,
                color: Colors.blue[900],
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show account status if user has checked
    if (_currentUser != null) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: ColorConstants.primaryGreen.withOpacity(0.1),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      _currentUser = null;
                      _emailOrPhoneController.clear();
                      _passwordController.clear();
                      _errorMessage = null;
                    });
                  },
                ),
                const Text(
                  'Back to Login',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(
            child: AccountStatusCard(user: _currentUser!),
          ),
        ],
      );
    }

    // Show login form to check status
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Check Account Status',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primaryGreen,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Login to view your application status',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 24),

            // Test credentials info
            _buildTestCredentialsInfo(),

            CustomTextField(
              controller: _emailOrPhoneController,
              label: 'Email or Phone',
              hint: 'Enter your email or phone',
              prefixIcon: const Icon(Icons.person_outline),
              validator: (value) => Validators.validateRequired(value, 'Email or Phone'),
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
              onFieldSubmitted: (_) => _handleCheckStatus(),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Check Account Status',
              onPressed: _handleCheckStatus,
              isLoading: _isLoading,
            ),
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
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () => context.go('/login'),
                child: Text(
                  'Go to Full Login',
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
    );
  }
}
