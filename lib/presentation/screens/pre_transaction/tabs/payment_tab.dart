import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/payment_confirmation_model.dart';
import '../../../providers/ra_8792_pre_transaction_provider.dart';

/// Payment Confirmation Tab
/// Handles payment initiation and confirmation
class PaymentTab extends ConsumerStatefulWidget {
  final String preTransactionId;
  final String userRole; // 'buyer' or 'seller'

  const PaymentTab({
    Key? key,
    required this.preTransactionId,
    required this.userRole,
  }) : super(key: key);

  @override
  ConsumerState<PaymentTab> createState() => _PaymentTabState();
}

class _PaymentTabState extends ConsumerState<PaymentTab> {
  PaymentMethod _selectedMethod = PaymentMethod.bankTransfer;
  final _referenceNumberController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _referenceNumberController.dispose();
    super.dispose();
  }

  Future<void> _initiatePayment() async {
    setState(() => _isSubmitting = true);

    try {
      final preTransaction = ref.read(
        ra8792PreTransactionProvider(widget.preTransactionId),
      );

      final amount = preTransaction?.digitalAgreement?.totalAmount ?? 0.0;

      final notifier = ref.read(
        ra8792PreTransactionProvider(widget.preTransactionId).notifier,
      );

      await notifier.initiatePayment(
        proofUrls: ['mock://payment_proof.jpg'], // Mock - would be actual upload
        method: _selectedMethod,
        referenceNumber: _referenceNumberController.text.isEmpty
            ? null
            : _referenceNumberController.text,
        amount: amount,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment initiated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        _referenceNumberController.clear();
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

  Future<void> _confirmPayment() async {
    setState(() => _isSubmitting = true);

    try {
      final notifier = ref.read(
        ra8792PreTransactionProvider(widget.preTransactionId).notifier,
      );

      await notifier.confirmPaymentReceived();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment confirmed successfully!'),
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

    final payment = preTransaction?.paymentConfirmation;
    final agreement = preTransaction?.digitalAgreement;
    final notifier = ref.read(
      ra8792PreTransactionProvider(widget.preTransactionId).notifier,
    );

    final isBothSigned = notifier.isBothSigned;
    final isBuyer = widget.userRole == 'buyer';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Payment Confirmation',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Electronic payment confirmation under RA 8792',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 24),

          // Agreement Check
          if (!isBothSigned)
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
                        'Both parties must sign the agreement before payment',
                        style: TextStyle(color: Colors.orange[900]),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else ...[
            // Payment Amount
            Card(
              color: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Amount',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₱${agreement?.totalAmount.toStringAsFixed(2) ?? '0.00'}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Final Bid: ₱${agreement?.finalBidPrice.toStringAsFixed(2) ?? '0.00'}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Additional Fees: ₱${agreement?.additionalFees.toStringAsFixed(2) ?? '0.00'}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Buyer Section
            if (isBuyer) _buildBuyerSection(payment),

            // Seller Section
            if (!isBuyer) _buildSellerSection(payment),

            const SizedBox(height: 16),

            // RA 8792 Acknowledgment
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
                        'RA 8792 ACKNOWLEDGMENT',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'This payment confirmation is an electronic acknowledgment under the Electronic Commerce Act of 2000 (RA 8792), Section 11. This electronic record has the same legal validity as a written receipt.',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBuyerSection(PaymentConfirmation? payment) {
    final hasInitiated = payment?.buyerInitiated ?? false;
    final isConfirmed = payment?.sellerConfirmed ?? false;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Buyer Payment',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            if (hasInitiated) ...[
              // Payment Initiated Status
              _buildStatusChip('Payment Initiated', Colors.blue),
              const SizedBox(height: 12),
              _buildInfoRow('Method', _paymentMethodLabel(payment!.paymentMethod!)),
              if (payment.paymentReferenceNumber != null)
                _buildInfoRow('Reference', payment.paymentReferenceNumber!),
              _buildInfoRow('Initiated', _formatDateTime(payment.buyerInitiatedAt!)),
              const SizedBox(height: 16),
              if (isConfirmed) ...[
                _buildStatusChip('Confirmed by Seller', Colors.green),
                const SizedBox(height: 8),
                _buildInfoRow('Confirmed', _formatDateTime(payment.sellerConfirmedAt!)),
              ] else
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
                      const Expanded(
                        child: Text('Waiting for seller confirmation'),
                      ),
                    ],
                  ),
                ),
            ] else ...[
              // Payment Form
              DropdownButtonFormField<PaymentMethod>(
                value: _selectedMethod,
                decoration: const InputDecoration(
                  labelText: 'Payment Method',
                  border: OutlineInputBorder(),
                ),
                items: PaymentMethod.values.map((method) {
                  return DropdownMenuItem(
                    value: method,
                    child: Text(_paymentMethodLabel(method)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedMethod = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _referenceNumberController,
                decoration: const InputDecoration(
                  labelText: 'Reference Number (Optional)',
                  border: OutlineInputBorder(),
                  hintText: 'e.g., Transaction ID, Check Number',
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mock: Proof of payment uploaded')),
                  );
                },
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload Proof of Payment'),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isSubmitting ? null : _initiatePayment,
                  icon: const Icon(Icons.payment),
                  label: const Text('Initiate Payment'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSellerSection(PaymentConfirmation? payment) {
    final hasInitiated = payment?.buyerInitiated ?? false;
    final isConfirmed = payment?.sellerConfirmed ?? false;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Seller Confirmation',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            if (!hasInitiated)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.hourglass_empty, color: Colors.grey[700]),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text('Waiting for buyer to initiate payment'),
                    ),
                  ],
                ),
              )
            else ...[
              _buildInfoRow('Method', _paymentMethodLabel(payment!.paymentMethod!)),
              if (payment.paymentReferenceNumber != null)
                _buildInfoRow('Reference', payment.paymentReferenceNumber!),
              _buildInfoRow('Amount', '₱${payment.amountPaid.toStringAsFixed(2)}'),
              _buildInfoRow('Initiated', _formatDateTime(payment.buyerInitiatedAt!)),
              const SizedBox(height: 16),
              if (isConfirmed) ...[
                _buildStatusChip('Payment Confirmed', Colors.green),
                const SizedBox(height: 8),
                _buildInfoRow('Confirmed', _formatDateTime(payment.sellerConfirmedAt!)),
              ] else
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isSubmitting ? null : _confirmPayment,
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Confirm Payment Received'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String label, Color color) {
    return Chip(
      label: Text(label),
      backgroundColor: color,
      labelStyle: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _paymentMethodLabel(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.bankTransfer:
        return 'Bank Transfer';
      case PaymentMethod.gcash:
        return 'GCash';
      case PaymentMethod.paymaya:
        return 'PayMaya';
      case PaymentMethod.bankCheck:
        return 'Bank Check';
      case PaymentMethod.other:
        return 'Other';
    }
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.month}/${dt.day}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
