// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_timeline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionTimeline _$TransactionTimelineFromJson(Map<String, dynamic> json) =>
    _TransactionTimeline(
      status: json['status'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$TransactionTimelineToJson(
  _TransactionTimeline instance,
) => <String, dynamic>{
  'status': instance.status,
  'timestamp': instance.timestamp.toIso8601String(),
  'description': instance.description,
  'icon': instance.icon,
};
