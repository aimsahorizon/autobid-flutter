import 'package:flutter/material.dart';
import 'dart:async';
import '../../../core/constants/color_constants.dart';
import '../../widgets/custom_button.dart';

/// Generic Dual OTP Verification Screen for Security Changes
/// Supports: Password change, Email change, Phone number change
class SecurityChangeDualOtpScreen extends StatefulWidget {
  final String step1Title;
  final String step2Title;
  final String step1Subtitle;
  final String step2Subtitle;
  final String step1Identifier;
  final String step2Identifier;
  final String step1Label;
  final String step2Label;
  final Future<void> Function(String otp) onVerifyStep1;
  final Future<void> Function(String otp) onVerifyStep2;
  final Future<bool> Function() onResendStep1;
  final Future<bool> Function() onResendStep2;
  final String? debugStep1Otp;
  final String? debugStep2Otp;
  final String successMessage;

  const SecurityChangeDualOtpScreen({
    super.key,
    required this.step1Title,
    required this.step2Title,
    required this.step1Subtitle,
    required this.step2Subtitle,
    required this.step1Identifier,
    required this.step2Identifier,
    required this.step1Label,
    required this.step2Label,
    required this.onVerifyStep1,
    required this.onVerifyStep2,
    required this.onResendStep1,
    required this.onResendStep2,
    this.debugStep1Otp,
    this.debugStep2Otp,
    required this.successMessage,
  });

  @override
  State<SecurityChangeDualOtpScreen> createState() =>
      _SecurityChangeDualOtpScreenState();
}

enum SecurityOtpStep { step1, step2 }

class _SecurityChangeDualOtpScreenState
    extends State<SecurityChangeDualOtpScreen> {
  final List<TextEditingController> _step1OtpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<TextEditingController> _step2OtpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _step1FocusNodes = List.generate(6, (_) => FocusNode());
  final List<FocusNode> _step2FocusNodes = List.generate(6, (_) => FocusNode());

  SecurityOtpStep _currentStep = SecurityOtpStep.step1;
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
    for (var controller in _step1OtpControllers) {
      controller.dispose();
    }
    for (var controller in _step2OtpControllers) {
      controller.dispose();
    }
    for (var node in _step1FocusNodes) {
      node.dispose();
    }
    for (var node in _step2FocusNodes) {
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
      if (_currentStep == SecurityOtpStep.step1) {
        success = await widget.onResendStep1();
      } else {
        success = await widget.onResendStep2();
      }

      if (success) {
        _startResendTimer();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'OTP sent to ${_currentStep == SecurityOtpStep.step1 ? widget.step1Label : widget.step2Label}'),
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
      if (_currentStep == SecurityOtpStep.step1) {
        // Verify step 1 OTP
        if (!_isOtpComplete(_step1OtpControllers)) {
          setState(() => _errorMessage = 'Please enter complete OTP');
          return;
        }

        final step1Otp = _getOtpValue(_step1OtpControllers);
        await widget.onVerifyStep1(step1Otp);

        // Step 1 verified, move to step 2
        setState(() => _currentStep = SecurityOtpStep.step2);
        _startResendTimer();
        _step2FocusNodes.first.requestFocus();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  '${widget.step1Label} verified! Now verify ${widget.step2Label}.'),
              backgroundColor: ColorConstants.primaryGreen,
            ),
          );
        }
      } else {
        // Verify step 2 OTP
        if (!_isOtpComplete(_step2OtpControllers)) {
          setState(() => _errorMessage = 'Please enter complete OTP');
          return;
        }

        final step2Otp = _getOtpValue(_step2OtpControllers);
        await widget.onVerifyStep2(step2Otp);

        // Both verified, complete process
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(widget.successMessage),
              backgroundColor: ColorConstants.primaryGreen,
            ),
          );
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
        color: isActive || (_currentStep == SecurityOtpStep.step2 && step == 1)
            ? ColorConstants.primaryGreen
            : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: _currentStep == SecurityOtpStep.step2 && step == 1
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Identity'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStepIndicator(1, _currentStep == SecurityOtpStep.step1),
                  Container(
                    width: 40,
                    height: 2,
                    color: _currentStep == SecurityOtpStep.step2
                        ? ColorConstants.primaryGreen
                        : Colors.grey.shade300,
                  ),
                  _buildStepIndicator(2, _currentStep == SecurityOtpStep.step2),
                ],
              ),
              const SizedBox(height: 32),

              // Title
              Text(
                _currentStep == SecurityOtpStep.step1
                    ? widget.step1Title
                    : widget.step2Title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primaryGreen,
                    ),
              ),
              const SizedBox(height: 8),

              // Subtitle
              Text(
                _currentStep == SecurityOtpStep.step1
                    ? widget.step1Subtitle
                    : widget.step2Subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 16),

              // Show current identifier
              Text(
                _currentStep == SecurityOtpStep.step1
                    ? '${widget.step1Label}: ${widget.step1Identifier}'
                    : '${widget.step2Label}: ${widget.step2Identifier}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),

              // Debug OTP (only in debug mode)
              if ((_currentStep == SecurityOtpStep.step1 &&
                      widget.debugStep1Otp != null) ||
                  (_currentStep == SecurityOtpStep.step2 &&
                      widget.debugStep2Otp != null)) ...[
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
                        'Debug OTP: ${_currentStep == SecurityOtpStep.step1 ? widget.debugStep1Otp : widget.debugStep2Otp}',
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
                    _currentStep == SecurityOtpStep.step1
                        ? _step1OtpControllers
                        : _step2OtpControllers,
                    _currentStep == SecurityOtpStep.step1
                        ? _step1FocusNodes
                        : _step2FocusNodes,
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
                text: _currentStep == SecurityOtpStep.step1
                    ? 'Verify ${widget.step1Label}'
                    : 'Verify & Complete',
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
