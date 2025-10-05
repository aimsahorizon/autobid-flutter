import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/ph_cities.dart';
import '../../../../core/constants/ph_provinces.dart';
import '../../../../core/utils/validators.dart';
import '../../../providers/signup_provider.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/signup_stepper.dart';

class SignupStep3Address extends StatefulWidget {
  const SignupStep3Address({super.key});

  @override
  State<SignupStep3Address> createState() => _SignupStep3AddressState();
}

class _SignupStep3AddressState extends State<SignupStep3Address> {
  final _formKey = GlobalKey<FormState>();
  final _streetController = TextEditingController();
  final _barangayController = TextEditingController();
  final _zipCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<SignupProvider>();
    _streetController.text = provider.street;
    _barangayController.text = provider.barangay;
    _zipCodeController.text = provider.zipCode;
  }

  @override
  void dispose() {
    _streetController.dispose();
    _barangayController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<SignupProvider>();

    if (provider.city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a city'),
          backgroundColor: ColorConstants.error,
        ),
      );
      return;
    }

    if (provider.province.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a province'),
          backgroundColor: ColorConstants.error,
        ),
      );
      return;
    }

    provider.setStreet(_streetController.text.trim());
    provider.setBarangay(_barangayController.text.trim());
    provider.setZipCode(_zipCodeController.text.trim());

    context.go('/signup/step4');
  }

  void _handleBack() {
    context.go('/signup/step2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _handleBack,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SignupStepper(currentStep: 3),
                const SizedBox(height: 32),
                Text(
                  'Address Information',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primaryGreen,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Where do you live?',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: _streetController,
                  label: 'Street Address',
                  hint: 'House/Bldg No., Street Name',
                  prefixIcon: const Icon(Icons.home_outlined),
                  validator: (value) =>
                      Validators.validateRequired(value, 'Street address'),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _barangayController,
                  label: 'Barangay',
                  hint: 'Enter barangay',
                  prefixIcon: const Icon(Icons.location_city_outlined),
                  validator: (value) =>
                      Validators.validateRequired(value, 'Barangay'),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                Consumer<SignupProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'City',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonFormField<String>(
                            initialValue: provider.city.isEmpty ? null : provider.city,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.location_on_outlined),
                              hintText: 'Select city',
                            ),
                            items: PhilippineCities.cities.map((city) {
                              return DropdownMenuItem(
                                value: city,
                                child: Text(city),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                provider.setCity(value);
                              }
                            },
                            isExpanded: true,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                Consumer<SignupProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Province',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonFormField<String>(
                            initialValue: provider.province.isEmpty
                                ? null
                                : provider.province,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.map_outlined),
                              hintText: 'Select province',
                            ),
                            items: PhilippineProvinces.provinces.map((province) {
                              return DropdownMenuItem(
                                value: province,
                                child: Text(province),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                provider.setProvince(value);
                              }
                            },
                            isExpanded: true,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _zipCodeController,
                  label: 'ZIP Code',
                  hint: 'Enter 4-digit ZIP code',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.pin_drop_outlined),
                  validator: Validators.validateZipCode,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: 'Next',
                  onPressed: _handleNext,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
