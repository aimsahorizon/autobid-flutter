import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/notification_model.dart';
import '../../data/services/mock/mock_notification_service.dart';

part 'notification_provider.g.dart';

@riverpod
class NotificationList extends _$NotificationList {
  final _service = MockNotificationService();

  @override
  Future<List<NotificationModel>> build() async {
    await _service.initialize();
    return await _service.getNotifications();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _service.getNotifications());
  }

  Future<void> markAsRead(String notificationId) async {
    await _service.markAsRead(notificationId);
    await refresh();
  }

  Future<void> markAllAsRead() async {
    await _service.markAllAsRead();
    await refresh();
  }

  Future<void> deleteNotification(String notificationId) async {
    await _service.deleteNotification(notificationId);
    await refresh();
  }

  Future<void> clearAll() async {
    await _service.clearAll();
    await refresh();
  }
}

@riverpod
Future<int> unreadNotificationCount(Ref ref) async {
  final service = MockNotificationService();
  await service.initialize();
  return await service.getUnreadCount();
}
