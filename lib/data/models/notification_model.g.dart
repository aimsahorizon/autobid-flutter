// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    _NotificationModel(
      id: json['id'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      title: json['title'] as String,
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRead: json['isRead'] as bool? ?? false,
      auctionId: json['auctionId'] as String?,
      transactionId: json['transactionId'] as String?,
      carTitle: json['carTitle'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$NotificationModelToJson(_NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'title': instance.title,
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
      'isRead': instance.isRead,
      'auctionId': instance.auctionId,
      'transactionId': instance.transactionId,
      'carTitle': instance.carTitle,
      'amount': instance.amount,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.outbid: 'outbid',
  NotificationType.winning: 'winning',
  NotificationType.won: 'won',
  NotificationType.lost: 'lost',
  NotificationType.endingSoon: 'endingSoon',
  NotificationType.paymentReceived: 'paymentReceived',
  NotificationType.escrowHeld: 'escrowHeld',
  NotificationType.escrowReleased: 'escrowReleased',
  NotificationType.refundProcessed: 'refundProcessed',
  NotificationType.disputeOpened: 'disputeOpened',
  NotificationType.validationComplete: 'validationComplete',
  NotificationType.shipped: 'shipped',
};
