import 'package:flutter/material.dart';
import 'dart:async';
import '../../../core/constants/color_constants.dart';
import '../../widgets/custom_button.dart';

/// Dual OTP Verification Screen for Login
/// Shows sequential verification: Email OTP -> Phone OTP
class LoginDualOtpScreen extends StatefulWidget {
  final String email;
  final String? phoneNumber;
  final Function(String otp) onVerifyEmail;
  final Function(String otp) onVerifyPhone;
  final Future<bool> Function() onResendEmail;
  final Future<bool> Function() onResendPhone;
  final String? debugEmailOtp;
  final String? debugPhoneOtp;

  const LoginDualOtpScreen({
    super.key,
    required this.email,
    this.phoneNumber,
    required this.onVerifyEmail,
    required this.onVerifyPhone,
    required this.onResendEmail,
    required this.onResendPhone,
    this.debugEmailOtp,
    this.debugPhoneOtp,
  });

  @override
  State<LoginDualOtpScreen> createState() => _LoginDualOtpScreenState();
}

enum OtpStep { email, phone }

class _LoginDualOtpScreenState extends State<LoginDualOtpScreen> {
  final List<TextEditingController> _emailOtpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<TextEditingController> _phoneOtpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _emailFocusNodes = List.generate(6, (_) => FocusNode());
  final List<FocusNode> _phoneFocusNodes = List.generate(6, (_) => FocusNode());

  OtpStep _currentStep = OtpStep.email;
  bool _isVerifying = false;
  int _resendTimer = 0;
  Timer? _timer;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    for (var controller in _emailOtpControllers) {
      controller.dispose();
    }
    for (var controller in _phoneOtpControllers) {
      controller.dispose();
    }
    for (var node in _emailFocusNodes) {
      node.dispose();
    }
    for (var node in _phoneFocusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() => _resendTimer = 60);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() => _resendTimer--);
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _handleResendOtp() async {
    if (_resendTimer > 0) return;

    setState(() => _isVerifying = true);

    try {
      bool success = false;
      if (_currentStep == OtpStep.email) {
        success = await widget.onResendEmail();
      } else {
        success = await widget.onResendPhone();
      }

      if (success) {
        _startResendTimer();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'OTP sent to ${_currentStep == OtpStep.email ? 'email' : 'phone'}'),
              backgroundColor: ColorConstants.primaryGreen,
            ),
          );
        }
      } else {
        setState(() => _errorMessage = 'Failed to resend OTP');
      }
    } catch (e) {
      setState(() => _errorMessage = 'Error: $e');
    } finally {
      if (mounted) {
        setState(() => _isVerifying = false);
      }
    }
  }

  String _getOtpValue(List<TextEditingController> controllers) {
    return controllers.map((c) => c.text).join();
  }

  bool _isOtpComplete(List<TextEditingController> controllers) {
    return controllers.every((c) => c.text.length == 1);
  }

  Future<void> _handleVerify() async {
    setState(() {
      _errorMessage = null;
      _isVerifying = true;
    });

    try {
      if (_currentStep == OtpStep.email) {
        // Verify email OTP
        if (!_isOtpComplete(_emailOtpControllers)) {
          setState(() => _errorMessage = 'Please enter complete email OTP');
          return;
        }

        final emailOtp = _getOtpValue(_emailOtpControllers);
        await widget.onVerifyEmail(emailOtp);

        // Email verified, move to phone if available
        if (widget.phoneNumber != null && widget.phoneNumber!.isNotEmpty) {
          setState(() => _currentStep = OtpStep.phone);
          _startResendTimer();
          _phoneFocusNodes.first.requestFocus();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email verified! Now verify your phone number.'),
              backgroundColor: ColorConstants.primaryGreen,
            ),
          );
        } else {
          // No phone verification needed, complete login
          if (mounted) {
            Navigator.of(context).pop(true);
          }
        }
      } else {
        // Verify phone OTP
        if (!_isOtpComplete(_phoneOtpControllers)) {
          setState(() => _errorMessage = 'Please enter complete phone OTP');
          return;
        }

        final phoneOtp = _getOtpValue(_phoneOtpControllers);
        await widget.onVerifyPhone(phoneOtp);

        // Both verified, complete login
        if (mounted) {
          Navigator.of(context).pop(true);
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() => _isVerifying = false);
      }
    }
  }

  Widget _buildOtpField(
    List<TextEditingController> controllers,
    List<FocusNode> focusNodes,
    int index,
  ) {
    return SizedBox(
      width: 50,
      height: 60,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: ColorConstants.primaryGreen, width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          } else if (value.isNotEmpty && index == 5) {
            // Auto-verify when last digit is entered
            if (_isOtpComplete(controllers)) {
              _handleVerify();
            }
          }
        },
      ),
    );
  }

  Widget _buildStepIndicator(int step, bool isActive) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isActive || (_currentStep == OtpStep.phone && step == 1)
            ? ColorConstants.primaryGreen
            : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: _currentStep == OtpStep.phone && step == 1
            ? const Icon(Icons.check, color: Colors.white, size: 18)
            : Text(
                step.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasPhone = widget.phoneNumber != null && widget.phoneNumber!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicator (only show if phone verification is needed)
              if (hasPhone) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStepIndicator(1, _currentStep == OtpStep.email),
                    Container(
                      width: 40,
                      height: 2,
                      color: _currentStep == OtpStep.phone
                          ? ColorConstants.primaryGreen
                          : Colors.grey.shade300,
                    ),
                    _buildStepIndicator(2, _currentStep == OtpStep.phone),
                  ],
                ),
                const SizedBox(height: 32),
              ],

              Text(
                _currentStep == OtpStep.email
                    ? 'Verify Email'
                    : 'Verify Phone Number',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primaryGreen,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                _currentStep == OtpStep.email
                    ? 'Enter the 6-digit code sent to your email'
                    : 'Now enter the 6-digit code sent to your phone',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 16),

              // Show current identifier
              Text(
                _currentStep == OtpStep.email
                    ? 'Email: ${widget.email}'
                    : 'Phone: ${widget.phoneNumber}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),

              // Debug OTP (only in debug mode)
              if ((_currentStep == OtpStep.email && widget.debugEmailOtp != null) ||
                  (_currentStep == OtpStep.phone && widget.debugPhoneOtp != null)) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.bug_report, size: 16, color: Colors.orange),
                      const SizedBox(width: 8),
                      Text(
                        'Debug OTP: ${_currentStep == OtpStep.email ? widget.debugEmailOtp : widget.debugPhoneOtp}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (index) => _buildOtpField(
                    _currentStep == OtpStep.email
                        ? _emailOtpControllers
                        : _phoneOtpControllers,
                    _currentStep == OtpStep.email
                        ? _emailFocusNodes
                        : _phoneFocusNodes,
                    index,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Resend Timer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _resendTimer > 0
                        ? 'Resend in ${_resendTimer}s'
                        : 'Didn\'t receive code?',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                    onPressed: _resendTimer == 0 && !_isVerifying
                        ? _handleResendOtp
                        : null,
                    child: const Text('Resend'),
                  ),
                ],
              ),

              // Error Message
              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ColorConstants.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: ColorConstants.error,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: ColorConstants.error,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 40),

              // Verify Button
              CustomButton(
                text: _currentStep == OtpStep.email
                    ? 'Verify Email'
                    : 'Verify & Continue',
                onPressed: _isVerifying ? null : _handleVerify,
                isLoading: _isVerifying,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
