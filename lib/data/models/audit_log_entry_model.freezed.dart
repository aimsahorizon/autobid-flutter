// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audit_log_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuditLogEntry {

 String get id; String get preTransactionId;// ===== ACTION DETAILS =====
/// Action performed (e.g., "Buyer Verified", "Agreement Signed", "Payment Confirmed")
 String get action;/// Actor who performed the action ('buyer' or 'seller')
 String get actor;/// Name of the actor
 String get actorName;/// Timestamp when action occurred
 DateTime get timestamp;/// Optional detailed description of the action
 String? get details;// ===== RA 8792 PROTECTION =====
/// Flag indicating this record is protected under RA 8792
/// "This digital record is protected under the Electronic Commerce Act
/// of 2000 (RA 8792), Sections 6-13, and serves as admissible evidence
/// in legal proceedings."
 bool get ra8792Protected;
/// Create a copy of AuditLogEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuditLogEntryCopyWith<AuditLogEntry> get copyWith => _$AuditLogEntryCopyWithImpl<AuditLogEntry>(this as AuditLogEntry, _$identity);

  /// Serializes this AuditLogEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuditLogEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.preTransactionId, preTransactionId) || other.preTransactionId == preTransactionId)&&(identical(other.action, action) || other.action == action)&&(identical(other.actor, actor) || other.actor == actor)&&(identical(other.actorName, actorName) || other.actorName == actorName)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.details, details) || other.details == details)&&(identical(other.ra8792Protected, ra8792Protected) || other.ra8792Protected == ra8792Protected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,preTransactionId,action,actor,actorName,timestamp,details,ra8792Protected);

@override
String toString() {
  return 'AuditLogEntry(id: $id, preTransactionId: $preTransactionId, action: $action, actor: $actor, actorName: $actorName, timestamp: $timestamp, details: $details, ra8792Protected: $ra8792Protected)';
}


}

/// @nodoc
abstract mixin class $AuditLogEntryCopyWith<$Res>  {
  factory $AuditLogEntryCopyWith(AuditLogEntry value, $Res Function(AuditLogEntry) _then) = _$AuditLogEntryCopyWithImpl;
@useResult
$Res call({
 String id, String preTransactionId, String action, String actor, String actorName, DateTime timestamp, String? details, bool ra8792Protected
});




}
/// @nodoc
class _$AuditLogEntryCopyWithImpl<$Res>
    implements $AuditLogEntryCopyWith<$Res> {
  _$AuditLogEntryCopyWithImpl(this._self, this._then);

  final AuditLogEntry _self;
  final $Res Function(AuditLogEntry) _then;

/// Create a copy of AuditLogEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? preTransactionId = null,Object? action = null,Object? actor = null,Object? actorName = null,Object? timestamp = null,Object? details = freezed,Object? ra8792Protected = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,preTransactionId: null == preTransactionId ? _self.preTransactionId : preTransactionId // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,actor: null == actor ? _self.actor : actor // ignore: cast_nullable_to_non_nullable
as String,actorName: null == actorName ? _self.actorName : actorName // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,ra8792Protected: null == ra8792Protected ? _self.ra8792Protected : ra8792Protected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AuditLogEntry].
extension AuditLogEntryPatterns on AuditLogEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuditLogEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuditLogEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuditLogEntry value)  $default,){
final _that = this;
switch (_that) {
case _AuditLogEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuditLogEntry value)?  $default,){
final _that = this;
switch (_that) {
case _AuditLogEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String preTransactionId,  String action,  String actor,  String actorName,  DateTime timestamp,  String? details,  bool ra8792Protected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuditLogEntry() when $default != null:
return $default(_that.id,_that.preTransactionId,_that.action,_that.actor,_that.actorName,_that.timestamp,_that.details,_that.ra8792Protected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String preTransactionId,  String action,  String actor,  String actorName,  DateTime timestamp,  String? details,  bool ra8792Protected)  $default,) {final _that = this;
switch (_that) {
case _AuditLogEntry():
return $default(_that.id,_that.preTransactionId,_that.action,_that.actor,_that.actorName,_that.timestamp,_that.details,_that.ra8792Protected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String preTransactionId,  String action,  String actor,  String actorName,  DateTime timestamp,  String? details,  bool ra8792Protected)?  $default,) {final _that = this;
switch (_that) {
case _AuditLogEntry() when $default != null:
return $default(_that.id,_that.preTransactionId,_that.action,_that.actor,_that.actorName,_that.timestamp,_that.details,_that.ra8792Protected);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuditLogEntry implements AuditLogEntry {
  const _AuditLogEntry({required this.id, required this.preTransactionId, required this.action, required this.actor, required this.actorName, required this.timestamp, this.details, this.ra8792Protected = true});
  factory _AuditLogEntry.fromJson(Map<String, dynamic> json) => _$AuditLogEntryFromJson(json);

@override final  String id;
@override final  String preTransactionId;
// ===== ACTION DETAILS =====
/// Action performed (e.g., "Buyer Verified", "Agreement Signed", "Payment Confirmed")
@override final  String action;
/// Actor who performed the action ('buyer' or 'seller')
@override final  String actor;
/// Name of the actor
@override final  String actorName;
/// Timestamp when action occurred
@override final  DateTime timestamp;
/// Optional detailed description of the action
@override final  String? details;
// ===== RA 8792 PROTECTION =====
/// Flag indicating this record is protected under RA 8792
/// "This digital record is protected under the Electronic Commerce Act
/// of 2000 (RA 8792), Sections 6-13, and serves as admissible evidence
/// in legal proceedings."
@override@JsonKey() final  bool ra8792Protected;

/// Create a copy of AuditLogEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuditLogEntryCopyWith<_AuditLogEntry> get copyWith => __$AuditLogEntryCopyWithImpl<_AuditLogEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuditLogEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuditLogEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.preTransactionId, preTransactionId) || other.preTransactionId == preTransactionId)&&(identical(other.action, action) || other.action == action)&&(identical(other.actor, actor) || other.actor == actor)&&(identical(other.actorName, actorName) || other.actorName == actorName)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.details, details) || other.details == details)&&(identical(other.ra8792Protected, ra8792Protected) || other.ra8792Protected == ra8792Protected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,preTransactionId,action,actor,actorName,timestamp,details,ra8792Protected);

@override
String toString() {
  return 'AuditLogEntry(id: $id, preTransactionId: $preTransactionId, action: $action, actor: $actor, actorName: $actorName, timestamp: $timestamp, details: $details, ra8792Protected: $ra8792Protected)';
}


}

/// @nodoc
abstract mixin class _$AuditLogEntryCopyWith<$Res> implements $AuditLogEntryCopyWith<$Res> {
  factory _$AuditLogEntryCopyWith(_AuditLogEntry value, $Res Function(_AuditLogEntry) _then) = __$AuditLogEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String preTransactionId, String action, String actor, String actorName, DateTime timestamp, String? details, bool ra8792Protected
});




}
/// @nodoc
class __$AuditLogEntryCopyWithImpl<$Res>
    implements _$AuditLogEntryCopyWith<$Res> {
  __$AuditLogEntryCopyWithImpl(this._self, this._then);

  final _AuditLogEntry _self;
  final $Res Function(_AuditLogEntry) _then;

/// Create a copy of AuditLogEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? preTransactionId = null,Object? action = null,Object? actor = null,Object? actorName = null,Object? timestamp = null,Object? details = freezed,Object? ra8792Protected = null,}) {
  return _then(_AuditLogEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,preTransactionId: null == preTransactionId ? _self.preTransactionId : preTransactionId // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,actor: null == actor ? _self.actor : actor // ignore: cast_nullable_to_non_nullable
as String,actorName: null == actorName ? _self.actorName : actorName // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,ra8792Protected: null == ra8792Protected ? _self.ra8792Protected : ra8792Protected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
