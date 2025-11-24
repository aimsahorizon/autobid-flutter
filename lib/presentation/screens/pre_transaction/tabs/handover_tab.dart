import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/handover_confirmation_model.dart';
import '../../../providers/ra_8792_pre_transaction_provider.dart';

/// Vehicle Handover Tab
/// Handles vehicle release and receipt confirmation
class HandoverTab extends ConsumerStatefulWidget {
  final String preTransactionId;
  final String userRole; // 'buyer' or 'seller'

  const HandoverTab({
    Key? key,
    required this.preTransactionId,
    required this.userRole,
  }) : super(key: key);

  @override
  ConsumerState<HandoverTab> createState() => _HandoverTabState();
}

class _HandoverTabState extends ConsumerState<HandoverTab> {
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();
  bool _conditionAccepted = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _releaseVehicle() async {
    if (_locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter release location')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final notifier = ref.read(
        ra8792PreTransactionProvider(widget.preTransactionId).notifier,
      );

      await notifier.releaseVehicle(
        photoUrls: [
          'mock://vehicle_front.jpg',
          'mock://vehicle_back.jpg',
          'mock://vehicle_interior.jpg',
        ], // Mock - would be actual uploads
        location: _locationController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vehicle release confirmed!'),
            backgroundColor: Colors.green,
          ),
        );
        _locationController.clear();
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

  Future<void> _confirmReceipt() async {
    setState(() => _isSubmitting = true);

    try {
      final notifier = ref.read(
        ra8792PreTransactionProvider(widget.preTransactionId).notifier,
      );

      await notifier.confirmVehicleReceived(
        conditionAccepted: _conditionAccepted,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vehicle receipt confirmed! Transaction complete!'),
            backgroundColor: Colors.green,
          ),
        );
        _notesController.clear();
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

    final handover = preTransaction?.handoverConfirmation;
    final notifier = ref.read(
      ra8792PreTransactionProvider(widget.preTransactionId).notifier,
    );

    final isPaymentConfirmed = notifier.isPaymentConfirmed;
    final isBuyer = widget.userRole == 'buyer';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Vehicle Handover',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Document vehicle transfer and condition',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 24),

          // Payment Check
          if (!isPaymentConfirmed)
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
                        'Payment must be confirmed before handover',
                        style: TextStyle(color: Colors.orange[900]),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else ...[
            // Seller Section
            if (!isBuyer) _buildSellerSection(handover),

            // Buyer Section
            if (isBuyer) _buildBuyerSection(handover),
          ],
        ],
      ),
    );
  }

  Widget _buildSellerSection(HandoverConfirmation? handover) {
    final hasReleased = handover?.sellerReleased ?? false;
    final isBuyerReceived = handover?.buyerReceived ?? false;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Release Vehicle',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            if (hasReleased) ...[
              _buildStatusChip('Vehicle Released', Colors.blue),
              const SizedBox(height: 12),
              _buildInfoRow('Location', handover!.releaseLocation ?? 'N/A'),
              _buildInfoRow('Released', _formatDateTime(handover.sellerReleasedAt!)),
              if (handover.sellerNotes != null)
                _buildInfoRow('Notes', handover.sellerNotes!),
              const SizedBox(height: 16),
              if (isBuyerReceived) ...[
                _buildStatusChip('Received by Buyer', Colors.green),
                const SizedBox(height: 8),
                _buildInfoRow('Received', _formatDateTime(handover.buyerReceivedAt!)),
                _buildInfoRow(
                  'Condition',
                  handover.buyerConditionAccepted ? 'Accepted' : 'Has notes',
                ),
                if (handover.buyerNotes != null)
                  _buildInfoRow('Buyer Notes', handover.buyerNotes!),
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
                        child: Text('Waiting for buyer to confirm receipt'),
                      ),
                    ],
                  ),
                ),
            ] else ...[
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Release Location',
                  border: OutlineInputBorder(),
                  hintText: 'e.g., Quezon City, Metro Manila',
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mock: Photos uploaded')),
                  );
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text('Upload Photos (Front, Back, Interior)'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Note: Upload photos showing current vehicle condition before release',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isSubmitting ? null : _releaseVehicle,
                  icon: const Icon(Icons.local_shipping),
                  label: const Text('Release Vehicle'),
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

  Widget _buildBuyerSection(HandoverConfirmation? handover) {
    final hasReleased = handover?.sellerReleased ?? false;
    final isBuyerReceived = handover?.buyerReceived ?? false;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Receive Vehicle',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            if (!hasReleased)
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
                      child: Text('Waiting for seller to release vehicle'),
                    ),
                  ],
                ),
              )
            else if (isBuyerReceived) ...[
              _buildStatusChip('Vehicle Received', Colors.green),
              const SizedBox(height: 12),
              _buildInfoRow('Received', _formatDateTime(handover!.buyerReceivedAt!)),
              _buildInfoRow(
                'Condition',
                handover.buyerConditionAccepted ? 'Accepted' : 'Has notes',
              ),
              if (handover.buyerNotes != null)
                _buildInfoRow('Notes', handover.buyerNotes!),
              const SizedBox(height: 16),
              _buildOwnershipDocuments(handover),
            ] else ...[
              _buildInfoRow('Location', handover!.releaseLocation ?? 'N/A'),
              _buildInfoRow('Released', _formatDateTime(handover.sellerReleasedAt!)),
              const SizedBox(height: 16),
              CheckboxListTile(
                value: _conditionAccepted,
                onChanged: (value) {
                  setState(() => _conditionAccepted = value ?? false);
                },
                title: const Text('I confirm the vehicle condition is as expected'),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes (Optional)',
                  border: OutlineInputBorder(),
                  hintText: 'Any observations or issues',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isSubmitting ? null : _confirmReceipt,
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Confirm Receipt'),
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

  Widget _buildOwnershipDocuments(HandoverConfirmation handover) {
    return Container(
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
              Icon(Icons.description, color: Colors.green[700], size: 20),
              const SizedBox(width: 8),
              const Text(
                'OWNERSHIP DOCUMENTS TRANSFERRED',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...handover.ownershipDocuments.map(
            (doc) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Icon(Icons.check, size: 16, color: Colors.green[700]),
                  const SizedBox(width: 8),
                  Text(doc, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
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

  String _formatDateTime(DateTime dt) {
    return '${dt.month}/${dt.day}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
