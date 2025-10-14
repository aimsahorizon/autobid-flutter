import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/color_constants.dart';
import '../../widgets/custom_button.dart';

/// Dual OTP Verification Screen for Registration
/// Verifies both email and phone OTPs simultaneously
class DualOtpVerificationScreen extends StatefulWidget {
  final String email;
  final String phoneNumber;
  final String title;
  final Function(String emailOtp, String phoneOtp) onVerify;
  final Future<bool> Function()? onResend;
  final String? debugOtps; // Format: "emailOtp/phoneOtp"
  final int otpLength;
  final int countdownSeconds;

  const DualOtpVerificationScreen({
    super.key,
    required this.email,
    required this.phoneNumber,
    required this.title,
    required this.onVerify,
    this.onResend,
    this.debugOtps,
    this.otpLength = 6,
    this.countdownSeconds = 60,
  });

  @override
  State<DualOtpVerificationScreen> createState() =>
      _DualOtpVerificationScreenState();
}

class _DualOtpVerificationScreenState
    extends State<DualOtpVerificationScreen> {
  // Email OTP controllers
  final List<TextEditingController> _emailControllers = [];
  final List<FocusNode> _emailFocusNodes = [];

  // Phone OTP controllers
  final List<TextEditingController> _phoneControllers = [];
  final List<FocusNode> _phoneFocusNodes = [];

  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isLoading = false;
  bool _canResend = false;
  String? _errorMessage;
  int _resendCount = 0;

  @override
  void initState() {
    super.initState();

    // Initialize controllers and focus nodes for both email and phone
    for (int i = 0; i < widget.otpLength; i++) {
      _emailControllers.add(TextEditingController());
      _emailFocusNodes.add(FocusNode());
      _phoneControllers.add(TextEditingController());
      _phoneFocusNodes.add(FocusNode());
    }

    // Start countdown timer
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _emailControllers) {
      controller.dispose();
    }
    for (var node in _emailFocusNodes) {
      node.dispose();
    }
    for (var controller in _phoneControllers) {
      controller.dispose();
    }
    for (var node in _phoneFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _remainingSeconds = widget.countdownSeconds;
      _canResend = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  Future<void> _handleVerify() async {
    // Clear error
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    // Get OTPs from controllers
    final emailOtp = _emailControllers.map((c) => c.text).join();
    final phoneOtp = _phoneControllers.map((c) => c.text).join();

    // Validate OTP lengths
    if (emailOtp.length != widget.otpLength ||
        phoneOtp.length != widget.otpLength) {
      setState(() {
        _errorMessage = 'Please enter all ${widget.otpLength} digits for both codes';
        _isLoading = false;
      });
      return;
    }

    // Call verification callback
    try {
      await widget.onVerify(emailOtp, phoneOtp);
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleResend() async {
    if (!_canResend || _resendCount >= 3) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (widget.onResend != null) {
        final success = await widget.onResend!();
        if (success) {
          _resendCount++;
          _clearAllOtps();
          _startTimer();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('OTPs resent successfully'),
                backgroundColor: ColorConstants.primaryGreen,
              ),
            );
          }
        } else {
          setState(() {
            _errorMessage = 'Failed to resend OTPs. Please try again.';
          });
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error resending OTPs: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _clearAllOtps() {
    for (var controller in _emailControllers) {
      controller.clear();
    }
    for (var controller in _phoneControllers) {
      controller.clear();
    }
    _emailFocusNodes.first.requestFocus();
  }

  void _onOtpDigitChanged(
    int index,
    String value,
    List<TextEditingController> controllers,
    List<FocusNode> focusNodes,
  ) {
    if (value.isEmpty && index > 0) {
      // Handle backspace
      focusNodes[index - 1].requestFocus();
    } else if (value.isNotEmpty && index < widget.otpLength - 1) {
      // Move to next field
      focusNodes[index + 1].requestFocus();
    } else if (value.isNotEmpty && index == widget.otpLength - 1) {
      // Last digit entered - remove focus
      focusNodes[index].unfocus();
    }
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  String _maskIdentifier(String identifier) {
    if (identifier.contains('@')) {
      // Email
      final parts = identifier.split('@');
      final username = parts[0];
      final domain = parts[1];
      final maskedUsername = username.length > 2
          ? '${username.substring(0, 2)}${'*' * (username.length - 2)}'
          : username;
      return '$maskedUsername@$domain';
    } else {
      // Phone
      return '${identifier.substring(0, 3)}****${identifier.substring(identifier.length - 2)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final debugOtpParts = widget.debugOtps?.split('/');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email & Phone'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ColorConstants.primaryGreen.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.verified_user_outlined,
                  size: 60,
                  color: ColorConstants.primaryGreen,
                ),
              ),

              const SizedBox(height: 30),

              // Title
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Subtitle
              Text(
                'We\'ve sent verification codes to your email and phone',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

              // Debug OTPs
              if (widget.debugOtps != null && debugOtpParts != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.bug_report, size: 16, color: Colors.orange),
                          const SizedBox(width: 8),
                          Text(
                            'Debug Mode',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade900,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Email OTP: ${debugOtpParts[0]}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange.shade900,
                        ),
                      ),
                      Text(
                        'Phone OTP: ${debugOtpParts.length > 1 ? debugOtpParts[1] : 'N/A'}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 40),

              // Email OTP Section
              _buildOtpSection(
                'Email Verification',
                _maskIdentifier(widget.email),
                _emailControllers,
                _emailFocusNodes,
                Icons.email_outlined,
              ),

              const SizedBox(height: 30),

              // Phone OTP Section
              _buildOtpSection(
                'Phone Verification',
                _maskIdentifier(widget.phoneNumber),
                _phoneControllers,
                _phoneFocusNodes,
                Icons.phone_outlined,
              ),

              const SizedBox(height: 20),

              // Error Message
              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ColorConstants.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: ColorConstants.error,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(
                            color: ColorConstants.error,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 30),

              // Verify Button
              CustomButton(
                text: 'Verify & Continue',
                onPressed: _isLoading ? null : _handleVerify,
                isLoading: _isLoading,
              ),

              const SizedBox(height: 24),

              // Timer & Resend
              if (_remainingSeconds > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 20,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Resend OTPs in ${_formatTime(_remainingSeconds)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                )
              else if (_resendCount < 3)
                TextButton.icon(
                  onPressed: _isLoading ? null : _handleResend,
                  icon: Icon(Icons.refresh),
                  label: Text(
                    'Resend OTPs${_resendCount > 0 ? ' ($_resendCount/3)' : ''}',
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: ColorConstants.primaryGreen,
                  ),
                )
              else
                Text(
                  'Maximum resend attempts reached',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorConstants.error,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpSection(
    String title,
    String identifier,
    List<TextEditingController> controllers,
    List<FocusNode> focusNodes,
    IconData icon,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: ColorConstants.primaryGreen),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          identifier,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            widget.otpLength,
            (index) => _buildOtpField(index, controllers, focusNodes),
          ),
        ),
      ],
    );
  }

  Widget _buildOtpField(
    int index,
    List<TextEditingController> controllers,
    List<FocusNode> focusNodes,
  ) {
    return SizedBox(
      width: 45,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: Theme.of(context).textTheme.titleLarge,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: ColorConstants.primaryGreen,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: ColorConstants.error,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
        onChanged: (value) => _onOtpDigitChanged(
          index,
          value,
          controllers,
          focusNodes,
        ),
      ),
    );
  }
}
