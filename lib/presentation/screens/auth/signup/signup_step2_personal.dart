import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/utils/demo_data_helper.dart';
import '../../../providers/signup_provider.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/signup_stepper.dart';
import 'signup_step_mixin.dart';

class SignupStep2Personal extends StatefulWidget {
  const SignupStep2Personal({super.key});

  @override
  State<SignupStep2Personal> createState() => _SignupStep2PersonalState();
}

class _SignupStep2PersonalState extends State<SignupStep2Personal> with SignupStepMixin {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<SignupProvider>();
    _firstNameController.text = provider.firstName;
    _middleNameController.text = provider.middleName;
    _lastNameController.text = provider.lastName;
    if (provider.dateOfBirth != null) {
      _dateController.text =
          DateFormat('MMMM dd, yyyy').format(provider.dateOfBirth!);
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _autoFillDemo() {
    final provider = context.read<SignupProvider>();
    provider.autoFillStep2();

    // Update controllers
    _firstNameController.text = provider.firstName;
    _middleNameController.text = provider.middleName;
    _lastNameController.text = provider.lastName;
    if (provider.dateOfBirth != null) {
      _dateController.text =
          DateFormat('MMMM dd, yyyy').format(provider.dateOfBirth!);
    }

    DemoDataHelper.showDemoFilledMessage(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    final provider = context.read<SignupProvider>();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: provider.dateOfBirth ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorConstants.primaryGreen,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (!mounted) return;
      final ageError = Validators.validateAge(picked);
      if (ageError != null) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(ageError),
            backgroundColor: ColorConstants.error,
          ),
        );
        return;
      }

      // ignore: use_build_context_synchronously
      final provider = context.read<SignupProvider>();
      provider.setDateOfBirth(picked);
      _dateController.text = DateFormat('MMMM dd, yyyy').format(picked);
    }
  }

  void _handleNext() {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<SignupProvider>();

    if (provider.dateOfBirth == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your date of birth'),
          backgroundColor: ColorConstants.error,
        ),
      );
      return;
    }

    if (provider.gender.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your gender'),
          backgroundColor: ColorConstants.error,
        ),
      );
      return;
    }

    provider.setFirstName(_firstNameController.text.trim());
    provider.setMiddleName(_middleNameController.text.trim());
    provider.setLastName(_lastNameController.text.trim());

    context.go('/signup/step2');
  }

  void _handleBack() {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Information'),
        centerTitle: true,
        leading: buildBackButton('/login'),
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SignupStepper(currentStep: 1, totalSteps: 9),
                const SizedBox(height: 32),
                Text(
                  'Personal Information',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primaryGreen,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tell us about yourself',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: _firstNameController,
                  label: 'First Name',
                  hint: 'Enter your first name',
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: (value) => Validators.validateName(value, 'First name'),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _middleNameController,
                  label: 'Middle Name (Optional)',
                  hint: 'Enter your middle name',
                  prefixIcon: const Icon(Icons.person_outline),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _lastNameController,
                  label: 'Last Name',
                  hint: 'Enter your last name',
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: (value) => Validators.validateName(value, 'Last name'),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _dateController,
                  label: 'Date of Birth',
                  hint: 'Select your date of birth',
                  prefixIcon: const Icon(Icons.calendar_today_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Date of birth is required';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  textInputAction: TextInputAction.next,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () => _selectDate(context),
                    icon: const Icon(Icons.calendar_today),
                    label: const Text('Select Date'),
                    style: TextButton.styleFrom(
                      foregroundColor: ColorConstants.primaryGreen,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Gender',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Consumer<SignupProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      children: [
                        // ignore: deprecated_member_use
                        RadioListTile<String>(
                          value: 'Male',
                          // ignore: deprecated_member_use
                          groupValue: provider.gender,
                          // ignore: deprecated_member_use
                          onChanged: (value) {
                            provider.setGender(value ?? '');
                          },
                          activeColor: ColorConstants.primaryGreen,
                          title: const Text('Male'),
                          contentPadding: EdgeInsets.zero,
                        ),
                        // ignore: deprecated_member_use
                        RadioListTile<String>(
                          value: 'Female',
                          // ignore: deprecated_member_use
                          groupValue: provider.gender,
                          // ignore: deprecated_member_use
                          onChanged: (value) {
                            provider.setGender(value ?? '');
                          },
                          activeColor: ColorConstants.primaryGreen,
                          title: const Text('Female'),
                          contentPadding: EdgeInsets.zero,
                        ),
                        // ignore: deprecated_member_use
                        RadioListTile<String>(
                          value: 'Other',
                          // ignore: deprecated_member_use
                          groupValue: provider.gender,
                          // ignore: deprecated_member_use
                          onChanged: (value) {
                            provider.setGender(value ?? '');
                          },
                          activeColor: ColorConstants.primaryGreen,
                          title: const Text('Other'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Back',
                        onPressed: _handleBack,
                        isOutlined: true,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: CustomButton(
                        text: 'Next',
                        onPressed: _handleNext,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
