import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/ph_locations.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/utils/demo_data_helper.dart';
import '../../../providers/signup_provider.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/signup_stepper.dart';
import 'signup_step_mixin.dart';

class SignupStep3Address extends StatefulWidget {
  const SignupStep3Address({super.key});

  @override
  State<SignupStep3Address> createState() => _SignupStep3AddressState();
}

class _SignupStep3AddressState extends State<SignupStep3Address> with SignupStepMixin {
  final _formKey = GlobalKey<FormState>();
  final _streetController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _barangayController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<SignupProvider>();
    _streetController.text = provider.street;
    _zipCodeController.text = provider.zipCode;
    _barangayController.text = provider.barangay;
  }

  @override
  void dispose() {
    _streetController.dispose();
    _zipCodeController.dispose();
    _barangayController.dispose();
    super.dispose();
  }

  void _autoFillDemo() {
    final provider = context.read<SignupProvider>();
    provider.autoFillStep3();

    // Update controllers
    _streetController.text = provider.street;
    _zipCodeController.text = provider.zipCode;

    DemoDataHelper.showDemoFilledMessage(context);
  }

  void _handleNext() {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<SignupProvider>();

    if (provider.region.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a region'),
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

    if (provider.city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a city'),
          backgroundColor: ColorConstants.error,
        ),
      );
      return;
    }

    if (provider.barangay.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select or enter a barangay'),
          backgroundColor: ColorConstants.error,
        ),
      );
      return;
    }

    provider.setStreet(_streetController.text.trim());
    provider.setZipCode(_zipCodeController.text.trim());

    context.go('/signup/step5');
  }

  void _handleBack() {
    context.go('/signup/step3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
        centerTitle: true,
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
        leading: buildBackButtonWithWarning(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SignupStepper(currentStep: 4, totalSteps: 9),
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

                // Region Dropdown
                Consumer<SignupProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Region',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                            value: provider.region.isEmpty ? null : provider.region,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.public_outlined),
                              hintText: 'Select region',
                            ),
                            items: PhilippineLocations.regions.map((region) {
                              return DropdownMenuItem(
                                value: region,
                                child: Text(region),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                provider.setRegion(value);
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

                // Province Dropdown (filtered by region)
                Consumer<SignupProvider>(
                  builder: (context, provider, child) {
                    final provinces = provider.region.isEmpty
                        ? <String>[]
                        : PhilippineLocations.getProvincesForRegion(provider.region);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Province',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                            value: provider.province.isEmpty ? null : provider.province,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.map_outlined),
                              hintText: 'Select province',
                            ),
                            items: provinces.map((province) {
                              return DropdownMenuItem(
                                value: province,
                                child: Text(province),
                              );
                            }).toList(),
                            onChanged: provider.region.isEmpty
                                ? null
                                : (value) {
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

                // City Dropdown (filtered by province)
                Consumer<SignupProvider>(
                  builder: (context, provider, child) {
                    final cities = provider.province.isEmpty
                        ? <String>[]
                        : PhilippineLocations.getCitiesForProvince(provider.province);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'City / Municipality',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                            value: provider.city.isEmpty ? null : provider.city,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.location_city_outlined),
                              hintText: 'Select city / municipality',
                            ),
                            items: cities.map((city) {
                              return DropdownMenuItem(
                                value: city,
                                child: Text(city),
                              );
                            }).toList(),
                            onChanged: provider.province.isEmpty
                                ? null
                                : (value) {
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

                // Barangay - Dropdown if available, otherwise text field
                Consumer<SignupProvider>(
                  builder: (context, provider, child) {
                    final barangays = provider.city.isEmpty
                        ? <String>[]
                        : PhilippineLocations.getBarangaysForCity(provider.city);

                    // Update controller when switching between modes or when provider changes
                    if (_barangayController.text != provider.barangay) {
                      _barangayController.text = provider.barangay;
                    }

                    if (barangays.isEmpty) {
                      // No barangays available, show text field
                      return CustomTextField(
                        controller: _barangayController,
                        label: 'Barangay',
                        hint: 'Enter barangay',
                        prefixIcon: const Icon(Icons.location_on_outlined),
                        validator: (value) =>
                            Validators.validateRequired(value, 'Barangay'),
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => provider.setBarangay(value),
                      );
                    }

                    // Barangays available, show dropdown
                    // Check if current value is in the list, otherwise clear it
                    if (provider.barangay.isNotEmpty && !barangays.contains(provider.barangay)) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        provider.setBarangay('');
                      });
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Barangay',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                            value: (provider.barangay.isEmpty || !barangays.contains(provider.barangay))
                                ? null
                                : provider.barangay,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.location_on_outlined),
                              hintText: 'Select barangay',
                            ),
                            items: barangays.map((barangay) {
                              return DropdownMenuItem(
                                value: barangay,
                                child: Text(barangay),
                              );
                            }).toList(),
                            onChanged: provider.city.isEmpty
                                ? null
                                : (value) {
                                    if (value != null) {
                                      provider.setBarangay(value);
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

                // Street Address
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

                // Zip Code
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
