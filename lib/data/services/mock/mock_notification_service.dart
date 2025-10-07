import 'dart:async';
import '../../../data/models/auction_model.dart';
// import '../../../data/models/bid_model.dart';

enum NotificationType {
  outbid,
  auctionEndingSoon,
  auctionWon,
  auctionLost,
}

class AuctionNotification {
  final String id;
  final NotificationType type;
  final String title;
  final String message;
  final String auctionId;
  final DateTime timestamp;
  final bool isRead;

  AuctionNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.auctionId,
    required this.timestamp,
    this.isRead = false,
  });

  AuctionNotification copyWith({bool? isRead}) {
    return AuctionNotification(
      id: id,
      type: type,
      title: title,
      message: message,
      auctionId: auctionId,
      timestamp: timestamp,
      isRead: isRead ?? this.isRead,
    );
  }
}

class MockNotificationService {
  static final MockNotificationService _instance = MockNotificationService._internal();
  factory MockNotificationService() => _instance;
  MockNotificationService._internal();

  final List<AuctionNotification> _notifications = [];
  final _notificationStreamController = StreamController<List<AuctionNotification>>.broadcast();

  Stream<List<AuctionNotification>> get notificationsStream => _notificationStreamController.stream;

  List<AuctionNotification> getNotifications() {
    return List.from(_notifications)..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  int getUnreadCount() {
    return _notifications.where((n) => !n.isRead).length;
  }

  void addOutbidNotification(Auction auction, String carName) {
    final notification = AuctionNotification(
      id: 'notif_${_notifications.length}',
      type: NotificationType.outbid,
      title: 'You\'ve been outbid!',
      message: 'Someone placed a higher bid on $carName',
      auctionId: auction.id,
      timestamp: DateTime.now(),
    );

    _notifications.add(notification);
    _notifyListeners();
  }

  void addAuctionEndingSoonNotification(Auction auction, String carName) {
    final notification = AuctionNotification(
      id: 'notif_${_notifications.length}',
      type: NotificationType.auctionEndingSoon,
      title: 'Auction ending soon!',
      message: '$carName auction ends in less than 1 hour',
      auctionId: auction.id,
      timestamp: DateTime.now(),
    );

    _notifications.add(notification);
    _notifyListeners();
  }

  void addAuctionWonNotification(Auction auction, String carName) {
    final notification = AuctionNotification(
      id: 'notif_${_notifications.length}',
      type: NotificationType.auctionWon,
      title: 'Congratulations! 🎉',
      message: 'You won the auction for $carName!',
      auctionId: auction.id,
      timestamp: DateTime.now(),
    );

    _notifications.add(notification);
    _notifyListeners();
  }

  void addAuctionLostNotification(Auction auction, String carName) {
    final notification = AuctionNotification(
      id: 'notif_${_notifications.length}',
      type: NotificationType.auctionLost,
      title: 'Auction ended',
      message: 'The auction for $carName has ended',
      auctionId: auction.id,
      timestamp: DateTime.now(),
    );

    _notifications.add(notification);
    _notifyListeners();
  }

  void markAsRead(String notificationId) {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      _notifyListeners();
    }
  }

  void markAllAsRead() {
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
    _notifyListeners();
  }

  void clearNotification(String notificationId) {
    _notifications.removeWhere((n) => n.id == notificationId);
    _notifyListeners();
  }

  void clearAll() {
    _notifications.clear();
    _notifyListeners();
  }

  void _notifyListeners() {
    _notificationStreamController.add(getNotifications());
  }

  void dispose() {
    _notificationStreamController.close();
  }
}
