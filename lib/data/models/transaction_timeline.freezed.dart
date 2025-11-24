// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_timeline.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionTimeline {

 String get status; DateTime get timestamp; String get description; String get icon;
/// Create a copy of TransactionTimeline
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionTimelineCopyWith<TransactionTimeline> get copyWith => _$TransactionTimelineCopyWithImpl<TransactionTimeline>(this as TransactionTimeline, _$identity);

  /// Serializes this TransactionTimeline to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionTimeline&&(identical(other.status, status) || other.status == status)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,timestamp,description,icon);

@override
String toString() {
  return 'TransactionTimeline(status: $status, timestamp: $timestamp, description: $description, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $TransactionTimelineCopyWith<$Res>  {
  factory $TransactionTimelineCopyWith(TransactionTimeline value, $Res Function(TransactionTimeline) _then) = _$TransactionTimelineCopyWithImpl;
@useResult
$Res call({
 String status, DateTime timestamp, String description, String icon
});




}
/// @nodoc
class _$TransactionTimelineCopyWithImpl<$Res>
    implements $TransactionTimelineCopyWith<$Res> {
  _$TransactionTimelineCopyWithImpl(this._self, this._then);

  final TransactionTimeline _self;
  final $Res Function(TransactionTimeline) _then;

/// Create a copy of TransactionTimeline
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? timestamp = null,Object? description = null,Object? icon = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionTimeline].
extension TransactionTimelinePatterns on TransactionTimeline {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionTimeline value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionTimeline() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionTimeline value)  $default,){
final _that = this;
switch (_that) {
case _TransactionTimeline():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionTimeline value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionTimeline() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  DateTime timestamp,  String description,  String icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionTimeline() when $default != null:
return $default(_that.status,_that.timestamp,_that.description,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  DateTime timestamp,  String description,  String icon)  $default,) {final _that = this;
switch (_that) {
case _TransactionTimeline():
return $default(_that.status,_that.timestamp,_that.description,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  DateTime timestamp,  String description,  String icon)?  $default,) {final _that = this;
switch (_that) {
case _TransactionTimeline() when $default != null:
return $default(_that.status,_that.timestamp,_that.description,_that.icon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionTimeline implements TransactionTimeline {
  const _TransactionTimeline({required this.status, required this.timestamp, required this.description, required this.icon});
  factory _TransactionTimeline.fromJson(Map<String, dynamic> json) => _$TransactionTimelineFromJson(json);

@override final  String status;
@override final  DateTime timestamp;
@override final  String description;
@override final  String icon;

/// Create a copy of TransactionTimeline
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionTimelineCopyWith<_TransactionTimeline> get copyWith => __$TransactionTimelineCopyWithImpl<_TransactionTimeline>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionTimelineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionTimeline&&(identical(other.status, status) || other.status == status)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,timestamp,description,icon);

@override
String toString() {
  return 'TransactionTimeline(status: $status, timestamp: $timestamp, description: $description, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$TransactionTimelineCopyWith<$Res> implements $TransactionTimelineCopyWith<$Res> {
  factory _$TransactionTimelineCopyWith(_TransactionTimeline value, $Res Function(_TransactionTimeline) _then) = __$TransactionTimelineCopyWithImpl;
@override @useResult
$Res call({
 String status, DateTime timestamp, String description, String icon
});




}
/// @nodoc
class __$TransactionTimelineCopyWithImpl<$Res>
    implements _$TransactionTimelineCopyWith<$Res> {
  __$TransactionTimelineCopyWithImpl(this._self, this._then);

  final _TransactionTimeline _self;
  final $Res Function(_TransactionTimeline) _then;

/// Create a copy of TransactionTimeline
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? timestamp = null,Object? description = null,Object? icon = null,}) {
  return _then(_TransactionTimeline(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
