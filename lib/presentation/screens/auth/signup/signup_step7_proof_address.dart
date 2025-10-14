import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/proof_of_address_types.dart';
import '../../../../data/models/user_model.dart';
import '../../../providers/signup_provider.dart';
import '../../../widgets/image_upload_card.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/signup_stepper.dart';
import 'signup_step_mixin.dart';

class SignupStep7ProofAddress extends StatefulWidget {
  const SignupStep7ProofAddress({super.key});

  @override
  State<SignupStep7ProofAddress> createState() =>
      _SignupStep7ProofAddressState();
}

class _SignupStep7ProofAddressState extends State<SignupStep7ProofAddress> with SignupStepMixin {
  ProofOfAddressType? _selectedType;
  Uint8List? _documentImage;

  @override
  void initState() {
    super.initState();
    final provider = context.read<SignupProvider>();
    _selectedType = provider.proofOfAddressType;
    _documentImage = provider.proofOfAddressImage;
  }

  @override
  Widget build(BuildContext context) {
    final signupProvider = context.watch<SignupProvider>();
    final colorScheme = Theme.of(context).colorScheme;
    final userAddress = _buildAddressString(signupProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Proof of Address'),
        centerTitle: true,
        leading: buildBackButtonWithWarning(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SignupStepper(currentStep: 8, totalSteps: 9),
              const SizedBox(height: 32),
              Text(
                'Proof of Address Verification',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primaryGreen,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Upload a document issued within 3 months',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 24),

              // Address match warning
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ColorConstants.primaryGreen.withValues(alpha: 0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.home, color: ColorConstants.primaryGreen, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your registered address:',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            userAddress,
                            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Ensure your document shows this address',
                            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Document type selector
              Text(
                'Document Type',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<ProofOfAddressType>(
                value: _selectedType,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                  hintText: 'Select document type',
                ),
                isExpanded: true,
                items: ProofOfAddressTypes.all.map((info) {
                  return DropdownMenuItem(
                    value: info.type,
                    child: Text(info.displayName, overflow: TextOverflow.ellipsis),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value;
                  });
                  if (value != null) {
                    signupProvider.setProofOfAddressType(value);
                  }
                },
              ),
              const SizedBox(height: 24),

              // Image upload
              Text(
                'Upload Document',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              ImageUploadCard(
                title: 'Upload Document Photo',
                subtitle: 'Make sure the address is clearly visible',
                imageData: _documentImage,
                icon: Icons.camera_alt,
                onTap: () async {
                  await ImageUploadHelper.showImageSourceDialog(
                    context,
                    (image) {
                      setState(() {
                        _documentImage = image;
                      });
                      signupProvider.setProofOfAddressImage(image);
                    },
                  );
                },
                onRemove: () {
                  setState(() {
                    _documentImage = null;
                  });
                  signupProvider.setProofOfAddressImage(null);
                },
              ),
              const SizedBox(height: 24),

              // Info card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Why is this needed?',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Confirms your residential address for security and compliance. This helps protect both buyers and sellers.',
                            style: TextStyle(fontSize: 13, color: Colors.blue.shade900),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Navigation buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Back',
                      onPressed: () => context.go('/signup/step7'),
                      isOutlined: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      text: 'Next',
                      onPressed: (_selectedType != null && _documentImage != null)
                          ? () => context.go('/signup/step9')
                          : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleNext() {
    if (_selectedType == null || _documentImage == null) return;
    context.go('/signup/step9');
  }

  String _buildAddressString(SignupProvider provider) {
    final parts = [
      provider.street,
      provider.barangay,
      provider.city,
      provider.province,
      provider.zipCode,
    ].where((part) => part.isNotEmpty).toList();

    return parts.isNotEmpty ? parts.join(', ') : 'Address not provided';
  }
}
