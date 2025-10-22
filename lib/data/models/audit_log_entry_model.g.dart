// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuditLogEntry _$AuditLogEntryFromJson(Map<String, dynamic> json) =>
    _AuditLogEntry(
      id: json['id'] as String,
      preTransactionId: json['preTransactionId'] as String,
      action: json['action'] as String,
      actor: json['actor'] as String,
      actorName: json['actorName'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      details: json['details'] as String?,
      ra8792Protected: json['ra8792Protected'] as bool? ?? true,
    );

Map<String, dynamic> _$AuditLogEntryToJson(_AuditLogEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'preTransactionId': instance.preTransactionId,
      'action': instance.action,
      'actor': instance.actor,
      'actorName': instance.actorName,
      'timestamp': instance.timestamp.toIso8601String(),
      'details': instance.details,
      'ra8792Protected': instance.ra8792Protected,
    };
