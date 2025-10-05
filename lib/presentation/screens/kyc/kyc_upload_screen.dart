import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/kyc_provider.dart';
import '../../../data/models/kyc_model.dart';
import '../../widgets/image_upload_card.dart';

class KycUploadScreen extends StatefulWidget {
  const KycUploadScreen({super.key});

  @override
  State<KycUploadScreen> createState() => _KycUploadScreenState();
}

class _KycUploadScreenState extends State<KycUploadScreen> {
  final _idNumberController = TextEditingController();

  @override
  void dispose() {
    _idNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kycProvider = context.watch<KycProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Documents'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator
            _buildProgressIndicator(context, kycProvider.currentStep),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: _buildStepContent(context, kycProvider),
              ),
            ),

            // Bottom Navigation
            _buildBottomNavigation(context, kycProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(
      BuildContext context, KycUploadStep currentStep) {
    final colorScheme = Theme.of(context).colorScheme;
    final steps = KycUploadStep.values;
    final currentIndex = steps.indexOf(currentStep);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            _buildStepIndicator(
              context,
              stepNumber: i + 1,
              isActive: i == currentIndex,
              isCompleted: i < currentIndex,
            ),
            if (i < steps.length - 1)
              Expanded(
                child: Container(
                  height: 2,
                  color: i < currentIndex
                      ? colorScheme.primary
                      : colorScheme.outline.withValues(alpha: 0.3),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildStepIndicator(
    BuildContext context, {
    required int stepNumber,
    required bool isActive,
    required bool isCompleted,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isCompleted || isActive
            ? colorScheme.primary
            : colorScheme.outline.withValues(alpha: 0.3),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: isCompleted
            ? Icon(
                Icons.check,
                size: 18,
                color: colorScheme.onPrimary,
              )
            : Text(
                '$stepNumber',
                style: TextStyle(
                  color: isActive
                      ? colorScheme.onPrimary
                      : colorScheme.onSurface.withValues(alpha: 0.6),
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildStepContent(BuildContext context, KycProvider provider) {
    switch (provider.currentStep) {
      case KycUploadStep.primaryId:
        return _buildPrimaryIdStep(context, provider);
      case KycUploadStep.secondaryId:
        return _buildSecondaryIdStep(context, provider);
      case KycUploadStep.selfie:
        return _buildSelfieStep(context, provider);
    }
  }

  Widget _buildPrimaryIdStep(BuildContext context, KycProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Primary ID Document',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Select your ID type and upload a clear photo',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
              ),
        ),
        const SizedBox(height: 24),

        // ID Type Selector
        Text(
          'ID Type',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<IdType>(
          initialValue: provider.selectedIdType,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.credit_card),
          ),
          items: const [
            DropdownMenuItem(
              value: IdType.nationalId,
              child: Text('National ID'),
            ),
            DropdownMenuItem(
              value: IdType.driversLicense,
              child: Text('Driver\'s License'),
            ),
            DropdownMenuItem(
              value: IdType.passport,
              child: Text('Passport'),
            ),
            DropdownMenuItem(
              value: IdType.votersId,
              child: Text('Voter\'s ID'),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              provider.setIdType(value);
            }
          },
        ),
        const SizedBox(height: 24),

        // ID Number
        Text(
          'ID Number',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _idNumberController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your ID number',
            prefixIcon: Icon(Icons.numbers),
          ),
          onChanged: (value) {
            provider.setIdNumber(value);
          },
        ),
        const SizedBox(height: 24),

        // Image Upload
        Text(
          'ID Photo',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        ImageUploadCard(
          title: 'Upload ID Document',
          subtitle: 'Take a clear photo of your ID',
          imageData: provider.primaryIdImage,
          icon: Icons.credit_card,
          onTap: () async {
            await ImageUploadHelper.showImageSourceDialog(
              context,
              (image) => provider.setPrimaryIdImage(image),
            );
          },
          onRemove: () => provider.setPrimaryIdImage(null),
        ),
      ],
    );
  }

  Widget _buildSecondaryIdStep(BuildContext context, KycProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Secondary ID (Optional)',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Adding a secondary ID strengthens your verification',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
              ),
        ),
        const SizedBox(height: 24),

        ImageUploadCard(
          title: 'Upload Secondary ID',
          subtitle: 'Optional - Helps with faster verification',
          imageData: provider.secondaryIdImage,
          icon: Icons.badge,
          onTap: () async {
            await ImageUploadHelper.showImageSourceDialog(
              context,
              (image) => provider.setSecondaryIdImage(image),
            );
          },
          onRemove: () => provider.setSecondaryIdImage(null),
        ),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade900, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'You can skip this step and proceed to the selfie',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelfieStep(BuildContext context, KycProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selfie with ID',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Take a selfie holding your primary ID next to your face',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
              ),
        ),
        const SizedBox(height: 24),

        ImageUploadCard(
          title: 'Upload Selfie with ID',
          subtitle: 'Make sure your face and ID are clearly visible',
          imageData: provider.selfieImage,
          icon: Icons.face,
          onTap: () async {
            await ImageUploadHelper.showImageSourceDialog(
              context,
              (image) => provider.setSelfieImage(image),
            );
          },
          onRemove: () => provider.setSelfieImage(null),
        ),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.lightbulb_outline,
                      color: Colors.amber.shade900, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Tips for a good selfie:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '• Use good lighting\n'
                '• Hold your ID next to your face\n'
                '• Make sure both your face and ID are in focus\n'
                '• Don\'t wear sunglasses or hats',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.amber.shade900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation(BuildContext context, KycProvider provider) {
    final colorScheme = Theme.of(context).colorScheme;
    final isFirstStep = provider.currentStep == KycUploadStep.primaryId;
    final isLastStep = provider.currentStep == KycUploadStep.selfie;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (!isFirstStep)
            Expanded(
              child: OutlinedButton(
                onPressed: provider.previousStep,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Back'),
              ),
            ),
          if (!isFirstStep) const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: FilledButton(
              onPressed: provider.canProceedToNextStep
                  ? () async {
                      if (isLastStep) {
                        await _submitKyc(context, provider);
                      } else {
                        provider.nextStep();
                      }
                    }
                  : null,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: provider.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(isLastStep ? 'Submit' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitKyc(BuildContext context, KycProvider provider) async {
    // Get user ID from auth provider (mocked for now)
    const userId = 'mock-user-id';

    final success = await provider.submitKyc(userId);

    if (!context.mounted) return;

    if (success) {
      context.go('/kyc-status');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.error ?? 'Failed to submit KYC'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
