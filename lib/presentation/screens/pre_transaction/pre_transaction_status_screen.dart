import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/pre_transaction_provider.dart';
import '../../../data/models/pre_transaction_model.dart';
import '../../../core/constants/color_constants.dart';
import '../../widgets/custom_button.dart';

class PreTransactionStatusScreen extends StatefulWidget {
  final String auctionId;
  final String carTitle;
  final double winningBid;

  const PreTransactionStatusScreen({
    super.key,
    required this.auctionId,
    required this.carTitle,
    required this.winningBid,
  });

  @override
  State<PreTransactionStatusScreen> createState() => _PreTransactionStatusScreenState();
}

class _PreTransactionStatusScreenState extends State<PreTransactionStatusScreen> {
  @override
  void initState() {
    super.initState();
    _loadPreTransaction();
  }

  Future<void> _loadPreTransaction() async {
    final provider = context.read<PreTransactionProvider>();
    await provider.loadPreTransactionByAuctionId(widget.auctionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pre-Transaction Status'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<PreTransactionProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final preTransaction = provider.currentPreTransaction;

          if (preTransaction == null) {
            return const Center(child: Text('Failed to load status'));
          }

          return RefreshIndicator(
            onRefresh: _loadPreTransaction,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCarSummary(),
                  const SizedBox(height: 24),
                  _buildProgressTracker(preTransaction),
                  const SizedBox(height: 24),
                  _buildStatusCard(preTransaction),
                  const SizedBox(height: 24),
                  _buildConfirmationDetails(preTransaction),
                  const SizedBox(height: 24),
                  _buildActionButtons(provider, preTransaction),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCarSummary() {
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
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.directions_car,
              color: Colors.grey[400],
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.carTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Winning Bid: ₱${_formatCurrency(widget.winningBid)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTracker(PreTransaction preTransaction) {
    final steps = [
      _StepInfo('Auction Ended', true, Icons.gavel),
      _StepInfo('Discussion', preTransaction.discussionStartedAt != null, Icons.chat),
      _StepInfo('Confirmed', preTransaction.buyerConfirmedAt != null, Icons.check_circle),
      _StepInfo('Ready for Payment', preTransaction.status == PreTransactionStatus.readyForPayment, Icons.payment),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Transaction Progress',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(steps.length, (index) {
              final step = steps[index];
              final isLast = index == steps.length - 1;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: step.isCompleted
                              ? ColorConstants.primaryGreen
                              : Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          step.icon,
                          color: step.isCompleted ? Colors.white : Colors.grey[600],
                          size: 20,
                        ),
                      ),
                      if (!isLast)
                        Container(
                          width: 2,
                          height: 40,
                          color: step.isCompleted
                              ? ColorConstants.primaryGreen
                              : Colors.grey[300],
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8, bottom: isLast ? 0 : 16),
                      child: Text(
                        step.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: step.isCompleted ? FontWeight.w600 : FontWeight.normal,
                          color: step.isCompleted ? Colors.black87 : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(PreTransaction preTransaction) {
    final isWaitingForSeller = preTransaction.status == PreTransactionStatus.pendingSellerConfirmation;
    final isReady = preTransaction.status == PreTransactionStatus.readyForPayment;

    Color statusColor;
    IconData statusIcon;
    String statusText;
    String statusMessage;

    if (isReady) {
      statusColor = ColorConstants.primaryGreen;
      statusIcon = Icons.check_circle;
      statusText = 'Both Parties Confirmed';
      statusMessage = 'You can now proceed to payment';
    } else if (isWaitingForSeller) {
      statusColor = Colors.amber;
      statusIcon = Icons.hourglass_empty;
      statusText = 'Waiting for Seller';
      statusMessage = 'Seller confirmation in progress... (simulated delay: 5s)';
    } else {
      statusColor = Colors.blue;
      statusIcon = Icons.pending;
      statusText = 'In Progress';
      statusMessage = 'Please complete the confirmation form';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  statusMessage,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationDetails(PreTransaction preTransaction) {
    final buyerConfirmation = preTransaction.buyerConfirmation;
    final sellerConfirmation = preTransaction.sellerConfirmation;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Confirmation Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildConfirmationTile(
              title: 'Buyer Confirmation',
              isConfirmed: buyerConfirmation != null,
              confirmedAt: preTransaction.buyerConfirmedAt,
              details: buyerConfirmation != null
                  ? [
                      'Delivery: ${buyerConfirmation.deliveryDate ?? 'Not specified'}',
                      'Location: ${buyerConfirmation.deliveryLocation ?? 'Not specified'}',
                      'Payment: ${_getPaymentMethodName(buyerConfirmation.preferredPaymentMethod)}',
                    ]
                  : null,
            ),
            const Divider(height: 24),
            _buildConfirmationTile(
              title: 'Seller Confirmation',
              isConfirmed: sellerConfirmation != null,
              confirmedAt: preTransaction.sellerConfirmedAt,
              details: sellerConfirmation != null
                  ? [
                      'Confirmed at: ${DateFormat('MMM d, yyyy h:mm a').format(sellerConfirmation.confirmedAt)}',
                      'Status: Ready for delivery',
                    ]
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationTile({
    required String title,
    required bool isConfirmed,
    DateTime? confirmedAt,
    List<String>? details,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              isConfirmed ? Icons.check_circle : Icons.cancel,
              color: isConfirmed ? ColorConstants.primaryGreen : Colors.grey,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isConfirmed ? Colors.black87 : Colors.grey[600],
              ),
            ),
          ],
        ),
        if (isConfirmed && details != null) ...[
          const SizedBox(height: 8),
          ...details.map((detail) => Padding(
                padding: const EdgeInsets.only(left: 28, top: 4),
                child: Text(
                  detail,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              )),
        ],
      ],
    );
  }

  Widget _buildActionButtons(PreTransactionProvider provider, PreTransaction preTransaction) {
    final isReady = preTransaction.status == PreTransactionStatus.readyForPayment;

    return Column(
      children: [
        if (isReady)
          CustomButton(
            text: 'Proceed to Payment',
            onPressed: () {
              context.pushReplacement(
                '/payment/${widget.auctionId}?carTitle=${Uri.encodeComponent(widget.carTitle)}&winningBid=${widget.winningBid}',
              );
            },
          )
        else
          CustomButton(
            text: 'Back to Discussion',
            onPressed: () {
              context.pop();
            },
          ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () {
            context.go('/home?tab=1&subTab=1'); // Navigate to My Bids > Won tab
          },
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            side: const BorderSide(color: ColorConstants.primaryGreen, width: 2),
          ),
          child: const Text(
            'Back to Home',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  String _getPaymentMethodName(dynamic paymentMethod) {
    if (paymentMethod == null) return 'Not specified';
    return paymentMethod.toString().split('.').last.replaceAll('_', ' ').toUpperCase();
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}

class _StepInfo {
  final String title;
  final bool isCompleted;
  final IconData icon;

  _StepInfo(this.title, this.isCompleted, this.icon);
}
