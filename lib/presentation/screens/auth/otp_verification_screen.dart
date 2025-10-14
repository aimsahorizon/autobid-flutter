import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/color_constants.dart';
import '../../widgets/custom_button.dart';

/// Reusable OTP Verification Screen
/// Supports login, registration, and password reset flows
class OtpVerificationScreen extends StatefulWidget {
  final String identifier; // Email or phone
  final String title;
  final String subtitle;
  final Function(String otp) onVerify;
  final Future<bool> Function()? onResend;
  final String? debugOtp; // For testing - shows the OTP
  final int otpLength;
  final int countdownSeconds;

  const OtpVerificationScreen({
    super.key,
    required this.identifier,
    required this.title,
    required this.subtitle,
    required this.onVerify,
    this.onResend,
    this.debugOtp,
    this.otpLength = 6,
    this.countdownSeconds = 60,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];

  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isLoading = false;
  bool _canResend = false;
  String? _errorMessage;
  int _resendCount = 0;

  @override
  void initState() {
    super.initState();

    // Initialize controllers and focus nodes
    for (int i = 0; i < widget.otpLength; i++) {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }

    // Start countdown timer
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
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

    // Get OTP from controllers
    final otp = _controllers.map((c) => c.text).join();

    // Validate OTP length
    if (otp.length != widget.otpLength) {
      setState(() {
        _errorMessage = 'Please enter all ${widget.otpLength} digits';
        _isLoading = false;
      });
      return;
    }

    // Call verification callback
    try {
      await widget.onVerify(otp);
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
          _clearOtp();
          _startTimer();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('OTP resent successfully'),
                backgroundColor: ColorConstants.primaryGreen,
              ),
            );
          }
        } else {
          setState(() {
            _errorMessage = 'Failed to resend OTP. Please try again.';
          });
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error resending OTP: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _clearOtp() {
    for (var controller in _controllers) {
      controller.clear();
    }
    _focusNodes.first.requestFocus();
  }

  void _onOtpDigitChanged(int index, String value) {
    if (value.isEmpty && index > 0) {
      // Handle backspace
      _focusNodes[index - 1].requestFocus();
    } else if (value.isNotEmpty && index < widget.otpLength - 1) {
      // Move to next field
      _focusNodes[index + 1].requestFocus();
    } else if (value.isNotEmpty && index == widget.otpLength - 1) {
      // Last digit entered - remove focus
      _focusNodes[index].unfocus();

      // Auto-verify if all digits entered
      final otp = _controllers.map((c) => c.text).join();
      if (otp.length == widget.otpLength) {
        _handleVerify();
      }
    }
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
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
                  Icons.lock_outline,
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

              // Subtitle with identifier
              Text(
                widget.subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              Text(
                widget.identifier,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.primaryGreen,
                    ),
                textAlign: TextAlign.center,
              ),

              // Debug OTP (only in debug mode)
              if (widget.debugOtp != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.bug_report, size: 16, color: Colors.orange),
                      const SizedBox(width: 8),
                      Text(
                        'Debug OTP: ${widget.debugOtp}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 40),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  widget.otpLength,
                  (index) => _buildOtpField(index),
                ),
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
                text: 'Verify OTP',
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
                      'Resend OTP in ${_formatTime(_remainingSeconds)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                )
              else if (_resendCount < 3)
                TextButton.icon(
                  onPressed: _isLoading ? null : _handleResend,
                  icon: Icon(Icons.refresh),
                  label: Text(
                    'Resend OTP${_resendCount > 0 ? ' ($_resendCount/3)' : ''}',
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

              const SizedBox(height: 20),

              // Change method link
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Change email or phone number',
                  style: TextStyle(
                    color: ColorConstants.primaryGreen,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpField(int index) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: Theme.of(context).textTheme.headlineSmall,
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
        onChanged: (value) => _onOtpDigitChanged(index, value),
      ),
    );
  }
}
