import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import 'security_change_dual_otp_screen.dart';

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

  bool _isPasswordLoading = false;
  bool _isEmailLoading = false;
  bool _isPhoneLoading = false;

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

    if (currentUser.phoneNumber == null || currentUser.phoneNumber!.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phone number not found. Please add a phone number to your account.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isPasswordLoading = true);

    final authService = ref.read(authServiceProvider);

    try {
      // Request OTPs for both email and phone
      final emailOtpResult = await authService.requestLoginOtp(currentUser.email);
      if (!emailOtpResult.success) {
        throw Exception(emailOtpResult.errorMessage ?? 'Failed to send OTP to email');
      }

      final phoneOtpResult = await authService.requestLoginOtp(currentUser.phoneNumber!);
      if (!phoneOtpResult.success) {
        throw Exception(phoneOtpResult.errorMessage ?? 'Failed to send OTP to phone');
      }

      setState(() => _isPasswordLoading = false);

      if (!mounted) return;

      // Navigate to dual OTP verification screen
      final verified = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (context) => SecurityChangeDualOtpScreen(
            step1Title: 'Verify Email',
            step2Title: 'Verify Phone',
            step1Subtitle: 'Enter the 6-digit code sent to your email',
            step2Subtitle: 'Now enter the 6-digit code sent to your phone',
            step1Identifier: currentUser.email,
            step2Identifier: currentUser.phoneNumber!,
            step1Label: 'Email',
            step2Label: 'Phone',
            debugStep1Otp: emailOtpResult.debugOtp,
            debugStep2Otp: phoneOtpResult.debugOtp,
            successMessage: 'Identity verified! Updating password...',
            onVerifyStep1: (otp) async {
              final result = await authService.otpService.verifyOtp(
                identifier: currentUser.email,
                otp: otp,
              );
              if (!result.success) {
                throw Exception(result.errorMessage ?? 'Invalid email OTP');
              }
            },
            onVerifyStep2: (otp) async {
              final result = await authService.otpService.verifyOtp(
                identifier: currentUser.phoneNumber!,
                otp: otp,
              );
              if (!result.success) {
                throw Exception(result.errorMessage ?? 'Invalid phone OTP');
              }
            },
            onResendStep1: () async {
              final result = await authService.requestLoginOtp(currentUser.email);
              return result.success;
            },
            onResendStep2: () async {
              final result = await authService.requestLoginOtp(currentUser.phoneNumber!);
              return result.success;
            },
          ),
        ),
      );

      if (verified != true || !mounted) return;

      // Now update the password
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
    } catch (e) {
      setState(() => _isPasswordLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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

    if (currentUser.phoneNumber == null || currentUser.phoneNumber!.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phone number not found. Please add a phone number to your account.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isEmailLoading = true);

    final authService = ref.read(authServiceProvider);

    try {
      // Request OTPs for new email and current phone
      final newEmailOtpResult = await authService.requestSecurityOtp(newEmail);
      if (!newEmailOtpResult.success) {
        throw Exception(newEmailOtpResult.errorMessage ?? 'Failed to send OTP to new email');
      }

      final phoneOtpResult = await authService.requestLoginOtp(currentUser.phoneNumber!);
      if (!phoneOtpResult.success) {
        throw Exception(phoneOtpResult.errorMessage ?? 'Failed to send OTP to phone');
      }

      setState(() => _isEmailLoading = false);

      if (!mounted) return;

      // Navigate to dual OTP verification screen
      final verified = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (context) => SecurityChangeDualOtpScreen(
            step1Title: 'Verify New Email',
            step2Title: 'Verify Current Phone',
            step1Subtitle: 'Enter the 6-digit code sent to your new email',
            step2Subtitle: 'Now enter the 6-digit code sent to your current phone',
            step1Identifier: newEmail,
            step2Identifier: currentUser.phoneNumber!,
            step1Label: 'New Email',
            step2Label: 'Current Phone',
            debugStep1Otp: newEmailOtpResult.debugOtp,
            debugStep2Otp: phoneOtpResult.debugOtp,
            successMessage: 'Email updated successfully!',
            onVerifyStep1: (otp) async {
              final result = await authService.otpService.verifyOtp(
                identifier: newEmail,
                otp: otp,
              );
              if (!result.success) {
                throw Exception(result.errorMessage ?? 'Invalid email OTP');
              }
            },
            onVerifyStep2: (otp) async {
              final result = await authService.otpService.verifyOtp(
                identifier: currentUser.phoneNumber!,
                otp: otp,
              );
              if (!result.success) {
                throw Exception(result.errorMessage ?? 'Invalid phone OTP');
              }

              // Both OTPs verified, now update email
              final updateResult = await authService.updateProfile(
                fullName: currentUser.fullName,
              );
              if (!updateResult.success) {
                throw Exception(updateResult.errorMessage ?? 'Failed to update email');
              }
            },
            onResendStep1: () async {
              final result = await authService.requestSecurityOtp(newEmail);
              return result.success;
            },
            onResendStep2: () async {
              final result = await authService.requestLoginOtp(currentUser.phoneNumber!);
              return result.success;
            },
          ),
        ),
      );

      if (verified == true && mounted) {
        _newEmailController.clear();
      }
    } catch (e) {
      setState(() => _isEmailLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
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

    setState(() => _isPhoneLoading = true);

    final authService = ref.read(authServiceProvider);

    try {
      // Request OTPs for new phone and current email
      final newPhoneOtpResult = await authService.requestSecurityOtp(newPhone);
      if (!newPhoneOtpResult.success) {
        throw Exception(newPhoneOtpResult.errorMessage ?? 'Failed to send OTP to new phone');
      }

      final emailOtpResult = await authService.requestLoginOtp(currentUser.email);
      if (!emailOtpResult.success) {
        throw Exception(emailOtpResult.errorMessage ?? 'Failed to send OTP to email');
      }

      setState(() => _isPhoneLoading = false);

      if (!mounted) return;

      // Navigate to dual OTP verification screen
      final verified = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (context) => SecurityChangeDualOtpScreen(
            step1Title: 'Verify New Phone',
            step2Title: 'Verify Current Email',
            step1Subtitle: 'Enter the 6-digit code sent to your new phone',
            step2Subtitle: 'Now enter the 6-digit code sent to your current email',
            step1Identifier: newPhone,
            step2Identifier: currentUser.email,
            step1Label: 'New Phone',
            step2Label: 'Current Email',
            debugStep1Otp: newPhoneOtpResult.debugOtp,
            debugStep2Otp: emailOtpResult.debugOtp,
            successMessage: 'Phone number updated successfully!',
            onVerifyStep1: (otp) async {
              final result = await authService.otpService.verifyOtp(
                identifier: newPhone,
                otp: otp,
              );
              if (!result.success) {
                throw Exception(result.errorMessage ?? 'Invalid phone OTP');
              }
            },
            onVerifyStep2: (otp) async {
              final result = await authService.otpService.verifyOtp(
                identifier: currentUser.email,
                otp: otp,
              );
              if (!result.success) {
                throw Exception(result.errorMessage ?? 'Invalid email OTP');
              }

              // Both OTPs verified, now update phone number
              final updateResult = await authService.updateProfile(
                phoneNumber: newPhone,
              );
              if (!updateResult.success) {
                throw Exception(updateResult.errorMessage ?? 'Failed to update phone number');
              }
            },
            onResendStep1: () async {
              final result = await authService.requestSecurityOtp(newPhone);
              return result.success;
            },
            onResendStep2: () async {
              final result = await authService.requestLoginOtp(currentUser.email);
              return result.success;
            },
          ),
        ),
      );

      if (verified == true && mounted) {
        _newPhoneController.clear();
      }
    } catch (e) {
      setState(() => _isPhoneLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
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
                  enabled: !isLoading && !_isPasswordLoading,
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
                  enabled: !isLoading && !_isPasswordLoading,
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
                  enabled: !isLoading && !_isPasswordLoading,
                ),
                const SizedBox(height: 24),

                // Change Password Button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _isPasswordLoading ? null : _changePassword,
                    icon: _isPasswordLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.key),
                    label: Text(_isPasswordLoading ? 'Sending OTP...' : 'Change Password'),
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
                  enabled: !_isEmailLoading,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _isEmailLoading ? null : _changeEmail,
                    icon: _isEmailLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.email),
                    label: Text(_isEmailLoading ? 'Sending OTP...' : 'Update Email'),
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
                  enabled: !_isPhoneLoading,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _isPhoneLoading ? null : _changePhoneNumber,
                    icon: _isPhoneLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.phone),
                    label: Text(_isPhoneLoading ? 'Sending OTP...' : 'Update Phone Number'),
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
