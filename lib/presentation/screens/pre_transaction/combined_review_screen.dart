import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/pre_transaction_provider.dart';
import '../../../data/models/pre_transaction_model.dart';
import '../../../data/models/pre_transaction_confirmation_model.dart';
import '../../../core/constants/color_constants.dart';

/// Combined review screen where both buyer and seller review and approve final details
/// This phase occurs after both parties submit their confirmations but before admin review
class CombinedReviewScreen extends StatefulWidget {
  final String preTransactionId;
  final bool isSeller;

  const CombinedReviewScreen({
    super.key,
    required this.preTransactionId,
    this.isSeller = false,
  });

  @override
  State<CombinedReviewScreen> createState() => _CombinedReviewScreenState();
}

class _CombinedReviewScreenState extends State<CombinedReviewScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPreTransaction();
  }

  Future<void> _loadPreTransaction() async {
    final provider = context.read<PreTransactionProvider>();
    await provider.loadPreTransaction(widget.preTransactionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Combined Review'),
        centerTitle: true,
      ),
      body: Consumer<PreTransactionProvider>(
        builder: (context, provider, child) {
          final preTransaction = provider.currentPreTransaction;

          if (preTransaction == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final buyerConfirmation = preTransaction.buyerConfirmation;
          final sellerConfirmation = preTransaction.sellerConfirmation;

          if (buyerConfirmation == null || sellerConfirmation == null) {
            return const Center(
              child: Text('Waiting for both parties to submit confirmations...'),
            );
          }

          final userRole = widget.isSeller ? 'seller' : 'buyer';
          final hasUserApproved = widget.isSeller
              ? preTransaction.sellerMutualReviewApproved
              : preTransaction.buyerMutualReviewApproved;
          final hasOtherApproved = widget.isSeller
              ? preTransaction.buyerMutualReviewApproved
              : preTransaction.sellerMutualReviewApproved;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with status
                _buildHeader(preTransaction, hasUserApproved, hasOtherApproved),
                const SizedBox(height: 24),

                // Edit requests (if any)
                if (preTransaction.editRequests.isNotEmpty) ...[
                  _buildEditRequestsSection(preTransaction.editRequests),
                  const SizedBox(height: 24),
                ],

                // Combined details comparison
                const Text(
                  'Review Combined Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                _buildComparisonCard(
                  'Buyer Confirmation',
                  buyerConfirmation,
                  Icons.person,
                  Colors.blue,
                ),
                const SizedBox(height: 16),

                _buildComparisonCard(
                  'Seller Confirmation',
                  sellerConfirmation,
                  Icons.storefront,
                  Colors.green,
                ),
                const SizedBox(height: 24),

                // Action buttons
                _buildActionButtons(
                  preTransaction,
                  hasUserApproved,
                  hasOtherApproved,
                  userRole,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(
    PreTransaction preTransaction,
    bool hasUserApproved,
    bool hasOtherApproved,
  ) {
    final bothApproved = hasUserApproved && hasOtherApproved;
    final color = bothApproved
        ? Colors.green
        : hasUserApproved
            ? Colors.orange
            : Colors.red;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            bothApproved
                ? Icons.check_circle
                : hasUserApproved
                    ? Icons.hourglass_empty
                    : Icons.pending,
            color: color,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bothApproved
                      ? 'Both Parties Approved!'
                      : hasUserApproved
                          ? 'Waiting for ${widget.isSeller ? 'Buyer' : 'Seller'}'
                          : 'Your Approval Needed',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  bothApproved
                      ? 'Transaction will proceed to admin review'
                      : hasUserApproved
                          ? 'You have approved. Waiting for the other party to review.'
                          : 'Please review the combined details and approve to proceed.',
                  style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditRequestsSection(List<EditRequest> editRequests) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Edit Requests',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...editRequests.map((request) => _buildEditRequestCard(request)),
      ],
    );
  }

  Widget _buildEditRequestCard(EditRequest request) {
    final isFromCurrentUser = widget.isSeller
        ? request.requestedBy == 'seller'
        : request.requestedBy == 'buyer';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isFromCurrentUser ? Icons.send : Icons.inbox,
                  size: 20,
                  color: isFromCurrentUser ? Colors.blue : Colors.orange,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isFromCurrentUser
                        ? 'You requested an edit'
                        : '${widget.isSeller ? 'Buyer' : 'Seller'} requested an edit',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (request.resolved)
                  const Icon(Icons.check_circle, color: Colors.green, size: 20),
              ],
            ),
            const SizedBox(height: 8),
            _buildDetailRow('Field', request.field),
            _buildDetailRow('Current Value', request.currentValue),
            _buildDetailRow('Requested Value', request.requestedValue),
            _buildDetailRow('Reason', request.reason),
            _buildDetailRow(
              'Requested',
              DateFormat('MMM dd, yyyy h:mm a').format(request.requestedAt),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonCard(
    String title,
    PreTransactionConfirmation confirmation,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildConfirmationItem(
              'Submitted By',
              confirmation.userName,
              Icons.person,
            ),
            _buildConfirmationItem(
              'Vehicle Identity Confirmed',
              confirmation.vehicleIdentityConfirmed ? 'Yes' : 'No',
              Icons.check_circle,
            ),
            _buildConfirmationItem(
              'Final Bid Price',
              '₱${_formatCurrency(confirmation.finalBidPrice)}',
              Icons.payment,
            ),
            if (confirmation.deliveryDate != null)
              _buildConfirmationItem(
                'Delivery Date',
                confirmation.deliveryDate!,
                Icons.calendar_today,
              ),
            if (confirmation.deliveryLocation != null)
              _buildConfirmationItem(
                'Delivery Location',
                confirmation.deliveryLocation!,
                Icons.location_on,
              ),
            if (confirmation.notes != null && confirmation.notes!.isNotEmpty)
              _buildConfirmationItem(
                'Notes',
                confirmation.notes!,
                Icons.note,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    PreTransaction preTransaction,
    bool hasUserApproved,
    bool hasOtherApproved,
    String userRole,
  ) {
    final bothApproved = hasUserApproved && hasOtherApproved;

    return Column(
      children: [
        // Request Edit button
        if (!bothApproved)
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton.icon(
              onPressed: () => _showRequestEditDialog(),
              icon: const Icon(Icons.edit),
              label: Text('Request Edit from ${widget.isSeller ? 'Buyer' : 'Seller'}'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.orange,
              ),
            ),
          ),
        const SizedBox(height: 12),

        // Approve button
        if (!hasUserApproved)
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : () => _showFinalConfirmationDialog(userRole),
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Icon(Icons.check_circle),
              label: Text(_isLoading ? 'Approving...' : 'Approve & Confirm'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.primaryGreen,
                foregroundColor: Colors.white,
              ),
            ),
          ),

        // Already approved message
        if (hasUserApproved && !bothApproved)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'You have approved. Waiting for ${widget.isSeller ? 'buyer' : 'seller'} to approve.',
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),

        // Both approved message
        if (bothApproved)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.withOpacity(0.3)),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '✓ Both parties approved! Transaction is being submitted to admin for final review.',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Future<void> _showRequestEditDialog() async {
    final fieldController = TextEditingController();
    final currentValueController = TextEditingController();
    final requestedValueController = TextEditingController();
    final reasonController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request Edit'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: fieldController,
                decoration: const InputDecoration(
                  labelText: 'Field Name',
                  hintText: 'e.g., Delivery Date',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: currentValueController,
                decoration: const InputDecoration(
                  labelText: 'Current Value',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: requestedValueController,
                decoration: const InputDecoration(
                  labelText: 'Requested Value',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: reasonController,
                decoration: const InputDecoration(
                  labelText: 'Reason for Edit',
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (fieldController.text.isEmpty ||
                  requestedValueController.text.isEmpty ||
                  reasonController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all fields')),
                );
                return;
              }

              Navigator.pop(context);

              setState(() => _isLoading = true);
              final provider = context.read<PreTransactionProvider>();
              final success = await provider.requestEdit(
                requestedBy: widget.isSeller ? 'seller' : 'buyer',
                field: fieldController.text,
                currentValue: currentValueController.text,
                requestedValue: requestedValueController.text,
                reason: reasonController.text,
              );
              setState(() => _isLoading = false);

              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'Edit request sent!'
                          : 'Failed to send edit request',
                    ),
                    backgroundColor: success ? Colors.green : Colors.red,
                  ),
                );
              }
            },
            child: const Text('Send Request'),
          ),
        ],
      ),
    );
  }

  Future<void> _showFinalConfirmationDialog(String userRole) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Final Confirmation'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '⚠️ This is your final confirmation',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'By confirming, you agree that:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text('• All details have been reviewed and are accurate'),
            Text('• You agree to proceed with the transaction'),
            Text('• Changes can only be made through admin support'),
            SizedBox(height: 16),
            Text(
              'Do you want to proceed?',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.primaryGreen,
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() => _isLoading = true);
      final provider = context.read<PreTransactionProvider>();
      final success = await provider.approveMutualReview(
        approvedBy: userRole,
      );
      setState(() => _isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? 'Approved successfully!' : 'Failed to approve',
            ),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      }
    }
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
