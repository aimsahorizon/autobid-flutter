import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/digital_agreement_model.dart';
import '../../../providers/ra_8792_pre_transaction_provider.dart';

/// Digital Agreement Tab
/// Shows auto-generated contract and signature functionality
class AgreementTab extends ConsumerStatefulWidget {
  final String preTransactionId;
  final String userRole; // 'buyer' or 'seller'
  final String userId;

  const AgreementTab({
    Key? key,
    required this.preTransactionId,
    required this.userRole,
    required this.userId,
  }) : super(key: key);

  @override
  ConsumerState<AgreementTab> createState() => _AgreementTabState();
}

class _AgreementTabState extends ConsumerState<AgreementTab> {
  final _signatureController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  Future<void> _generateAgreement() async {
    setState(() => _isSubmitting = true);

    try {
      final notifier = ref.read(
        ra8792PreTransactionProvider(widget.preTransactionId).notifier,
      );

      await notifier.generateDigitalAgreement();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Agreement generated successfully!'),
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

  Future<void> _signAgreement() async {
    if (_signatureController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your signature')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final notifier = ref.read(
        ra8792PreTransactionProvider(widget.preTransactionId).notifier,
      );

      await notifier.signAgreement(
        userId: widget.userId,
        signature: _signatureController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Agreement signed successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        _signatureController.clear();
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

    final agreement = preTransaction?.digitalAgreement;
    final notifier = ref.read(
      ra8792PreTransactionProvider(widget.preTransactionId).notifier,
    );

    final isBothVerified = notifier.isBothVerified;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Digital Sale Agreement',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Legally binding electronic contract under RA 8792',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 24),

          // Verification Check
          if (!isBothVerified)
            Card(
              color: Colors.orange.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.orange[700]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Both parties must be verified before generating the agreement',
                        style: TextStyle(color: Colors.orange[900]),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else if (agreement == null)
            // Generate Agreement Button
            Center(
              child: ElevatedButton.icon(
                onPressed: _isSubmitting ? null : _generateAgreement,
                icon: const Icon(Icons.description),
                label: const Text('Generate Agreement'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
            )
          else
            // Show Agreement
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAgreementContent(agreement),
                const SizedBox(height: 24),
                _buildSignatureSection(agreement),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildAgreementContent(DigitalAgreement agreement) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Center(
              child: Text(
                'VEHICLE SALE AGREEMENT',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const Divider(height: 32),

            // Parties
            _buildSectionTitle('PARTIES'),
            _buildInfoRow('Buyer', agreement.buyerName),
            _buildInfoRow('Seller', agreement.sellerName),
            const SizedBox(height: 16),

            // Vehicle Details
            _buildSectionTitle('VEHICLE DETAILS'),
            _buildInfoRow('Make', agreement.vehicleMake),
            _buildInfoRow('Model', agreement.vehicleModel),
            _buildInfoRow('Year', agreement.vehicleYear),
            _buildInfoRow('VIN', agreement.vinNumber),
            _buildInfoRow('License Plate', agreement.licensePlate),
            if (agreement.vehicleColor != null)
              _buildInfoRow('Color', agreement.vehicleColor!),
            const SizedBox(height: 16),

            // Financial Terms
            _buildSectionTitle('FINANCIAL TERMS'),
            _buildInfoRow('Final Bid Price', '₱${agreement.finalBidPrice.toStringAsFixed(2)}'),
            _buildInfoRow('Additional Fees', '₱${agreement.additionalFees.toStringAsFixed(2)}'),
            _buildInfoRow('Total Amount', '₱${agreement.totalAmount.toStringAsFixed(2)}',
                isBold: true),
            const SizedBox(height: 16),

            // Terms & Conditions
            _buildSectionTitle('TERMS & CONDITIONS'),
            Text('Payment: ${agreement.paymentTerms}'),
            const SizedBox(height: 8),
            Text('Delivery: ${agreement.deliveryMethod}'),
            const SizedBox(height: 8),
            Text('Transfer: ${agreement.transferAcknowledgment ? 'Ownership transfers upon delivery and full payment' : 'Custom transfer terms'}'),
            const SizedBox(height: 16),

            // Legal Consent (RA 8792)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.gavel, color: Colors.green[700], size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'LEGAL CONSENT (RA 8792)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    agreement.legalConsentText,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Dispute Clause
            _buildSectionTitle('DISPUTE RESOLUTION'),
            Text(
              agreement.disputeClause,
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 16),

            // Document Hash
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Icon(Icons.fingerprint, size: 16, color: Colors.grey[700]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Document Hash: ${agreement.documentHash}',
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignatureSection(DigitalAgreement agreement) {
    final isBuyer = widget.userRole == 'buyer';
    final userSigned = isBuyer ? agreement.buyerSignature != null : agreement.sellerSignature != null;
    final otherSigned = isBuyer ? agreement.sellerSignature != null : agreement.buyerSignature != null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Signatures',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            // Buyer Signature
            _buildSignatureStatus(
              'Buyer',
              agreement.buyerSignature,
              agreement.buyerSignedAt,
              agreement.buyerName,
            ),
            const SizedBox(height: 12),

            // Seller Signature
            _buildSignatureStatus(
              'Seller',
              agreement.sellerSignature,
              agreement.sellerSignedAt,
              agreement.sellerName,
            ),
            const SizedBox(height: 16),

            // Sign Button (if user hasn't signed)
            if (!userSigned) ...[
              const Divider(),
              const SizedBox(height: 16),
              Text(
                'Your Signature',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _signatureController,
                decoration: const InputDecoration(
                  labelText: 'Type your full name to sign',
                  border: OutlineInputBorder(),
                  hintText: 'e.g., Juan Dela Cruz',
                  helperText: 'Note: Production version will use digital signature pad',
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isSubmitting ? null : _signAgreement,
                  icon: const Icon(Icons.edit),
                  label: const Text('Sign Agreement'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ] else ...[
              const Divider(),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green[700]),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text('You have signed this agreement'),
                    ),
                  ],
                ),
              ),
              if (!otherSigned) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.hourglass_empty, color: Colors.orange[700]),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Waiting for ${isBuyer ? 'seller' : 'buyer'} signature',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Color(0xFF4CAF50),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignatureStatus(
    String party,
    String? signature,
    DateTime? signedAt,
    String name,
  ) {
    final isSigned = signature != null;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSigned ? Colors.green.shade50 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSigned ? Colors.green.shade200 : Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isSigned ? Icons.check_circle : Icons.pending,
            color: isSigned ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$party: $name',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (isSigned) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Signed: ${_formatDateTime(signedAt!)}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ] else
                  const Text(
                    'Not signed',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.month}/${dt.day}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
