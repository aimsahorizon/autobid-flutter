import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/kyc_verification_model.dart';
import '../../../providers/ra_8792_pre_transaction_provider.dart';

/// KYC Verification Tab
/// Allows buyer and seller to verify their identities
class VerificationTab extends ConsumerStatefulWidget {
  final String preTransactionId;
  final String userRole; // 'buyer' or 'seller'
  final String userId;
  final String userName;

  const VerificationTab({
    Key? key,
    required this.preTransactionId,
    required this.userRole,
    required this.userId,
    required this.userName,
  }) : super(key: key);

  @override
  ConsumerState<VerificationTab> createState() => _VerificationTabState();
}

class _VerificationTabState extends ConsumerState<VerificationTab> {
  GovernmentIdType _selectedIdType = GovernmentIdType.driversLicense;
  final _idNumberController = TextEditingController();
  bool _ra8792Consent = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _idNumberController.dispose();
    super.dispose();
  }

  Future<void> _submitVerification() async {
    if (_idNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your ID number')),
      );
      return;
    }

    if (!_ra8792Consent) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the RA 8792 consent')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final notifier = ref.read(
        ra8792PreTransactionProvider(widget.preTransactionId).notifier,
      );

      await notifier.submitKycVerification(
        userId: widget.userId,
        userName: widget.userName,
        idType: _selectedIdType,
        idNumber: _idNumberController.text,
        idPhotoUrl: 'mock://id_photo.jpg', // Mock - would be actual upload
        selfiePhotoUrl: 'mock://selfie.jpg', // Mock - would be actual upload
        ra8792Consent: _ra8792Consent,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verification submitted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final preTransaction = ref.watch(
      ra8792PreTransactionProvider(widget.preTransactionId),
    );

    final verification = widget.userRole == 'buyer'
        ? preTransaction?.buyerVerification
        : preTransaction?.sellerVerification;

    final otherVerification = widget.userRole == 'buyer'
        ? preTransaction?.sellerVerification
        : preTransaction?.buyerVerification;

    final isVerified = verification?.status == KycVerificationStatus.verified;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Identity Verification',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Verify your identity to proceed with the transaction. This is required under RA 8792.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 24),

          // Your Verification Status
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        isVerified ? Icons.check_circle : Icons.pending,
                        color: isVerified ? Colors.green : Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Your Verification Status',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (isVerified) ...[
                    _buildVerifiedStatus(verification!),
                  ] else ...[
                    _buildVerificationForm(),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Other Party Status
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        otherVerification?.status == KycVerificationStatus.verified
                            ? Icons.check_circle
                            : Icons.pending,
                        color: otherVerification?.status == KycVerificationStatus.verified
                            ? Colors.green
                            : Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${widget.userRole == 'buyer' ? 'Seller' : 'Buyer'} Verification',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    otherVerification?.status == KycVerificationStatus.verified
                        ? 'The ${widget.userRole == 'buyer' ? 'seller' : 'buyer'} has been verified'
                        : 'Waiting for ${widget.userRole == 'buyer' ? 'seller' : 'buyer'} verification',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifiedStatus(KycVerification verification) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Chip(
          label: Text('Verified'),
          backgroundColor: Colors.green,
          labelStyle: TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 12),
        Text('ID Type: ${_idTypeLabel(verification.governmentIdType)}'),
        Text('ID Number: ****${verification.governmentIdNumber.substring(verification.governmentIdNumber.length - 4)}'),
        Text('Verified: ${_formatDateTime(verification.verifiedAt!)}'),
      ],
    );
  }

  Widget _buildVerificationForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ID Type Dropdown
        DropdownButtonFormField<GovernmentIdType>(
          value: _selectedIdType,
          decoration: const InputDecoration(
            labelText: 'Government-Issued ID Type',
            border: OutlineInputBorder(),
          ),
          items: GovernmentIdType.values.map((type) {
            return DropdownMenuItem(
              value: type,
              child: Text(_idTypeLabel(type)),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => _selectedIdType = value);
            }
          },
        ),
        const SizedBox(height: 16),

        // ID Number
        TextField(
          controller: _idNumberController,
          decoration: const InputDecoration(
            labelText: 'ID Number',
            border: OutlineInputBorder(),
            hintText: 'Enter your ID number',
          ),
        ),
        const SizedBox(height: 16),

        // Mock Upload Buttons
        OutlinedButton.icon(
          onPressed: () {
            // Mock - would open image picker
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Mock: ID photo uploaded')),
            );
          },
          icon: const Icon(Icons.upload_file),
          label: const Text('Upload ID Photo (Front & Back)'),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () {
            // Mock - would open camera
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Mock: Selfie uploaded')),
            );
          },
          icon: const Icon(Icons.camera_alt),
          label: const Text('Upload Selfie with ID'),
        ),
        const SizedBox(height: 16),

        // RA 8792 Consent
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Column(
            children: [
              CheckboxListTile(
                value: _ra8792Consent,
                onChanged: (value) {
                  setState(() => _ra8792Consent = value ?? false);
                },
                title: const Text(
                  'I agree that this verification and identity confirmation are legally binding under the Electronic Commerce Act of 2000 (RA 8792).',
                  style: TextStyle(fontSize: 13),
                ),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Submit Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isSubmitting ? null : _submitVerification,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: _isSubmitting
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Submit Verification'),
          ),
        ),
      ],
    );
  }

  String _idTypeLabel(GovernmentIdType type) {
    switch (type) {
      case GovernmentIdType.driversLicense:
        return "Driver's License";
      case GovernmentIdType.passport:
        return 'Passport';
      case GovernmentIdType.nationalId:
        return 'National ID (PhilSys)';
      case GovernmentIdType.umid:
        return 'UMID';
      case GovernmentIdType.sss:
        return 'SSS ID';
      case GovernmentIdType.gsis:
        return 'GSIS ID';
      case GovernmentIdType.philhealth:
        return 'PhilHealth ID';
      case GovernmentIdType.votersId:
        return "Voter's ID";
      case GovernmentIdType.prcId:
        return 'PRC ID';
    }
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.month}/${dt.day}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
