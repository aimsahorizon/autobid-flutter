import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../../../core/constants/color_constants.dart';
import '../../../providers/signup_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/signup_stepper.dart';
import 'signup_step_mixin.dart';

class SignupStep2Otp extends StatefulWidget {
  const SignupStep2Otp({super.key});

  @override
  State<SignupStep2Otp> createState() => _SignupStep2OtpState();
}

class _SignupStep2OtpState extends State<SignupStep2Otp> with SignupStepMixin {
  final List<TextEditingController> _emailOtpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<TextEditingController> _phoneOtpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _emailFocusNodes = List.generate(6, (_) => FocusNode());
  final List<FocusNode> _phoneFocusNodes = List.generate(6, (_) => FocusNode());

  bool _isVerifying = false;
  int _emailResendTimer = 0;
  int _phoneResendTimer = 0;
  Timer? _emailTimer;
  Timer? _phoneTimer;

  @override
  void initState() {
    super.initState();
    _startResendTimer('email');
    _startResendTimer('phone');
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
    _emailTimer?.cancel();
    _phoneTimer?.cancel();
    super.dispose();
  }

  void _startResendTimer(String type) {
    if (type == 'email') {
      setState(() => _emailResendTimer = 60);
      _emailTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_emailResendTimer > 0) {
          setState(() => _emailResendTimer--);
        } else {
          timer.cancel();
        }
      });
    } else {
      setState(() => _phoneResendTimer = 60);
      _phoneTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_phoneResendTimer > 0) {
          setState(() => _phoneResendTimer--);
        } else {
          timer.cancel();
        }
      });
    }
  }

  void _handleResendOtp(String type) {
    // Mock OTP resend
    _startResendTimer(type);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('OTP sent to ${type == 'email' ? 'email' : 'phone'}'),
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
    if (!_isOtpComplete(_emailOtpControllers) ||
        !_isOtpComplete(_phoneOtpControllers)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter complete OTP codes'),
          backgroundColor: ColorConstants.error,
        ),
      );
      return;
    }

    setState(() => _isVerifying = true);

    // Mock OTP verification (accept any 6 digits)
    await Future.delayed(const Duration(seconds: 2));

    final emailOtp = _getOtpValue(_emailOtpControllers);
    final phoneOtp = _getOtpValue(_phoneOtpControllers);

    setState(() => _isVerifying = false);

    // For demo, accept any 6-digit code
    if (emailOtp.length == 6 && phoneOtp.length == 6) {
      handleNext('/signup/step3');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid OTP code'),
          backgroundColor: ColorConstants.error,
        ),
      );
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
        leading: buildBackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SignupStepper(currentStep: 2, totalSteps: 9),
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
                'Enter the 6-digit codes sent to your email and phone',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 32),
              // Email OTP
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
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _emailResendTimer > 0
                        ? 'Resend in ${_emailResendTimer}s'
                        : 'Didn\'t receive code?',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                    onPressed: _emailResendTimer == 0
                        ? () => _handleResendOtp('email')
                        : null,
                    child: const Text('Resend'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Phone OTP
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
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _phoneResendTimer > 0
                        ? 'Resend in ${_phoneResendTimer}s'
                        : 'Didn\'t receive code?',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                    onPressed: _phoneResendTimer == 0
                        ? () => _handleResendOtp('phone')
                        : null,
                    child: const Text('Resend'),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: 'Verify & Continue',
                onPressed: _handleVerify,
                isLoading: _isVerifying,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
