import 'package:flutter/material.dart';
import '../../data/models/pre_transaction_model.dart';
import '../../core/constants/color_constants.dart';

/// Progress tracker widget for pre-transaction flow (TRANSACTION_FLOW.md compliant)
/// Shows visual progress: Discussion → Buyer Form → Seller Form → Buyer/Seller Confirmation → Admin Review → Payment Ready
class PreTransactionProgressTracker extends StatelessWidget {
  final PreTransactionStatus currentStatus;
  final bool isSeller;

  const PreTransactionProgressTracker({
    super.key,
    required this.currentStatus,
    this.isSeller = false,
  });

  @override
  Widget build(BuildContext context) {
    final steps = _getProgressSteps();
    final currentStepIndex = _getCurrentStepIndex();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Progress',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: List.generate(steps.length, (index) {
              final step = steps[index];
              final isCompleted = index < currentStepIndex;
              final isCurrent = index == currentStepIndex;
              final isLast = index == steps.length - 1;

              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          // Circle indicator
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isCompleted || isCurrent
                                  ? ColorConstants.primaryGreen
                                  : Colors.grey[300],
                              border: Border.all(
                                color: isCurrent
                                    ? ColorConstants.primaryGreen
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: isCompleted
                                  ? const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.white,
                                    )
                                  : Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: isCurrent
                                            ? Colors.white
                                            : Colors.grey[600],
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Step label
                          Text(
                            step['label']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
                              color: isCurrent
                                  ? ColorConstants.primaryGreen
                                  : Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // Connecting line
                    if (!isLast)
                      Container(
                        width: 20,
                        height: 2,
                        color: isCompleted
                            ? ColorConstants.primaryGreen
                            : Colors.grey[300],
                      ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          // Current status description
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getStatusColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _getStatusColor().withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _getStatusIcon(),
                  size: 20,
                  color: _getStatusColor(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getStatusTitle(),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getStatusDescription(),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getProgressSteps() {
    // Check if we're in the new checkpoint flow (after admin approval)
    final isInCheckpointFlow = currentStatus == PreTransactionStatus.preparing ||
        currentStatus == PreTransactionStatus.shipping ||
        currentStatus == PreTransactionStatus.delivered ||
        currentStatus == PreTransactionStatus.paymentSuccess ||
        currentStatus == PreTransactionStatus.transactionComplete;

    if (isInCheckpointFlow) {
      // New checkpoint flow (no escrow)
      return [
        {'label': 'Preparing'},
        {'label': 'Shipping'},
        {'label': 'Delivered'},
        {'label': 'Payment Success'},
        {'label': 'Complete'},
      ];
    }

    // Original pre-transaction flow
    return [
      {'label': 'Discussion'},
      {'label': 'Buyer Form'},
      {'label': 'Seller Form'},
      {'label': isSeller ? 'Buyer Confirmation' : 'Seller Confirmation'},
      {'label': 'Admin Review'},
      {'label': 'Transaction Start'},
    ];
  }

  int _getCurrentStepIndex() {
    switch (currentStatus) {
      // Checkpoint flow
      case PreTransactionStatus.preparing:
        return 0;
      case PreTransactionStatus.shipping:
        return 1;
      case PreTransactionStatus.delivered:
        return 2;
      case PreTransactionStatus.paymentSuccess:
        return 3;
      case PreTransactionStatus.transactionComplete:
        return 4;

      // Pre-transaction flow
      case PreTransactionStatus.inDiscussion:
        return 0;
      case PreTransactionStatus.pendingBuyerConfirmation:
        return 1;
      case PreTransactionStatus.pendingSellerConfirmation:
        return 2;
      case PreTransactionStatus.pendingMutualConfirmation:
        return 3;
      case PreTransactionStatus.pendingAdminReview:
        return 4;
      case PreTransactionStatus.adminApproved:
      case PreTransactionStatus.readyForPayment:
        return 5;
      default:
        return 0;
    }
  }

  Color _getStatusColor() {
    switch (currentStatus) {
      case PreTransactionStatus.inDiscussion:
        return Colors.orange[700]!;
      case PreTransactionStatus.pendingBuyerConfirmation:
      case PreTransactionStatus.pendingSellerConfirmation:
        return Colors.red[700]!;
      case PreTransactionStatus.pendingMutualConfirmation:
        return Colors.teal[700]!;
      case PreTransactionStatus.pendingAdminReview:
        return Colors.purple[700]!;
      case PreTransactionStatus.adminApproved:
      case PreTransactionStatus.readyForPayment:
        return Colors.blue[700]!;
      // Checkpoint flow colors
      case PreTransactionStatus.preparing:
        return Colors.orange[700]!;
      case PreTransactionStatus.shipping:
        return Colors.blue[700]!;
      case PreTransactionStatus.delivered:
        return Colors.purple[700]!;
      case PreTransactionStatus.paymentSuccess:
        return ColorConstants.primaryGreen;
      case PreTransactionStatus.transactionComplete:
        return ColorConstants.primaryGreen;
      default:
        return Colors.grey[700]!;
    }
  }

  IconData _getStatusIcon() {
    switch (currentStatus) {
      case PreTransactionStatus.inDiscussion:
        return Icons.chat_bubble_outline;
      case PreTransactionStatus.pendingBuyerConfirmation:
      case PreTransactionStatus.pendingSellerConfirmation:
        return Icons.assignment_late;
      case PreTransactionStatus.pendingMutualConfirmation:
        return Icons.verified_user;
      case PreTransactionStatus.pendingAdminReview:
        return Icons.admin_panel_settings;
      case PreTransactionStatus.adminApproved:
      case PreTransactionStatus.readyForPayment:
        return Icons.payment;
      // Checkpoint flow icons
      case PreTransactionStatus.preparing:
        return Icons.inventory_2_outlined;
      case PreTransactionStatus.shipping:
        return Icons.local_shipping_outlined;
      case PreTransactionStatus.delivered:
        return Icons.check_circle_outline;
      case PreTransactionStatus.paymentSuccess:
        return Icons.payments;
      case PreTransactionStatus.transactionComplete:
        return Icons.done_all;
      default:
        return Icons.info_outline;
    }
  }

  String _getStatusTitle() {
    switch (currentStatus) {
      case PreTransactionStatus.inDiscussion:
        return 'Discussing Terms';
      case PreTransactionStatus.pendingBuyerConfirmation:
        return isSeller ? 'Awaiting Buyer Confirmation' : 'Action Required: Submit Your Form';
      case PreTransactionStatus.pendingSellerConfirmation:
        return isSeller ? 'Action Required: Submit Your Form' : 'Awaiting Seller Confirmation';
      case PreTransactionStatus.pendingMutualConfirmation:
        return isSeller ? 'Buyer Confirmation Required' : 'Seller Confirmation Required';
      case PreTransactionStatus.pendingAdminReview:
        return 'Under Admin Review';
      case PreTransactionStatus.adminApproved:
        return 'Admin Approved!';
      case PreTransactionStatus.readyForPayment:
        return isSeller ? 'Awaiting Buyer Payment' : 'Ready for Payment';
      // Checkpoint flow titles
      case PreTransactionStatus.preparing:
        return isSeller ? 'Preparing Item for Shipment' : 'Seller is Preparing';
      case PreTransactionStatus.shipping:
        return isSeller ? 'Item is Being Shipped' : 'Item is Being Shipped';
      case PreTransactionStatus.delivered:
        return isSeller ? 'Item Delivered' : 'Item Delivered';
      case PreTransactionStatus.paymentSuccess:
        return 'Payment Completed!';
      case PreTransactionStatus.transactionComplete:
        return 'Transaction Complete!';
      default:
        return 'In Progress';
    }
  }

  String _getStatusDescription() {
    switch (currentStatus) {
      case PreTransactionStatus.inDiscussion:
        return 'Discuss delivery details, inspection, and terms with ${isSeller ? 'buyer' : 'seller'}';
      case PreTransactionStatus.pendingBuyerConfirmation:
        return isSeller
            ? 'Waiting for buyer to fill out and submit their confirmation form'
            : 'Fill out all required fields and submit your confirmation form';
      case PreTransactionStatus.pendingSellerConfirmation:
        return isSeller
            ? 'Fill out all required fields (vehicle details, ownership docs, shipping) and submit'
            : 'Waiting for seller to fill out and submit their confirmation form';
      case PreTransactionStatus.pendingMutualConfirmation:
        return isSeller
            ? 'Waiting for the buyer to confirm your form before proceeding to admin review'
            : 'Waiting for the seller to confirm your form before proceeding to admin review';
      case PreTransactionStatus.pendingAdminReview:
        return 'Admin is reviewing both submitted forms. This usually takes 1-2 hours.';
      case PreTransactionStatus.adminApproved:
        return 'Transaction approved! ${isSeller ? 'Waiting for buyer to proceed to payment' : 'You can now proceed to payment'}';
      case PreTransactionStatus.readyForPayment:
        return isSeller
            ? 'Buyer payment secured in escrow. Prepare shipping evidence within agreed timeframe.'
            : 'Payment secured. Seller will ship within agreed timeframe.';
      // Checkpoint flow descriptions
      case PreTransactionStatus.preparing:
        return isSeller
            ? 'Prepare the item for shipment. Update status when ready to ship.'
            : 'Seller is preparing your item for shipment. You will be notified when shipped.';
      case PreTransactionStatus.shipping:
        return isSeller
            ? 'Item is in transit. Update status when delivered.'
            : 'Your item is on its way! Track your shipment and wait for delivery.';
      case PreTransactionStatus.delivered:
        return isSeller
            ? 'Item delivered. Awaiting buyer payment confirmation.'
            : 'Item delivered! Confirm receipt and proceed to payment.';
      case PreTransactionStatus.paymentSuccess:
        return isSeller
            ? 'Payment received! Transaction complete. Please rate the buyer.'
            : 'Payment successful! Transaction complete. Please rate the seller.';
      case PreTransactionStatus.transactionComplete:
        return 'Transaction successfully completed. Thank you for using AutoBID!';
      default:
        return 'Transaction in progress';
    }
  }
}
