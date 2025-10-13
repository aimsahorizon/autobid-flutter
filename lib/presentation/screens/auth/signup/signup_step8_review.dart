import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/services/local/local_storage_service.dart';
import '../../../providers/signup_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/signup_stepper.dart';

class SignupStep8Review extends StatefulWidget {
  const SignupStep8Review({super.key});

  @override
  State<SignupStep8Review> createState() => _SignupStep8ReviewState();
}

class _SignupStep8ReviewState extends State<SignupStep8Review> {
  bool _isSubmitting = false;

  void _handleBack() {
    context.go('/signup/step8');
  }

  Future<void> _handleSubmit() async {
    setState(() {
      _isSubmitting = true;
    });

    try {
      final provider = context.read<SignupProvider>();

      // Create user model
      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: provider.email,
        fullName: provider.fullName,
        firstName: provider.firstName,
        middleName: provider.middleName,
        lastName: provider.lastName,
        dateOfBirth: provider.dateOfBirth,
        gender: provider.gender,
        phoneNumber: provider.phoneNumber,
        password: provider.password,
        street: provider.street,
        barangay: provider.barangay,
        city: provider.city,
        province: provider.province,
        zipCode: provider.zipCode,
        nationality: provider.nationality,
        termsAccepted: provider.termsAccepted,
        privacyAccepted: provider.privacyAccepted,
        kycStatus: 'pending',
        accountType: 'individual',
        createdAt: DateTime.now(),
        accountStatus: AccountStatus.pending,
      );

      // Save to local storage
      final storage = await LocalStorageService.getInstance();
      await storage.saveUser(user);

      // Simulate registration submission
      await Future.delayed(const Duration(seconds: 2));

      // Navigate to success screen
      if (mounted) {
        context.go('/signup/success');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: ColorConstants.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review & Submit'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _handleBack,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Consumer<SignupProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SignupStepper(currentStep: 9, totalSteps: 9),
                        const SizedBox(height: 32),
                        Text(
                          'Review Your Information',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.primaryGreen,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Please review all details before submitting',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                        const SizedBox(height: 24),
                        _buildSection(
                          context,
                          title: 'Account Information',
                          onEdit: () {
                            provider.setIsEditingFromReview(true);
                            context.go('/signup/step1');
                          },
                          children: [
                            _buildInfoRow('Email', provider.email),
                            _buildInfoRow('Phone', provider.phoneNumber),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildSection(
                          context,
                          title: 'Personal Information',
                          onEdit: () {
                            provider.setIsEditingFromReview(true);
                            context.go('/signup/step2');
                          },
                          children: [
                            _buildInfoRow('Full Name', provider.fullName),
                            _buildInfoRow(
                              'Date of Birth',
                              provider.dateOfBirth != null
                                  ? DateFormat('MMMM dd, yyyy')
                                      .format(provider.dateOfBirth!)
                                  : 'N/A',
                            ),
                            _buildInfoRow('Gender', provider.gender),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildSection(
                          context,
                          title: 'Address',
                          onEdit: () {
                            provider.setIsEditingFromReview(true);
                            context.go('/signup/step3');
                          },
                          children: [
                            _buildInfoRow('Full Address', provider.fullAddress),
                            _buildInfoRow('Nationality', provider.nationality),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildSection(
                          context,
                          title: 'National ID',
                          onEdit: () {
                            provider.setIsEditingFromReview(true);
                            context.go('/signup/step4');
                          },
                          children: [
                            _buildInfoRow('ID Number', provider.nationalIdNumber),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Front',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      if (provider.primaryIdFront != null)
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.memory(
                                            provider.primaryIdFront!,
                                            height: 80,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Back',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      if (provider.primaryIdBack != null)
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.memory(
                                            provider.primaryIdBack!,
                                            height: 80,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildSection(
                          context,
                          title: 'Secondary ID',
                          onEdit: () {
                            provider.setIsEditingFromReview(true);
                            context.go('/signup/step5');
                          },
                          children: [
                            _buildInfoRow('ID Type', provider.secondaryIdType),
                            _buildInfoRow('ID Number', provider.secondaryIdNumber),
                            const SizedBox(height: 12),
                            if (provider.secondaryIdImage != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.memory(
                                  provider.secondaryIdImage!,
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildSection(
                          context,
                          title: 'Selfie Verification',
                          onEdit: () {
                            provider.setIsEditingFromReview(true);
                            context.go('/signup/step6');
                          },
                          children: [
                            if (provider.selfieImage != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.memory(
                                  provider.selfieImage!,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildSection(
                          context,
                          title: 'Proof of Address',
                          onEdit: () {
                            provider.setIsEditingFromReview(true);
                            context.go('/signup/step7');
                          },
                          children: [
                            if (provider.proofOfAddressType != null)
                              _buildInfoRow('Document Type',
                                provider.proofOfAddressType?.toString().split('.').last ?? 'N/A'),
                            const SizedBox(height: 12),
                            if (provider.proofOfAddressImage != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.memory(
                                  provider.proofOfAddressImage!,
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.orange[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.orange[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.warning_amber_rounded,
                                  color: Colors.orange[700]),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'By submitting, you confirm that all information provided is accurate and truthful.',
                                  style: TextStyle(
                                    color: Colors.orange[900],
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: CustomButton(
                text: 'Submit Registration',
                onPressed: _isSubmitting ? null : _handleSubmit,
                isLoading: _isSubmitting,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required VoidCallback onEdit,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primaryGreen,
                    ),
              ),
              TextButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit, size: 18),
                label: const Text('Edit'),
                style: TextButton.styleFrom(
                  foregroundColor: ColorConstants.primaryGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
