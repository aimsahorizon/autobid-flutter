import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/utils/demo_data_helper.dart';
import '../../../providers/signup_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/signup_stepper.dart';
import 'signup_step_mixin.dart';

class SignupStep2Otp extends StatefulWidget {
  const SignupStep2Otp({super.key});

  @override
  State<SignupStep2Otp> createState() => _SignupStep2OtpState();
}

enum OtpStep { email, phone }

class _SignupStep2OtpState extends State<SignupStep2Otp> with SignupStepMixin {
  final List<TextEditingController> _emailOtpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<TextEditingController> _phoneOtpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _emailFocusNodes = List.generate(6, (_) => FocusNode());
  final List<FocusNode> _phoneFocusNodes = List.generate(6, (_) => FocusNode());

  OtpStep _currentStep = OtpStep.email;
  String? _verifiedEmailOtp;
  bool _isVerifying = false;
  int _resendTimer = 0;
  Timer? _timer;

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

  void _autoFillDemo() {
    final controllers =
        _currentStep == OtpStep.email ? _emailOtpControllers : _phoneOtpControllers;
    final otp = DemoDataHelper.demoOTP;

    for (int i = 0; i < 6; i++) {
      controllers[i].text = otp[i];
    }

    DemoDataHelper.showDemoFilledMessage(context);
  }

  void _handleResendOtp() {
    // Mock OTP resend
    _startResendTimer();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('OTP sent to ${_currentStep == OtpStep.email ? 'email' : 'phone'}'),
        backgroundColor: ColorConstants.primaryGreen,
      ),
    );
  }

  String _getOtpValue(List<TextEditingController> controllers) {
    return controllers.map((c) => c.text).join();
  }

  bool _isOtpComplete(List<TextEditingController> controllers) {
    return controllers.every((c) => c.text.length == 1);
  }

  void _handleVerify() async {
    if (_currentStep == OtpStep.email) {
      // Verify email OTP
      if (!_isOtpComplete(_emailOtpControllers)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter complete email OTP'),
            backgroundColor: ColorConstants.error,
          ),
        );
        return;
      }

      setState(() => _isVerifying = true);

      // Mock OTP verification (accept any 6 digits)
      await Future.delayed(const Duration(seconds: 1));

      final emailOtp = _getOtpValue(_emailOtpControllers);

      setState(() => _isVerifying = false);

      // For demo, accept any 6-digit code
      if (emailOtp.length == 6) {
        _verifiedEmailOtp = emailOtp;
        setState(() {
          _currentStep = OtpStep.phone;
        });
        _startResendTimer();
        _phoneFocusNodes.first.requestFocus();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email verified! Now verify your phone number.'),
            backgroundColor: ColorConstants.primaryGreen,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email OTP code'),
            backgroundColor: ColorConstants.error,
          ),
        );
      }
    } else {
      // Verify phone OTP
      if (!_isOtpComplete(_phoneOtpControllers)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter complete phone OTP'),
            backgroundColor: ColorConstants.error,
          ),
        );
        return;
      }

      setState(() => _isVerifying = true);

      // Mock OTP verification (accept any 6 digits)
      await Future.delayed(const Duration(seconds: 1));

      final phoneOtp = _getOtpValue(_phoneOtpControllers);

      setState(() => _isVerifying = false);

      // For demo, accept any 6-digit code
      if (phoneOtp.length == 6) {
        handleNext('/signup/step4');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid phone OTP code'),
            backgroundColor: ColorConstants.error,
          ),
        );
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
            borderSide: const BorderSide(color: ColorConstants.primaryGreen, width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SignupProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
        centerTitle: true,
        leading: buildBackButton('/signup/step2'),
        actions: [
          if (DemoDataHelper.isDemoModeEnabled)
            TextButton.icon(
              onPressed: _autoFillDemo,
              icon: const Icon(Icons.auto_awesome, size: 18),
              label: const Text('Demo'),
              style: TextButton.styleFrom(
                foregroundColor: ColorConstants.primaryGreen,
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SignupStepper(currentStep: 3, totalSteps: 9),
              const SizedBox(height: 32),
              Text(
                'Verification Codes',
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
              // Progress indicator
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
              // Show only current step OTP
              if (_currentStep == OtpStep.email) ...[
                Text(
                  'Email: ${provider.email}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    6,
                    (index) => _buildOtpField(
                      _emailOtpControllers,
                      _emailFocusNodes,
                      index,
                    ),
                  ),
                ),
              ] else ...[
                Text(
                  'Phone: ${provider.phoneNumber}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    6,
                    (index) => _buildOtpField(
                      _phoneOtpControllers,
                      _phoneFocusNodes,
                      index,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 12),
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
                    onPressed: _resendTimer == 0 ? _handleResendOtp : null,
                    child: const Text('Resend'),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: _currentStep == OtpStep.email
                    ? 'Verify Email'
                    : 'Verify & Continue',
                onPressed: _handleVerify,
                isLoading: _isVerifying,
              ),
            ],
          ),
        ),
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
            ? Icon(Icons.check, color: Colors.white, size: 18)
            : Text(
                step.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
      ),
    );
  }
}
