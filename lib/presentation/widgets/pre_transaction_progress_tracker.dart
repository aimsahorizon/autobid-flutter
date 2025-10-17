import 'package:flutter/material.dart';
import '../../data/models/pre_transaction_model.dart';
import '../../core/constants/color_constants.dart';

/// Progress tracker widget for pre-transaction flow (TRANSACTION_FLOW.md compliant)
/// Shows visual progress from Discussion → Admin Approval → Payment Ready
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
    return [
      {'label': 'Discussion'},
      {'label': isSeller ? 'Your Form' : 'Buyer Form'},
      {'label': isSeller ? 'Buyer Form' : 'Seller Form'},
      {'label': 'Combined Review'},
      {'label': 'Admin Review'},
      {'label': 'Payment Ready'},
    ];
  }

  int _getCurrentStepIndex() {
    switch (currentStatus) {
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
        return 'Combined Review Required';
      case PreTransactionStatus.pendingAdminReview:
        return 'Under Admin Review';
      case PreTransactionStatus.adminApproved:
        return 'Admin Approved!';
      case PreTransactionStatus.readyForPayment:
        return isSeller ? 'Awaiting Buyer Payment' : 'Ready for Payment';
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
        return 'Both parties must review and approve the combined details before proceeding to admin review';
      case PreTransactionStatus.pendingAdminReview:
        return 'Admin is reviewing both submitted forms. This usually takes 1-2 hours.';
      case PreTransactionStatus.adminApproved:
        return 'Transaction approved! ${isSeller ? 'Waiting for buyer to proceed to payment' : 'You can now proceed to payment'}';
      case PreTransactionStatus.readyForPayment:
        return isSeller
            ? 'Buyer payment secured in escrow. Prepare shipping evidence within agreed timeframe.'
            : 'Payment secured. Seller will ship within agreed timeframe.';
      default:
        return 'Transaction in progress';
    }
  }
}
