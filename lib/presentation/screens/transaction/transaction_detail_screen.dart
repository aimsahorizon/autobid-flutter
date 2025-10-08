import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../data/models/transaction_model.dart';
import '../../providers/transaction_provider.dart';
import '../../widgets/custom_button.dart';
import '../payment/widgets/escrow_status_card.dart';
import '../payment/widgets/payment_summary.dart';
import 'widgets/escrow_info_card.dart';
import 'widgets/timeline_widget.dart';

class TransactionDetailScreen extends StatefulWidget {
  final String transactionId;

  const TransactionDetailScreen({
    super.key,
    required this.transactionId,
  });

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTransaction();
    });
  }

  Future<void> _loadTransaction() async {
    await context.read<TransactionProvider>().loadTransaction(
          widget.transactionId,
        );
  }

  Future<void> _confirmReceipt() async {
    final transaction = context.read<TransactionProvider>().currentTransaction;
    if (transaction == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Vehicle Receipt'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Have you received the vehicle?'),
            const SizedBox(height: 16),
            const Text('Next, you\'ll need to submit:'),
            const SizedBox(height: 8),
            _buildRequirementRow('Transfer documents (CR/OR)'),
            _buildRequirementRow('Vehicle photos & odometer'),
            _buildRequirementRow('VIN verification'),
            _buildRequirementRow('Delivery receipt'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: Colors.blue[700]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'This protects both you and the seller',
                      style: TextStyle(fontSize: 12, color: Colors.blue[900]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Continue'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      // Navigate to transfer evidence screen
      context.push(
        '/submit-evidence/${transaction.id}?carTitle=${Uri.encodeComponent(transaction.carTitle)}',
      );
    }
  }

  Widget _buildRequirementRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, size: 16, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _markAsShipped() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mark as Shipped'),
        content: const Text(
          'Confirm that the vehicle has been shipped to the buyer?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final success = await context
          .read<TransactionProvider>()
          .markAsShipped(widget.transactionId);

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Marked as shipped'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home?tab=2&subTab=1');
          },
          tooltip: 'Back to Won Auctions',
        ),
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.currentTransaction == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.currentTransaction == null) {
            return const Center(
              child: Text('Transaction not found'),
            );
          }

          final transaction = provider.currentTransaction!;
          final isBuyer = transaction.buyerId == 'user123';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCarInfo(transaction),
                const SizedBox(height: 24),
                PaymentSummary(
                  amount: transaction.amount,
                  showDetails: false,
                ),
                const SizedBox(height: 24),
                EscrowStatusCard(transaction: transaction),
                const SizedBox(height: 24),
                _buildParticipantsInfo(transaction, isBuyer),
                const SizedBox(height: 24),
                if (transaction.paymentMethod != null)
                  _buildPaymentInfo(transaction),
                const SizedBox(height: 24),
                TimelineWidget(timeline: transaction.timeline),
                const SizedBox(height: 24),
                const EscrowInfoCard(),
                const SizedBox(height: 24),
                _buildActionButtons(transaction, isBuyer),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCarInfo(Transaction transaction) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.directions_car,
              color: Colors.grey[400],
              size: 40,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.carTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Transaction ID: ${transaction.id}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantsInfo(Transaction transaction, bool isBuyer) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.person_outline, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Buyer:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 8),
              Text(transaction.buyerName),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.store_outlined, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Seller:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 8),
              Text(transaction.sellerName),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInfo(Transaction transaction) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Method:'),
              Text(
                transaction.paymentMethod.toString().split('.').last,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          if (transaction.paymentReference != null) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Reference:'),
                Text(
                  transaction.paymentReference!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons(Transaction transaction, bool isBuyer) {
    if (transaction.escrowStatus == EscrowStatus.released ||
        transaction.escrowStatus == EscrowStatus.refunded ||
        transaction.escrowStatus == EscrowStatus.validating) {
      return const SizedBox.shrink();
    }

    if (isBuyer && transaction.escrowStatus == EscrowStatus.held) {
      return Column(
        children: [
          CustomButton(
            text: 'Confirm Receipt',
            onPressed: _confirmReceipt,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                // Request refund
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red, width: 2),
                foregroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Request Refund',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      );
    }

    if (!isBuyer && transaction.escrowStatus == EscrowStatus.held) {
      return CustomButton(
        text: 'Mark as Shipped',
        onPressed: _markAsShipped,
      );
    }

    return const SizedBox.shrink();
  }
}
