import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../data/models/notification_model.dart';
import '../../providers/notification_provider.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        actions: [
          notificationsAsync.when(
            data: (notifications) {
              final hasNotifications = notifications.isNotEmpty;
              return PopupMenuButton<String>(
                enabled: hasNotifications,
                onSelected: (value) async {
                  if (value == 'mark_all_read') {
                    await ref.read(notificationListProvider.notifier).markAllAsRead();
                    ref.invalidate(unreadNotificationCountProvider);
                  } else if (value == 'clear_all') {
                    await ref.read(notificationListProvider.notifier).clearAll();
                    ref.invalidate(unreadNotificationCountProvider);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'mark_all_read',
                    child: Text('Mark all as read'),
                  ),
                  const PopupMenuItem(
                    value: 'clear_all',
                    child: Text('Clear all'),
                  ),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: notificationsAsync.when(
        data: (notifications) {
          if (notifications.isEmpty) {
            return _buildEmptyState();
          }
          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(notificationListProvider.notifier).refresh();
              ref.invalidate(unreadNotificationCountProvider);
            },
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _NotificationItem(
                  notification: notification,
                  onTap: () async {
                    if (!notification.isRead) {
                      await ref.read(notificationListProvider.notifier).markAsRead(notification.id);
                      ref.invalidate(unreadNotificationCountProvider);
                    }
                    if (context.mounted) {
                      _navigateToNotification(context, notification);
                    }
                  },
                  onDismiss: () async {
                    await ref.read(notificationListProvider.notifier).deleteNotification(notification.id);
                    ref.invalidate(unreadNotificationCountProvider);
                  },
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error loading notifications: $error'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => ref.invalidate(notificationListProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No notifications',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'You\'re all caught up!',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  void _navigateToNotification(BuildContext context, NotificationModel notification) {
    switch (notification.type) {
      case NotificationType.outbid:
      case NotificationType.winning:
      case NotificationType.endingSoon:
      case NotificationType.lost:
        if (notification.auctionId != null) {
          context.push('/auction/${notification.auctionId}');
        }
        break;
      case NotificationType.won:
        if (notification.auctionId != null) {
          context.push('/auction/${notification.auctionId}');
        }
        break;
      case NotificationType.paymentReceived:
      case NotificationType.escrowHeld:
      case NotificationType.escrowReleased:
      case NotificationType.refundProcessed:
      case NotificationType.disputeOpened:
      case NotificationType.validationComplete:
      case NotificationType.shipped:
        if (notification.transactionId != null) {
          context.push('/transaction/${notification.transactionId}');
        }
        break;
    }
  }
}

class _NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const _NotificationItem({
    required this.notification,
    required this.onTap,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: notification.isRead ? null : colorScheme.primary.withValues(alpha: 0.05),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getNotificationColor().withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getNotificationIcon(),
                  color: _getNotificationColor(),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.message,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatTimestamp(notification.timestamp),
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Arrow
              Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getNotificationIcon() {
    switch (notification.type) {
      case NotificationType.outbid:
        return Icons.trending_down;
      case NotificationType.winning:
        return Icons.trending_up;
      case NotificationType.won:
        return Icons.emoji_events;
      case NotificationType.lost:
        return Icons.cancel_outlined;
      case NotificationType.endingSoon:
        return Icons.access_time;
      case NotificationType.paymentReceived:
        return Icons.payment;
      case NotificationType.escrowHeld:
        return Icons.lock;
      case NotificationType.escrowReleased:
        return Icons.account_balance;
      case NotificationType.refundProcessed:
        return Icons.money_off;
      case NotificationType.disputeOpened:
        return Icons.report_problem;
      case NotificationType.validationComplete:
        return Icons.verified;
      case NotificationType.shipped:
        return Icons.local_shipping;
    }
  }

  Color _getNotificationColor() {
    switch (notification.type) {
      case NotificationType.outbid:
      case NotificationType.lost:
      case NotificationType.disputeOpened:
        return Colors.red;
      case NotificationType.winning:
      case NotificationType.won:
      case NotificationType.escrowReleased:
      case NotificationType.validationComplete:
        return Colors.green;
      case NotificationType.endingSoon:
        return Colors.orange;
      case NotificationType.paymentReceived:
      case NotificationType.escrowHeld:
      case NotificationType.shipped:
        return Colors.blue;
      case NotificationType.refundProcessed:
        return Colors.grey;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d, yyyy').format(timestamp);
    }
  }
}
