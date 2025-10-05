import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/kyc_provider.dart';
import '../../../data/models/kyc_model.dart';
import '../../widgets/kyc_status_badge.dart';
import 'package:intl/intl.dart';

class KycStatusScreen extends StatefulWidget {
  const KycStatusScreen({super.key});

  @override
  State<KycStatusScreen> createState() => _KycStatusScreenState();
}

class _KycStatusScreenState extends State<KycStatusScreen> {
  @override
  void initState() {
    super.initState();
    // Load KYC status on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<KycProvider>();
      provider.loadKycStatus('mock-user-id');
    });
  }

  @override
  Widget build(BuildContext context) {
    final kycProvider = context.watch<KycProvider>();
    final kycData = kycProvider.kycData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('KYC Status'),
        actions: [
          if (kycData?.verificationStatus == KycVerificationStatus.verified)
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () => context.go('/'),
            ),
        ],
      ),
      body: kycProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : kycData == null
              ? _buildNoKycData(context)
              : _buildKycStatus(context, kycData),
    );
  }

  Widget _buildNoKycData(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 24),
            Text(
              'No KYC Submission Found',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'You haven\'t submitted your KYC documents yet',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () => context.go('/kyc-intro'),
              child: const Text('Start KYC Verification'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKycStatus(BuildContext context, KycModel kycData) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Status Icon
          _buildStatusIcon(context, kycData.verificationStatus),
          const SizedBox(height: 24),

          // Status Badge
          KycStatusBadge(status: kycData.verificationStatus),
          const SizedBox(height: 16),

          // Status Message
          Text(
            _getStatusTitle(kycData.verificationStatus),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            _getStatusMessage(kycData.verificationStatus),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Details Card
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Submission Details',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                    context,
                    icon: Icons.credit_card,
                    label: 'ID Type',
                    value: _getIdTypeName(kycData.idType),
                  ),
                  const Divider(height: 24),
                  _buildDetailRow(
                    context,
                    icon: Icons.numbers,
                    label: 'ID Number',
                    value: kycData.idNumber,
                  ),
                  const Divider(height: 24),
                  _buildDetailRow(
                    context,
                    icon: Icons.calendar_today,
                    label: 'Submitted',
                    value: DateFormat('MMM dd, yyyy - hh:mm a')
                        .format(kycData.submittedAt),
                  ),
                  if (kycData.verifiedAt != null) ...[
                    const Divider(height: 24),
                    _buildDetailRow(
                      context,
                      icon: Icons.check_circle,
                      label: 'Verified',
                      value: DateFormat('MMM dd, yyyy - hh:mm a')
                          .format(kycData.verifiedAt!),
                    ),
                  ],
                  if (kycData.rejectionReason != null) ...[
                    const Divider(height: 24),
                    _buildDetailRow(
                      context,
                      icon: Icons.error_outline,
                      label: 'Reason',
                      value: kycData.rejectionReason!,
                      valueColor: Colors.red.shade900,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Action Buttons
          if (kycData.verificationStatus == KycVerificationStatus.pending)
            _buildPendingActions(context),
          if (kycData.verificationStatus == KycVerificationStatus.verified)
            _buildVerifiedActions(context),
          if (kycData.verificationStatus == KycVerificationStatus.rejected)
            _buildRejectedActions(context),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(
      BuildContext context, KycVerificationStatus status) {
    IconData icon;
    Color color;

    switch (status) {
      case KycVerificationStatus.verified:
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case KycVerificationStatus.pending:
        icon = Icons.schedule;
        color = Colors.orange;
        break;
      case KycVerificationStatus.rejected:
        icon = Icons.cancel;
        color = Colors.red;
        break;
    }

    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 64,
        color: color,
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: valueColor,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPendingActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.orange.shade900),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your documents are being reviewed. This typically takes a few minutes.',
              style: TextStyle(
                color: Colors.orange.shade900,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifiedActions(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: () => context.go('/'),
        icon: const Icon(Icons.home),
        label: const Text('Go to Home'),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }

  Widget _buildRejectedActions(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () {
              final provider = context.read<KycProvider>();
              provider.resetForm();
              context.go('/kyc-upload');
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Resubmit KYC'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => context.go('/'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Back to Home'),
          ),
        ),
      ],
    );
  }

  String _getStatusTitle(KycVerificationStatus status) {
    switch (status) {
      case KycVerificationStatus.verified:
        return 'Verification Complete!';
      case KycVerificationStatus.pending:
        return 'Verification in Progress';
      case KycVerificationStatus.rejected:
        return 'Verification Rejected';
    }
  }

  String _getStatusMessage(KycVerificationStatus status) {
    switch (status) {
      case KycVerificationStatus.verified:
        return 'Your identity has been successfully verified. You can now access all features.';
      case KycVerificationStatus.pending:
        return 'We\'re reviewing your documents. You\'ll be notified once the verification is complete.';
      case KycVerificationStatus.rejected:
        return 'Unfortunately, we couldn\'t verify your identity. Please review the reason and try again.';
    }
  }

  String _getIdTypeName(IdType type) {
    switch (type) {
      case IdType.nationalId:
        return 'National ID';
      case IdType.driversLicense:
        return 'Driver\'s License';
      case IdType.passport:
        return 'Passport';
      case IdType.votersId:
        return 'Voter\'s ID';
    }
  }
}
