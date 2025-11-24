import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

enum NotificationType {
  outbid,
  winning,
  won,
  lost,
  endingSoon,
  paymentReceived,
  escrowHeld,
  escrowReleased,
  refundProcessed,
  disputeOpened,
  validationComplete,
  shipped,
}

@freezed
abstract class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    required NotificationType type,
    required String title,
    required String message,
    required DateTime timestamp,
    @Default(false) bool isRead,
    String? auctionId,
    String? transactionId,
    String? carTitle,
    double? amount,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
