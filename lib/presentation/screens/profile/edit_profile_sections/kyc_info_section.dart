import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/models/kyc_model.dart';

/// Section 4: KYC Information (View-Only)
/// - Verification Status
/// - ID Type & Number (masked)
/// - Submission Date
/// - Verification/Rejection Details
/// - Proof of Address Status
/// - Background Check Status
class KycInfoSection extends ConsumerWidget {
  final UserModel user;

  const KycInfoSection({super.key, required this.user});

  Color _getKycStatusColor(KycVerificationStatus? status) {
    if (status == null) return Colors.grey;
    switch (status) {
      case KycVerificationStatus.verified:
        return Colors.green;
      case KycVerificationStatus.pending:
        return Colors.orange;
      case KycVerificationStatus.rejected:
        return Colors.red;
    }
  }

  String _getKycStatusText(KycVerificationStatus? status) {
    if (status == null) return 'Not Submitted';
    switch (status) {
      case KycVerificationStatus.verified:
        return 'Verified';
      case KycVerificationStatus.pending:
        return 'Pending Verification';
      case KycVerificationStatus.rejected:
        return 'Rejected';
    }
  }

  Color _getBackgroundCheckColor(BackgroundCheckStatus status) {
    switch (status) {
      case BackgroundCheckStatus.cleared:
        return Colors.green;
      case BackgroundCheckStatus.pending:
        return Colors.orange;
      case BackgroundCheckStatus.rejected:
        return Colors.red;
      case BackgroundCheckStatus.none:
        return Colors.grey;
    }
  }

  String _getBackgroundCheckText(BackgroundCheckStatus status) {
    switch (status) {
      case BackgroundCheckStatus.cleared:
        return 'Cleared';
      case BackgroundCheckStatus.pending:
        return 'Pending';
      case BackgroundCheckStatus.rejected:
        return 'Issues Found';
      case BackgroundCheckStatus.none:
        return 'Not Required';
    }
  }

  String _getIdTypeText(IdType idType) {
    switch (idType) {
      case IdType.nationalId:
        return 'National ID (PhilSys)';
      case IdType.driversLicense:
        return 'Driver\'s License';
      case IdType.passport:
        return 'Passport';
      case IdType.votersId:
        return 'Voter\'s ID';
    }
  }

  String _getProofOfAddressTypeText(ProofOfAddressType type) {
    switch (type) {
      case ProofOfAddressType.utilityBill:
        return 'Utility Bill';
      case ProofOfAddressType.bankStatement:
        return 'Bank Statement';
      case ProofOfAddressType.governmentLetter:
        return 'Government Letter';
      case ProofOfAddressType.rentalContract:
        return 'Rental Contract';
      case ProofOfAddressType.barangayCertificate:
        return 'Barangay Certificate';
    }
  }

  String _maskIdNumber(String idNumber) {
    if (idNumber.length <= 4) return idNumber;
    final visiblePart = idNumber.substring(idNumber.length - 4);
    final maskedPart = '*' * (idNumber.length - 4);
    return '$maskedPart$visiblePart';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kycData = user.kycData;
    final hasKycData = kycData != null;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Section Header
        Text(
          'KYC Information',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Know Your Customer verification details (view-only)',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(height: 24),

        // Overall KYC Status
        Card(
          child: ListTile(
            leading: Icon(
              Icons.verified_user,
              color: _getKycStatusColor(kycData?.verificationStatus),
            ),
            title: const Text('KYC Verification Status'),
            subtitle: Text(_getKycStatusText(kycData?.verificationStatus)),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getKycStatusColor(kycData?.verificationStatus).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _getKycStatusColor(kycData?.verificationStatus),
                ),
              ),
              child: Text(
                _getKycStatusText(kycData?.verificationStatus).toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: _getKycStatusColor(kycData?.verificationStatus),
                ),
              ),
            ),
          ),
        ),

        if (!hasKycData) ...[
          const SizedBox(height: 24),
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue.shade700, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    'No KYC Submitted',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You haven\'t submitted your KYC documents yet. Complete KYC verification to unlock full platform features.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () {
                      // TODO: Navigate to KYC submission flow
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('KYC submission flow coming soon'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.upload_file, size: 18),
                    label: const Text('Submit KYC Documents'),
                  ),
                ],
              ),
            ),
          ),
        ],

        if (hasKycData) ...[
          const SizedBox(height: 12),

          // Primary ID Information
          Card(
            child: ListTile(
              leading: const Icon(Icons.badge, color: Colors.blue),
              title: const Text('Primary ID Type'),
              subtitle: Text(_getIdTypeText(kycData!.idType)),
            ),
          ),
          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(Icons.numbers, color: Colors.purple),
              title: const Text('ID Number'),
              subtitle: Text(
                _maskIdNumber(kycData.idNumber),
                style: const TextStyle(fontFamily: 'monospace'),
              ),
              trailing: const Icon(Icons.visibility_off, size: 16, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 12),

          // Submission Date
          Card(
            color: Colors.grey[50],
            child: ListTile(
              leading: const Icon(Icons.calendar_today, color: Colors.grey),
              title: const Text('Submitted On'),
              subtitle: Text(
                '${kycData.submittedAt.year}-${kycData.submittedAt.month.toString().padLeft(2, '0')}-${kycData.submittedAt.day.toString().padLeft(2, '0')}',
              ),
            ),
          ),

          // Verification Date (if verified)
          if (kycData.verifiedAt != null) ...[
            const SizedBox(height: 12),
            Card(
              color: Colors.green.shade50,
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green.shade700),
                title: const Text('Verified On'),
                subtitle: Text(
                  '${kycData.verifiedAt!.year}-${kycData.verifiedAt!.month.toString().padLeft(2, '0')}-${kycData.verifiedAt!.day.toString().padLeft(2, '0')}',
                ),
              ),
            ),
          ],

          // Rejection Reason (if rejected)
          if (kycData.verificationStatus == KycVerificationStatus.rejected &&
              kycData.rejectionReason != null) ...[
            const SizedBox(height: 12),
            Card(
              color: Colors.red.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.cancel, color: Colors.red.shade700),
                        const SizedBox(width: 8),
                        Text(
                          'Rejection Reason',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      kycData.rejectionReason!,
                      style: TextStyle(color: Colors.red.shade900),
                    ),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed: () {
                        // TODO: Navigate to KYC resubmission
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('KYC resubmission flow coming soon'),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.red.shade700,
                      ),
                      icon: const Icon(Icons.refresh, size: 18),
                      label: const Text('Resubmit KYC'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],

        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 16),

        // Additional Verification Details
        Text(
          'Additional Verification',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),

        // Proof of Address
        Card(
          child: ListTile(
            leading: Icon(
              Icons.home_work,
              color: user.proofOfAddress?.verified == true
                  ? Colors.green
                  : Colors.grey,
            ),
            title: const Text('Proof of Address'),
            subtitle: user.proofOfAddress != null
                ? Text(_getProofOfAddressTypeText(user.proofOfAddress!.type))
                : const Text('Not submitted'),
            trailing: user.proofOfAddress?.verified == true
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
          ),
        ),
        const SizedBox(height: 12),

        // Background Check
        Card(
          child: ListTile(
            leading: Icon(
              Icons.security,
              color: _getBackgroundCheckColor(user.backgroundCheckStatus),
            ),
            title: const Text('Background Check'),
            subtitle: Text(_getBackgroundCheckText(user.backgroundCheckStatus)),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getBackgroundCheckColor(user.backgroundCheckStatus)
                    .withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _getBackgroundCheckColor(user.backgroundCheckStatus),
                ),
              ),
              child: Text(
                _getBackgroundCheckText(user.backgroundCheckStatus).toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: _getBackgroundCheckColor(user.backgroundCheckStatus),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // NBI Clearance
        Card(
          child: user.nbiClearance != null
              ? ExpansionTile(
                  leading: const Icon(Icons.shield, color: Colors.blue),
                  title: const Text('NBI Clearance'),
                  subtitle: Text(
                    'Valid until ${user.nbiClearance!.expiryDate.year}-${user.nbiClearance!.expiryDate.month.toString().padLeft(2, '0')}-${user.nbiClearance!.expiryDate.day.toString().padLeft(2, '0')}',
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                              const SizedBox(width: 8),
                              const Text('Issue Date: '),
                              Text(
                                '${user.nbiClearance!.issueDate.year}-${user.nbiClearance!.issueDate.month.toString().padLeft(2, '0')}-${user.nbiClearance!.issueDate.day.toString().padLeft(2, '0')}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const ListTile(
                  leading: Icon(Icons.shield, color: Colors.grey),
                  title: Text('NBI Clearance'),
                  subtitle: Text('Not submitted'),
                ),
        ),

        const SizedBox(height: 24),

        // Help Text
        Card(
          color: Colors.amber.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.help_outline, color: Colors.amber.shade700),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Need Help?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.amber.shade900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'If you have questions about your KYC verification status or need to update your documents, please contact support.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.amber.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
