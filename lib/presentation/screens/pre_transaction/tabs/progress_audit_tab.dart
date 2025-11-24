import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/pre_transaction_model.dart';
import '../../../../data/models/audit_log_entry_model.dart';
import '../../../providers/ra_8792_pre_transaction_provider.dart';

/// Progress & Audit Log Tab
/// Shows transaction progress and immutable audit trail
class ProgressAuditTab extends ConsumerWidget {
  final String preTransactionId;

  const ProgressAuditTab({
    Key? key,
    required this.preTransactionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preTransaction = ref.watch(
      ra8792PreTransactionProvider(preTransactionId),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Progress & Audit Log',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Track transaction progress and view protected audit trail',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 24),

          // Progress Tracker
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transaction Progress',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _buildProgressTracker(context, preTransaction),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Audit Log
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Audit Log',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.shield, size: 16, color: Colors.green[700]),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Protected under RA 8792 Sections 6-13',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (preTransaction?.auditLog.isEmpty ?? true)
                    const Text(
                      'No audit entries yet',
                      style: TextStyle(color: Colors.grey),
                    )
                  else
                    _buildAuditLog(preTransaction!.auditLog),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTracker(BuildContext context, PreTransaction? preTransaction) {
    if (preTransaction == null) {
      return const Text('Loading...');
    }

    final steps = _getProgressSteps(preTransaction);

    return Column(
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        final isLast = index == steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step indicator
            Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: step.isCompleted
                        ? const Color(0xFF4CAF50)
                        : step.isCurrent
                            ? Colors.orange
                            : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    step.isCompleted
                        ? Icons.check
                        : step.isCurrent
                            ? Icons.circle
                            : Icons.circle_outlined,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 40,
                    color: step.isCompleted ? const Color(0xFF4CAF50) : Colors.grey.shade300,
                  ),
              ],
            ),
            const SizedBox(width: 12),
            // Step content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.title,
                      style: TextStyle(
                        fontWeight: step.isCurrent ? FontWeight.bold : FontWeight.normal,
                        color: step.isCompleted
                            ? const Color(0xFF4CAF50)
                            : step.isCurrent
                                ? Colors.orange
                                : Colors.grey,
                      ),
                    ),
                    if (step.subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        step.subtitle!,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildAuditLog(List<AuditLogEntry> entries) {
    // Reverse to show newest first
    final reversedEntries = entries.reversed.toList();

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reversedEntries.length,
      separatorBuilder: (context, index) => const Divider(height: 24),
      itemBuilder: (context, index) {
        final entry = reversedEntries[index];
        return _buildAuditEntry(entry);
      },
    );
  }

  Widget _buildAuditEntry(AuditLogEntry entry) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon based on actor
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: _getActorColor(entry.actor).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getActorIcon(entry.actor),
            size: 16,
            color: _getActorColor(entry.actor),
          ),
        ),
        const SizedBox(width: 12),
        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.action,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'By: ${entry.actorName}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              if (entry.details != null) ...[
                const SizedBox(height: 4),
                Text(
                  entry.details!,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
              const SizedBox(height: 4),
              Text(
                _formatDateTime(entry.timestamp),
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<_ProgressStep> _getProgressSteps(PreTransaction preTransaction) {
    final status = preTransaction.status;

    return [
      _ProgressStep(
        title: 'Verification',
        subtitle: 'Identity verification for both parties',
        isCompleted: _isStatusAfter(status, PreTransactionStatus.pendingVerification),
        isCurrent: status == PreTransactionStatus.pendingVerification,
      ),
      _ProgressStep(
        title: 'Agreement',
        subtitle: 'Digital sale agreement generation and signing',
        isCompleted: _isStatusAfter(status, PreTransactionStatus.agreementDraft),
        isCurrent: status == PreTransactionStatus.verificationComplete ||
            status == PreTransactionStatus.agreementDraft,
      ),
      _ProgressStep(
        title: 'Payment',
        subtitle: 'Payment initiation and confirmation',
        isCompleted: _isStatusAfter(status, PreTransactionStatus.paymentPending),
        isCurrent: status == PreTransactionStatus.agreementSigned ||
            status == PreTransactionStatus.paymentPending,
      ),
      _ProgressStep(
        title: 'Handover',
        subtitle: 'Vehicle release and receipt',
        isCompleted: _isStatusAfter(status, PreTransactionStatus.handoverPending),
        isCurrent: status == PreTransactionStatus.paymentConfirmed ||
            status == PreTransactionStatus.handoverPending,
      ),
      _ProgressStep(
        title: 'Completed',
        subtitle: 'Transaction successfully completed',
        isCompleted: status == PreTransactionStatus.transactionCompleted,
        isCurrent: status == PreTransactionStatus.handoverComplete,
      ),
    ];
  }

  bool _isStatusAfter(PreTransactionStatus current, PreTransactionStatus target) {
    final order = [
      PreTransactionStatus.pendingVerification,
      PreTransactionStatus.verificationComplete,
      PreTransactionStatus.agreementDraft,
      PreTransactionStatus.agreementSigned,
      PreTransactionStatus.paymentPending,
      PreTransactionStatus.paymentConfirmed,
      PreTransactionStatus.handoverPending,
      PreTransactionStatus.handoverComplete,
      PreTransactionStatus.transactionCompleted,
    ];

    final currentIndex = order.indexOf(current);
    final targetIndex = order.indexOf(target);

    return currentIndex > targetIndex;
  }

  Color _getActorColor(String actor) {
    switch (actor) {
      case 'buyer':
        return Colors.blue;
      case 'seller':
        return Colors.orange;
      case 'system':
        return const Color(0xFF4CAF50);
      default:
        return Colors.grey;
    }
  }

  IconData _getActorIcon(String actor) {
    switch (actor) {
      case 'buyer':
        return Icons.shopping_cart;
      case 'seller':
        return Icons.store;
      case 'system':
        return Icons.settings;
      default:
        return Icons.person;
    }
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.month}/${dt.day}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

class _ProgressStep {
  final String title;
  final String? subtitle;
  final bool isCompleted;
  final bool isCurrent;

  _ProgressStep({
    required this.title,
    this.subtitle,
    required this.isCompleted,
    required this.isCurrent,
  });
}
