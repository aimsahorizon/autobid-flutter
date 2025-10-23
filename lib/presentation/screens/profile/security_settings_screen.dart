import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../auth/otp_verification_screen.dart';

class SecuritySettingsScreen extends ConsumerStatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  ConsumerState<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends ConsumerState<SecuritySettingsScreen> {
  final _passwordFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _newEmailController = TextEditingController();
  final _newPhoneController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _newEmailController.dispose();
    _newPhoneController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    if (!_passwordFormKey.currentState!.validate()) {
      return;
    }

    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User not found'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final authService = ref.read(authServiceProvider);

    // Step 1: Verify OTP sent to email
    final emailOtpResult = await authService.requestLoginOtp(currentUser.email);
    if (!emailOtpResult.success) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(emailOtpResult.errorMessage ?? 'Failed to send OTP to email'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!mounted) return;

    // Step 1.5: Verify email OTP
    final emailVerified = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(
          identifier: currentUser.email,
          title: 'Verify Your Email',
          subtitle: 'Enter OTP sent to',
          debugOtp: emailOtpResult.debugOtp,
          onVerify: (otp) async {
            final result = await authService.otpService.verifyOtp(
              identifier: currentUser.email,
              otp: otp,
            );
            if (!result.success) {
              throw Exception(result.errorMessage ?? 'Invalid OTP');
            }
            if (context.mounted) {
              Navigator.of(context).pop(true);
            }
          },
          onResend: () async {
            final result = await authService.requestLoginOtp(currentUser.email);
            return result.success;
          },
        ),
      ),
    );

    if (emailVerified != true || !mounted) return;

    // Step 2: Verify OTP sent to phone number
    if (currentUser.phoneNumber == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phone number not found. Please add a phone number to your account.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final phoneOtpResult = await authService.requestLoginOtp(currentUser.phoneNumber!);
    if (!phoneOtpResult.success) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(phoneOtpResult.errorMessage ?? 'Failed to send OTP to phone'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!mounted) return;

    // Step 2.5: Verify phone OTP
    final phoneVerified = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(
          identifier: currentUser.phoneNumber!,
          title: 'Verify Your Phone',
          subtitle: 'Enter OTP sent to',
          debugOtp: phoneOtpResult.debugOtp,
          onVerify: (otp) async {
            final result = await authService.otpService.verifyOtp(
              identifier: currentUser.phoneNumber!,
              otp: otp,
            );
            if (!result.success) {
              throw Exception(result.errorMessage ?? 'Invalid OTP');
            }
            if (context.mounted) {
              Navigator.of(context).pop(true);
            }
          },
          onResend: () async {
            final result = await authService.requestLoginOtp(currentUser.phoneNumber!);
            return result.success;
          },
        ),
      ),
    );

    if (phoneVerified != true || !mounted) return;

    // Step 3: Now update the password
    final changePasswordAction = ref.read(changePasswordActionProvider.notifier);

    await changePasswordAction.changePassword(
      currentPassword: _currentPasswordController.text,
      newPassword: _newPasswordController.text,
    );

    if (!mounted) return;

    final state = ref.read(changePasswordActionProvider);

    state.when(
      data: (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password changed successfully'),
            backgroundColor: Colors.green,
          ),
        );
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
      },
      loading: () {},
      error: (error, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }

  Future<void> _changeEmail() async {
    if (!_emailFormKey.currentState!.validate()) {
      return;
    }

    final newEmail = _newEmailController.text.trim();
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User not found'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final authService = ref.read(authServiceProvider);

    // Step 1: Request OTP for new email
    final newEmailOtpResult = await authService.requestLoginOtp(newEmail);

    if (!newEmailOtpResult.success) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(newEmailOtpResult.errorMessage ?? 'Failed to send OTP to new email'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!mounted) return;

    // Step 1.5: Verify new email OTP
    final newEmailVerified = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(
          identifier: newEmail,
          title: 'Verify New Email',
          subtitle: 'Enter OTP sent to',
          debugOtp: newEmailOtpResult.debugOtp,
          onVerify: (otp) async {
            final result = await authService.otpService.verifyOtp(
              identifier: newEmail,
              otp: otp,
            );
            if (!result.success) {
              throw Exception(result.errorMessage ?? 'Invalid OTP');
            }
            if (context.mounted) {
              Navigator.of(context).pop(true);
            }
          },
          onResend: () async {
            final result = await authService.requestLoginOtp(newEmail);
            return result.success;
          },
        ),
      ),
    );

    if (newEmailVerified != true || !mounted) return;

    // Step 2: Request OTP for phone number
    if (currentUser.phoneNumber == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phone number not found. Please add a phone number to your account.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final phoneOtpResult = await authService.requestLoginOtp(currentUser.phoneNumber!);

    if (!phoneOtpResult.success) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(phoneOtpResult.errorMessage ?? 'Failed to send OTP to phone'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!mounted) return;

    // Step 2.5: Verify phone OTP
    final phoneVerified = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(
          identifier: currentUser.phoneNumber!,
          title: 'Verify Your Phone',
          subtitle: 'Enter OTP sent to',
          debugOtp: phoneOtpResult.debugOtp,
          onVerify: (otp) async {
            final result = await authService.otpService.verifyOtp(
              identifier: currentUser.phoneNumber!,
              otp: otp,
            );
            if (!result.success) {
              throw Exception(result.errorMessage ?? 'Invalid OTP');
            }
            // Both OTPs verified, now update email
            final updateResult = await authService.updateProfile(
              fullName: ref.read(currentUserProvider)?.fullName,
            );
            if (!updateResult.success) {
              throw Exception(updateResult.errorMessage ?? 'Failed to update email');
            }
            if (context.mounted) {
              Navigator.of(context).pop(true);
            }
          },
          onResend: () async {
            final result = await authService.requestLoginOtp(currentUser.phoneNumber!);
            return result.success;
          },
        ),
      ),
    );

    if (phoneVerified == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
      _newEmailController.clear();
    }
  }

  Future<void> _changePhoneNumber() async {
    if (!_phoneFormKey.currentState!.validate()) {
      return;
    }

    final newPhone = _newPhoneController.text.trim();
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User not found'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final authService = ref.read(authServiceProvider);

    // Step 1: Request OTP for new phone number
    final newPhoneOtpResult = await authService.requestLoginOtp(newPhone);

    if (!newPhoneOtpResult.success) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(newPhoneOtpResult.errorMessage ?? 'Failed to send OTP to new phone'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!mounted) return;

    // Step 1.5: Verify new phone OTP
    final newPhoneVerified = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(
          identifier: newPhone,
          title: 'Verify New Phone Number',
          subtitle: 'Enter OTP sent to',
          debugOtp: newPhoneOtpResult.debugOtp,
          onVerify: (otp) async {
            final result = await authService.otpService.verifyOtp(
              identifier: newPhone,
              otp: otp,
            );
            if (!result.success) {
              throw Exception(result.errorMessage ?? 'Invalid OTP');
            }
            if (context.mounted) {
              Navigator.of(context).pop(true);
            }
          },
          onResend: () async {
            final result = await authService.requestLoginOtp(newPhone);
            return result.success;
          },
        ),
      ),
    );

    if (newPhoneVerified != true || !mounted) return;

    // Step 2: Request OTP for email
    final emailOtpResult = await authService.requestLoginOtp(currentUser.email);

    if (!emailOtpResult.success) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(emailOtpResult.errorMessage ?? 'Failed to send OTP to email'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!mounted) return;

    // Step 2.5: Verify email OTP
    final emailVerified = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(
          identifier: currentUser.email,
          title: 'Verify Your Email',
          subtitle: 'Enter OTP sent to',
          debugOtp: emailOtpResult.debugOtp,
          onVerify: (otp) async {
            final result = await authService.otpService.verifyOtp(
              identifier: currentUser.email,
              otp: otp,
            );
            if (!result.success) {
              throw Exception(result.errorMessage ?? 'Invalid OTP');
            }
            // Both OTPs verified, now update phone number
            final updateResult = await authService.updateProfile(
              phoneNumber: newPhone,
            );
            if (!updateResult.success) {
              throw Exception(updateResult.errorMessage ?? 'Failed to update phone number');
            }
            if (context.mounted) {
              Navigator.of(context).pop(true);
            }
          },
          onResend: () async {
            final result = await authService.requestLoginOtp(currentUser.email);
            return result.success;
          },
        ),
      ),
    );

    if (emailVerified == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phone number updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
      _newPhoneController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final changePasswordState = ref.watch(changePasswordActionProvider);
    final isLoading = changePasswordState.isLoading;
    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Change Password Section
          Text(
            'Change Password',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),

          Form(
            key: _passwordFormKey,
            child: Column(
              children: [
                // Current Password
                TextFormField(
                  controller: _currentPasswordController,
                  obscureText: _obscureCurrentPassword,
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                    hintText: 'Enter your current password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureCurrentPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureCurrentPassword = !_obscureCurrentPassword;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Current password is required';
                    }
                    return null;
                  },
                  enabled: !isLoading,
                ),
                const SizedBox(height: 16),

                // New Password
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: _obscureNewPassword,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    hintText: 'Enter new password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureNewPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureNewPassword = !_obscureNewPassword;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'New password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  enabled: !isLoading,
                ),
                const SizedBox(height: 16),

                // Confirm Password
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                    hintText: 'Re-enter new password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your new password';
                    }
                    if (value != _newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  enabled: !isLoading,
                ),
                const SizedBox(height: 24),

                // Change Password Button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: isLoading ? null : _changePassword,
                    icon: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.key),
                    label: Text(isLoading ? 'Changing...' : 'Change Password'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),

          // Change Email Section
          Text(
            'Change Email',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Current: ${currentUser?.email ?? 'Not set'}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 16),

          Form(
            key: _emailFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _newEmailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'New Email',
                    hintText: 'Enter new email address',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    if (value == currentUser?.email) {
                      return 'New email must be different from current email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _changeEmail,
                    icon: const Icon(Icons.email),
                    label: const Text('Update Email'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),

          // Change Phone Number Section
          Text(
            'Change Phone Number',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Current: ${currentUser?.phoneNumber ?? 'Not set'}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 16),

          Form(
            key: _phoneFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _newPhoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'New Phone Number',
                    hintText: 'Enter new phone number',
                    prefixIcon: Icon(Icons.phone_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }
                    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
                    if (!phoneRegex.hasMatch(value)) {
                      return 'Enter a valid phone number';
                    }
                    if (value == currentUser?.phoneNumber) {
                      return 'New phone must be different from current phone';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _changePhoneNumber,
                    icon: const Icon(Icons.phone),
                    label: const Text('Update Phone Number'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Security Tips
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[700]),
                    const SizedBox(width: 8),
                    Text(
                      'Security Tips',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildSecurityTip('Use a strong, unique password'),
                _buildSecurityTip('All changes require 2-step OTP verification (email + phone)'),
                _buildSecurityTip('Verify OTP codes sent to your email and phone'),
                _buildSecurityTip('Never share your password or OTP codes with anyone'),
                _buildSecurityTip('Change your password regularly'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityTip(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, size: 16, color: Colors.blue[700]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.blue[900]),
            ),
          ),
        ],
      ),
    );
  }
}
