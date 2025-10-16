// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pre_transaction_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PreTransactionMessage {

 String get id; String get preTransactionId; MessageSender get sender; String get senderName; MessageType get type; String get content; String? get imageUrl; String? get fileName; DateTime get timestamp; bool get isRead;
/// Create a copy of PreTransactionMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreTransactionMessageCopyWith<PreTransactionMessage> get copyWith => _$PreTransactionMessageCopyWithImpl<PreTransactionMessage>(this as PreTransactionMessage, _$identity);

  /// Serializes this PreTransactionMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreTransactionMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.preTransactionId, preTransactionId) || other.preTransactionId == preTransactionId)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.type, type) || other.type == type)&&(identical(other.content, content) || other.content == content)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isRead, isRead) || other.isRead == isRead));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,preTransactionId,sender,senderName,type,content,imageUrl,fileName,timestamp,isRead);

@override
String toString() {
  return 'PreTransactionMessage(id: $id, preTransactionId: $preTransactionId, sender: $sender, senderName: $senderName, type: $type, content: $content, imageUrl: $imageUrl, fileName: $fileName, timestamp: $timestamp, isRead: $isRead)';
}


}

/// @nodoc
abstract mixin class $PreTransactionMessageCopyWith<$Res>  {
  factory $PreTransactionMessageCopyWith(PreTransactionMessage value, $Res Function(PreTransactionMessage) _then) = _$PreTransactionMessageCopyWithImpl;
@useResult
$Res call({
 String id, String preTransactionId, MessageSender sender, String senderName, MessageType type, String content, String? imageUrl, String? fileName, DateTime timestamp, bool isRead
});




}
/// @nodoc
class _$PreTransactionMessageCopyWithImpl<$Res>
    implements $PreTransactionMessageCopyWith<$Res> {
  _$PreTransactionMessageCopyWithImpl(this._self, this._then);

  final PreTransactionMessage _self;
  final $Res Function(PreTransactionMessage) _then;

/// Create a copy of PreTransactionMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? preTransactionId = null,Object? sender = null,Object? senderName = null,Object? type = null,Object? content = null,Object? imageUrl = freezed,Object? fileName = freezed,Object? timestamp = null,Object? isRead = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,preTransactionId: null == preTransactionId ? _self.preTransactionId : preTransactionId // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as MessageSender,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MessageType,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PreTransactionMessage].
extension PreTransactionMessagePatterns on PreTransactionMessage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PreTransactionMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreTransactionMessage() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PreTransactionMessage value)  $default,){
final _that = this;
switch (_that) {
case _PreTransactionMessage():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PreTransactionMessage value)?  $default,){
final _that = this;
switch (_that) {
case _PreTransactionMessage() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String preTransactionId,  MessageSender sender,  String senderName,  MessageType type,  String content,  String? imageUrl,  String? fileName,  DateTime timestamp,  bool isRead)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreTransactionMessage() when $default != null:
return $default(_that.id,_that.preTransactionId,_that.sender,_that.senderName,_that.type,_that.content,_that.imageUrl,_that.fileName,_that.timestamp,_that.isRead);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String preTransactionId,  MessageSender sender,  String senderName,  MessageType type,  String content,  String? imageUrl,  String? fileName,  DateTime timestamp,  bool isRead)  $default,) {final _that = this;
switch (_that) {
case _PreTransactionMessage():
return $default(_that.id,_that.preTransactionId,_that.sender,_that.senderName,_that.type,_that.content,_that.imageUrl,_that.fileName,_that.timestamp,_that.isRead);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String preTransactionId,  MessageSender sender,  String senderName,  MessageType type,  String content,  String? imageUrl,  String? fileName,  DateTime timestamp,  bool isRead)?  $default,) {final _that = this;
switch (_that) {
case _PreTransactionMessage() when $default != null:
return $default(_that.id,_that.preTransactionId,_that.sender,_that.senderName,_that.type,_that.content,_that.imageUrl,_that.fileName,_that.timestamp,_that.isRead);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PreTransactionMessage implements PreTransactionMessage {
  const _PreTransactionMessage({required this.id, required this.preTransactionId, required this.sender, required this.senderName, required this.type, required this.content, this.imageUrl, this.fileName, required this.timestamp, this.isRead = false});
  factory _PreTransactionMessage.fromJson(Map<String, dynamic> json) => _$PreTransactionMessageFromJson(json);

@override final  String id;
@override final  String preTransactionId;
@override final  MessageSender sender;
@override final  String senderName;
@override final  MessageType type;
@override final  String content;
@override final  String? imageUrl;
@override final  String? fileName;
@override final  DateTime timestamp;
@override@JsonKey() final  bool isRead;

/// Create a copy of PreTransactionMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreTransactionMessageCopyWith<_PreTransactionMessage> get copyWith => __$PreTransactionMessageCopyWithImpl<_PreTransactionMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PreTransactionMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreTransactionMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.preTransactionId, preTransactionId) || other.preTransactionId == preTransactionId)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.type, type) || other.type == type)&&(identical(other.content, content) || other.content == content)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isRead, isRead) || other.isRead == isRead));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,preTransactionId,sender,senderName,type,content,imageUrl,fileName,timestamp,isRead);

@override
String toString() {
  return 'PreTransactionMessage(id: $id, preTransactionId: $preTransactionId, sender: $sender, senderName: $senderName, type: $type, content: $content, imageUrl: $imageUrl, fileName: $fileName, timestamp: $timestamp, isRead: $isRead)';
}


}

/// @nodoc
abstract mixin class _$PreTransactionMessageCopyWith<$Res> implements $PreTransactionMessageCopyWith<$Res> {
  factory _$PreTransactionMessageCopyWith(_PreTransactionMessage value, $Res Function(_PreTransactionMessage) _then) = __$PreTransactionMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String preTransactionId, MessageSender sender, String senderName, MessageType type, String content, String? imageUrl, String? fileName, DateTime timestamp, bool isRead
});




}
/// @nodoc
class __$PreTransactionMessageCopyWithImpl<$Res>
    implements _$PreTransactionMessageCopyWith<$Res> {
  __$PreTransactionMessageCopyWithImpl(this._self, this._then);

  final _PreTransactionMessage _self;
  final $Res Function(_PreTransactionMessage) _then;

/// Create a copy of PreTransactionMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? preTransactionId = null,Object? sender = null,Object? senderName = null,Object? type = null,Object? content = null,Object? imageUrl = freezed,Object? fileName = freezed,Object? timestamp = null,Object? isRead = null,}) {
  return _then(_PreTransactionMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,preTransactionId: null == preTransactionId ? _self.preTransactionId : preTransactionId // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as MessageSender,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MessageType,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
