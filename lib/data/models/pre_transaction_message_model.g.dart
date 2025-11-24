// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_transaction_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PreTransactionMessage _$PreTransactionMessageFromJson(
  Map<String, dynamic> json,
) => _PreTransactionMessage(
  id: json['id'] as String,
  preTransactionId: json['preTransactionId'] as String,
  sender: $enumDecode(_$MessageSenderEnumMap, json['sender']),
  senderName: json['senderName'] as String,
  type: $enumDecode(_$MessageTypeEnumMap, json['type']),
  content: json['content'] as String,
  imageUrl: json['imageUrl'] as String?,
  fileName: json['fileName'] as String?,
  timestamp: DateTime.parse(json['timestamp'] as String),
  isRead: json['isRead'] as bool? ?? false,
);

Map<String, dynamic> _$PreTransactionMessageToJson(
  _PreTransactionMessage instance,
) => <String, dynamic>{
  'id': instance.id,
  'preTransactionId': instance.preTransactionId,
  'sender': _$MessageSenderEnumMap[instance.sender]!,
  'senderName': instance.senderName,
  'type': _$MessageTypeEnumMap[instance.type]!,
  'content': instance.content,
  'imageUrl': instance.imageUrl,
  'fileName': instance.fileName,
  'timestamp': instance.timestamp.toIso8601String(),
  'isRead': instance.isRead,
};

const _$MessageSenderEnumMap = {
  MessageSender.buyer: 'buyer',
  MessageSender.seller: 'seller',
  MessageSender.system: 'system',
};

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.file: 'file',
  MessageType.system: 'system',
};
