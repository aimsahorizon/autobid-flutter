import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/ra_8792_pre_transaction_provider.dart';
import 'tabs/chat_tab.dart';
import 'tabs/verification_tab.dart';
import 'tabs/agreement_tab.dart';
import 'tabs/payment_tab.dart';
import 'tabs/handover_tab.dart';
import 'tabs/progress_audit_tab.dart';

/// RA 8792 Compliant Pre-Transaction Screen
/// Legally compliant no-escrow workflow following Philippine Electronic Commerce Act
///
/// Features:
/// - KYC identity verification
/// - Digital sale agreement (legally binding)
/// - Electronic payment confirmation
/// - Vehicle handover documentation
/// - Immutable audit trail
///
/// Usage:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => Ra8792PreTransactionScreen(
///       preTransactionId: 'pt_123',
///       userRole: 'buyer', // or 'seller'
///       userId: 'user_456',
///       userName: 'Juan Dela Cruz',
///     ),
///   ),
/// );
/// ```
class Ra8792PreTransactionScreen extends ConsumerStatefulWidget {
  final String preTransactionId;
  final String userRole; // 'buyer' or 'seller'
  final String userId;
  final String userName;

  const Ra8792PreTransactionScreen({
    Key? key,
    required this.preTransactionId,
    required this.userRole,
    required this.userId,
    required this.userName,
  }) : super(key: key);

  @override
  ConsumerState<Ra8792PreTransactionScreen> createState() =>
      _Ra8792PreTransactionScreenState();
}

class _Ra8792PreTransactionScreenState
    extends ConsumerState<Ra8792PreTransactionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final preTransaction = ref.watch(
      ra8792PreTransactionProvider(widget.preTransactionId),
    );

    final notifier = ref.read(
      ra8792PreTransactionProvider(widget.preTransactionId).notifier,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Workflow'),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            _buildTab(Icons.chat, 'Chat'),
            _buildTab(
              Icons.verified_user,
              'Verify',
              badge: _getVerificationBadge(notifier),
            ),
            _buildTab(
              Icons.description,
              'Agreement',
              badge: _getAgreementBadge(notifier),
            ),
            _buildTab(
              Icons.payment,
              'Payment',
              badge: _getPaymentBadge(notifier),
            ),
            _buildTab(
              Icons.local_shipping,
              'Handover',
              badge: _getHandoverBadge(notifier),
            ),
            _buildTab(Icons.timeline, 'Progress'),
          ],
        ),
      ),
      body: preTransaction == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Status Banner
                _buildStatusBanner(preTransaction.status),
                // Tab Content
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Chat Tab
                      ChatTab(preTransactionId: widget.preTransactionId),

                      // Verification Tab
                      VerificationTab(
                        preTransactionId: widget.preTransactionId,
                        userRole: widget.userRole,
                        userId: widget.userId,
                        userName: widget.userName,
                      ),

                      // Agreement Tab
                      AgreementTab(
                        preTransactionId: widget.preTransactionId,
                        userRole: widget.userRole,
                        userId: widget.userId,
                      ),

                      // Payment Tab
                      PaymentTab(
                        preTransactionId: widget.preTransactionId,
                        userRole: widget.userRole,
                      ),

                      // Handover Tab
                      HandoverTab(
                        preTransactionId: widget.preTransactionId,
                        userRole: widget.userRole,
                      ),

                      // Progress & Audit Tab
                      ProgressAuditTab(
                        preTransactionId: widget.preTransactionId,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTab(IconData icon, String label, {Widget? badge}) {
    return Tab(
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(label),
          if (badge != null) ...[
            const SizedBox(width: 4),
            badge,
          ],
        ],
      ),
    );
  }

  Widget? _getVerificationBadge(Ra8792PreTransactionNotifier notifier) {
    if (notifier.isBothVerified) {
      return _buildBadge(Colors.green, Icons.check);
    } else if (widget.userRole == 'buyer' && notifier.isBuyerVerified) {
      return _buildBadge(Colors.orange, Icons.pending);
    } else if (widget.userRole == 'seller' && notifier.isSellerVerified) {
      return _buildBadge(Colors.orange, Icons.pending);
    }
    return null;
  }

  Widget? _getAgreementBadge(Ra8792PreTransactionNotifier notifier) {
    if (notifier.isBothSigned) {
      return _buildBadge(Colors.green, Icons.check);
    } else if (notifier.isAgreementGenerated) {
      return _buildBadge(Colors.orange, Icons.pending);
    }
    return null;
  }

  Widget? _getPaymentBadge(Ra8792PreTransactionNotifier notifier) {
    if (notifier.isPaymentConfirmed) {
      return _buildBadge(Colors.green, Icons.check);
    } else if (notifier.isPaymentInitiated) {
      return _buildBadge(Colors.orange, Icons.pending);
    }
    return null;
  }

  Widget? _getHandoverBadge(Ra8792PreTransactionNotifier notifier) {
    if (notifier.isVehicleReceived) {
      return _buildBadge(Colors.green, Icons.check);
    } else if (notifier.isVehicleReleased) {
      return _buildBadge(Colors.orange, Icons.pending);
    }
    return null;
  }

  Widget _buildBadge(Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 12, color: Colors.white),
    );
  }

  Widget _buildStatusBanner(dynamic status) {
    final statusInfo = _getStatusInfo(status.toString());

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: statusInfo.color.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(color: statusInfo.color.withOpacity(0.3)),
        ),
      ),
      child: Row(
        children: [
          Icon(statusInfo.icon, color: statusInfo.color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusInfo.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: statusInfo.color,
                    fontSize: 14,
                  ),
                ),
                if (statusInfo.subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    statusInfo.subtitle!,
                    style: TextStyle(
                      fontSize: 12,
                      color: statusInfo.color.withOpacity(0.8),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  _StatusInfo _getStatusInfo(String status) {
    if (status.contains('pendingVerification')) {
      return _StatusInfo(
        title: 'Verification Required',
        subtitle: 'Both parties must verify their identities',
        color: Colors.orange,
        icon: Icons.pending,
      );
    } else if (status.contains('verificationComplete')) {
      return _StatusInfo(
        title: 'Verification Complete',
        subtitle: 'Ready to generate agreement',
        color: const Color(0xFF4CAF50),
        icon: Icons.check_circle,
      );
    } else if (status.contains('agreementDraft')) {
      return _StatusInfo(
        title: 'Agreement Generated',
        subtitle: 'Waiting for signatures',
        color: Colors.orange,
        icon: Icons.pending,
      );
    } else if (status.contains('agreementSigned')) {
      return _StatusInfo(
        title: 'Agreement Signed',
        subtitle: 'Ready for payment',
        color: const Color(0xFF4CAF50),
        icon: Icons.check_circle,
      );
    } else if (status.contains('paymentPending')) {
      return _StatusInfo(
        title: 'Payment Initiated',
        subtitle: 'Waiting for seller confirmation',
        color: Colors.orange,
        icon: Icons.pending,
      );
    } else if (status.contains('paymentConfirmed')) {
      return _StatusInfo(
        title: 'Payment Confirmed',
        subtitle: 'Ready for handover',
        color: const Color(0xFF4CAF50),
        icon: Icons.check_circle,
      );
    } else if (status.contains('handoverPending')) {
      return _StatusInfo(
        title: 'Vehicle Released',
        subtitle: 'Waiting for buyer confirmation',
        color: Colors.orange,
        icon: Icons.pending,
      );
    } else if (status.contains('transactionCompleted')) {
      return _StatusInfo(
        title: 'Transaction Completed',
        subtitle: 'All steps successfully completed',
        color: const Color(0xFF4CAF50),
        icon: Icons.check_circle,
      );
    }

    return _StatusInfo(
      title: 'In Progress',
      subtitle: null,
      color: Colors.blue,
      icon: Icons.info,
    );
  }
}

class _StatusInfo {
  final String title;
  final String? subtitle;
  final Color color;
  final IconData icon;

  _StatusInfo({
    required this.title,
    this.subtitle,
    required this.color,
    required this.icon,
  });
}
