import '../../models/notification_model.dart';

class MockNotificationService {
  static final MockNotificationService _instance = MockNotificationService._internal();
  factory MockNotificationService() => _instance;
  MockNotificationService._internal();

  final List<NotificationModel> _notifications = [];

  Future<void> initialize() async {
    if (_notifications.isEmpty) {
      _notifications.addAll(_generateMockNotifications());
    }
  }

  Future<List<NotificationModel>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_notifications)..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  Future<List<NotificationModel>> getUnreadNotifications() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _notifications.where((n) => !n.isRead).toList();
  }

  Future<int> getUnreadCount() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _notifications.where((n) => !n.isRead).length;
  }

  Future<void> markAsRead(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
    }
  }

  Future<void> markAllAsRead() async {
    await Future.delayed(const Duration(milliseconds: 300));
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _notifications.removeWhere((n) => n.id == notificationId);
  }

  Future<void> clearAll() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _notifications.clear();
  }

  // Generate notification for specific events
  Future<void> createNotification(NotificationModel notification) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _notifications.insert(0, notification);
  }

  // Helper methods to create specific notification types
  Future<void> notifyOutbid({
    required String auctionId,
    required String carTitle,
    required double currentBid,
  }) async {
    await createNotification(NotificationModel(
      id: 'NOTIF${DateTime.now().millisecondsSinceEpoch}',
      type: NotificationType.outbid,
      title: 'You\'ve been outbid!',
      message: 'Someone placed a higher bid on $carTitle',
      timestamp: DateTime.now(),
      auctionId: auctionId,
      carTitle: carTitle,
      amount: currentBid,
    ));
  }

  Future<void> notifyWinning({
    required String auctionId,
    required String carTitle,
    required double yourBid,
  }) async {
    await createNotification(NotificationModel(
      id: 'NOTIF${DateTime.now().millisecondsSinceEpoch}',
      type: NotificationType.winning,
      title: 'You\'re winning!',
      message: 'Your bid on $carTitle is currently the highest',
      timestamp: DateTime.now(),
      auctionId: auctionId,
      carTitle: carTitle,
      amount: yourBid,
    ));
  }

  Future<void> notifyWon({
    required String auctionId,
    required String carTitle,
    required double winningBid,
  }) async {
    await createNotification(NotificationModel(
      id: 'NOTIF${DateTime.now().millisecondsSinceEpoch}',
      type: NotificationType.won,
      title: 'Congratulations! You won!',
      message: 'You won the auction for $carTitle at ₱${winningBid.toStringAsFixed(0)}',
      timestamp: DateTime.now(),
      auctionId: auctionId,
      carTitle: carTitle,
      amount: winningBid,
    ));
  }

  Future<void> notifyLost({
    required String auctionId,
    required String carTitle,
  }) async {
    await createNotification(NotificationModel(
      id: 'NOTIF${DateTime.now().millisecondsSinceEpoch}',
      type: NotificationType.lost,
      title: 'Auction ended',
      message: 'The auction for $carTitle has ended. Better luck next time!',
      timestamp: DateTime.now(),
      auctionId: auctionId,
      carTitle: carTitle,
    ));
  }

  Future<void> notifyEndingSoon({
    required String auctionId,
    required String carTitle,
    required Duration timeLeft,
  }) async {
    final minutes = timeLeft.inMinutes;
    await createNotification(NotificationModel(
      id: 'NOTIF${DateTime.now().millisecondsSinceEpoch}',
      type: NotificationType.endingSoon,
      title: 'Auction ending soon!',
      message: '$carTitle auction ends in $minutes minutes',
      timestamp: DateTime.now(),
      auctionId: auctionId,
      carTitle: carTitle,
    ));
  }

  Future<void> notifyPaymentReceived({
    required String transactionId,
    required String carTitle,
    required double amount,
  }) async {
    await createNotification(NotificationModel(
      id: 'NOTIF${DateTime.now().millisecondsSinceEpoch}',
      type: NotificationType.paymentReceived,
      title: 'Payment received',
      message: 'Payment for $carTitle has been received',
      timestamp: DateTime.now(),
      transactionId: transactionId,
      carTitle: carTitle,
      amount: amount,
    ));
  }

  Future<void> notifyEscrowHeld({
    required String transactionId,
    required String carTitle,
    required double amount,
  }) async {
    await createNotification(NotificationModel(
      id: 'NOTIF${DateTime.now().millisecondsSinceEpoch}',
      type: NotificationType.escrowHeld,
      title: 'Payment secured in escrow',
      message: '₱${amount.toStringAsFixed(0)} for $carTitle is now held in escrow',
      timestamp: DateTime.now(),
      transactionId: transactionId,
      carTitle: carTitle,
      amount: amount,
    ));
  }

  Future<void> notifyEscrowReleased({
    required String transactionId,
    required String carTitle,
    required double amount,
  }) async {
    await createNotification(NotificationModel(
      id: 'NOTIF${DateTime.now().millisecondsSinceEpoch}',
      type: NotificationType.escrowReleased,
      title: 'Payment released',
      message: '₱${amount.toStringAsFixed(0)} has been released to the seller',
      timestamp: DateTime.now(),
      transactionId: transactionId,
      carTitle: carTitle,
      amount: amount,
    ));
  }

  Future<void> notifyRefundProcessed({
    required String transactionId,
    required String carTitle,
    required double amount,
  }) async {
    await createNotification(NotificationModel(
      id: 'NOTIF${DateTime.now().millisecondsSinceEpoch}',
      type: NotificationType.refundProcessed,
      title: 'Refund processed',
      message: '₱${amount.toStringAsFixed(0)} refund for $carTitle has been processed',
      timestamp: DateTime.now(),
      transactionId: transactionId,
      carTitle: carTitle,
      amount: amount,
    ));
  }

  Future<void> notifyDisputeOpened({
    required String transactionId,
    required String carTitle,
  }) async {
    await createNotification(NotificationModel(
      id: 'NOTIF${DateTime.now().millisecondsSinceEpoch}',
      type: NotificationType.disputeOpened,
      title: 'Dispute opened',
      message: 'A dispute has been opened for $carTitle',
      timestamp: DateTime.now(),
      transactionId: transactionId,
      carTitle: carTitle,
    ));
  }

  Future<void> notifyValidationComplete({
    required String transactionId,
    required String carTitle,
  }) async {
    await createNotification(NotificationModel(
      id: 'NOTIF${DateTime.now().millisecondsSinceEpoch}',
      type: NotificationType.validationComplete,
      title: 'Transfer validated',
      message: 'Transfer evidence for $carTitle has been validated',
      timestamp: DateTime.now(),
      transactionId: transactionId,
      carTitle: carTitle,
    ));
  }

  Future<void> notifyShipped({
    required String transactionId,
    required String carTitle,
  }) async {
    await createNotification(NotificationModel(
      id: 'NOTIF${DateTime.now().millisecondsSinceEpoch}',
      type: NotificationType.shipped,
      title: 'Vehicle shipped',
      message: '$carTitle has been marked as shipped',
      timestamp: DateTime.now(),
      transactionId: transactionId,
      carTitle: carTitle,
    ));
  }

  List<NotificationModel> _generateMockNotifications() {
    final now = DateTime.now();
    return [
      // Recent unread notifications
      NotificationModel(
        id: 'NOTIF001',
        type: NotificationType.outbid,
        title: 'You\'ve been outbid!',
        message: 'Someone placed a higher bid on 2020 Toyota Vios',
        timestamp: now.subtract(const Duration(minutes: 15)),
        isRead: false,
        auctionId: 'AUC001',
        carTitle: '2020 Toyota Vios',
        amount: 455000,
      ),
      NotificationModel(
        id: 'NOTIF002',
        type: NotificationType.escrowHeld,
        title: 'Payment secured in escrow',
        message: '₱1250000 for 2021 Mitsubishi Montero is now held in escrow',
        timestamp: now.subtract(const Duration(hours: 2)),
        isRead: false,
        transactionId: 'TXN2002',
        carTitle: '2021 Mitsubishi Montero',
        amount: 1250000,
      ),
      NotificationModel(
        id: 'NOTIF003',
        type: NotificationType.winning,
        title: 'You\'re winning!',
        message: 'Your bid on 2019 Honda Civic is currently the highest',
        timestamp: now.subtract(const Duration(hours: 5)),
        isRead: false,
        auctionId: 'AUC003',
        carTitle: '2019 Honda Civic',
        amount: 720000,
      ),

      // Older read notifications
      NotificationModel(
        id: 'NOTIF004',
        type: NotificationType.escrowReleased,
        title: 'Payment released',
        message: '₱450000 has been released to the seller',
        timestamp: now.subtract(const Duration(days: 2)),
        isRead: true,
        transactionId: 'TXN1001',
        carTitle: '2020 Toyota Vios',
        amount: 450000,
      ),
      NotificationModel(
        id: 'NOTIF005',
        type: NotificationType.won,
        title: 'Congratulations! You won!',
        message: 'You won the auction for 2020 Toyota Vios at ₱450000',
        timestamp: now.subtract(const Duration(days: 10)),
        isRead: true,
        auctionId: 'AUC001',
        carTitle: '2020 Toyota Vios',
        amount: 450000,
      ),
      NotificationModel(
        id: 'NOTIF006',
        type: NotificationType.endingSoon,
        title: 'Auction ending soon!',
        message: '2022 Mazda CX-5 auction ends in 30 minutes',
        timestamp: now.subtract(const Duration(days: 5)),
        isRead: true,
        auctionId: 'AUC005',
        carTitle: '2022 Mazda CX-5',
      ),
      NotificationModel(
        id: 'NOTIF007',
        type: NotificationType.paymentReceived,
        title: 'Payment received',
        message: 'Payment for 2019 Honda Civic has been received',
        timestamp: now.subtract(const Duration(days: 5)),
        isRead: true,
        transactionId: 'TXN2001',
        carTitle: '2019 Honda Civic',
        amount: 680000,
      ),
      NotificationModel(
        id: 'NOTIF008',
        type: NotificationType.lost,
        title: 'Auction ended',
        message: 'The auction for 2021 Ford Everest has ended. Better luck next time!',
        timestamp: now.subtract(const Duration(days: 7)),
        isRead: true,
        auctionId: 'AUC007',
        carTitle: '2021 Ford Everest',
      ),
    ];
  }
}
