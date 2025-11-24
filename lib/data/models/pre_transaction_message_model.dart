import 'package:freezed_annotation/freezed_annotation.dart';

part 'pre_transaction_message_model.freezed.dart';
part 'pre_transaction_message_model.g.dart';

enum MessageSender {
  @JsonValue('buyer')
  buyer,
  @JsonValue('seller')
  seller,
  @JsonValue('system')
  system,
}

enum MessageType {
  @JsonValue('text')
  text,
  @JsonValue('image')
  image,
  @JsonValue('file')
  file,
  @JsonValue('system')
  system,
}

@freezed
abstract class PreTransactionMessage with _$PreTransactionMessage {
  const factory PreTransactionMessage({
    required String id,
    required String preTransactionId,
    required MessageSender sender,
    required String senderName,
    required MessageType type,
    required String content,
    String? imageUrl,
    String? fileName,
    required DateTime timestamp,
    @Default(false) bool isRead,
  }) = _PreTransactionMessage;

  factory PreTransactionMessage.fromJson(Map<String, dynamic> json) =>
      _$PreTransactionMessageFromJson(json);
}
