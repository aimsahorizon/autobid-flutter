// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auto_bid_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AutoBidConfig {

 double get maxBidAmount; double get incrementAmount; bool get isActive;
/// Create a copy of AutoBidConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AutoBidConfigCopyWith<AutoBidConfig> get copyWith => _$AutoBidConfigCopyWithImpl<AutoBidConfig>(this as AutoBidConfig, _$identity);

  /// Serializes this AutoBidConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AutoBidConfig&&(identical(other.maxBidAmount, maxBidAmount) || other.maxBidAmount == maxBidAmount)&&(identical(other.incrementAmount, incrementAmount) || other.incrementAmount == incrementAmount)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxBidAmount,incrementAmount,isActive);

@override
String toString() {
  return 'AutoBidConfig(maxBidAmount: $maxBidAmount, incrementAmount: $incrementAmount, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $AutoBidConfigCopyWith<$Res>  {
  factory $AutoBidConfigCopyWith(AutoBidConfig value, $Res Function(AutoBidConfig) _then) = _$AutoBidConfigCopyWithImpl;
@useResult
$Res call({
 double maxBidAmount, double incrementAmount, bool isActive
});




}
/// @nodoc
class _$AutoBidConfigCopyWithImpl<$Res>
    implements $AutoBidConfigCopyWith<$Res> {
  _$AutoBidConfigCopyWithImpl(this._self, this._then);

  final AutoBidConfig _self;
  final $Res Function(AutoBidConfig) _then;

/// Create a copy of AutoBidConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxBidAmount = null,Object? incrementAmount = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
maxBidAmount: null == maxBidAmount ? _self.maxBidAmount : maxBidAmount // ignore: cast_nullable_to_non_nullable
as double,incrementAmount: null == incrementAmount ? _self.incrementAmount : incrementAmount // ignore: cast_nullable_to_non_nullable
as double,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AutoBidConfig].
extension AutoBidConfigPatterns on AutoBidConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AutoBidConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AutoBidConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AutoBidConfig value)  $default,){
final _that = this;
switch (_that) {
case _AutoBidConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AutoBidConfig value)?  $default,){
final _that = this;
switch (_that) {
case _AutoBidConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double maxBidAmount,  double incrementAmount,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AutoBidConfig() when $default != null:
return $default(_that.maxBidAmount,_that.incrementAmount,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double maxBidAmount,  double incrementAmount,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _AutoBidConfig():
return $default(_that.maxBidAmount,_that.incrementAmount,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double maxBidAmount,  double incrementAmount,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _AutoBidConfig() when $default != null:
return $default(_that.maxBidAmount,_that.incrementAmount,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AutoBidConfig implements AutoBidConfig {
  const _AutoBidConfig({required this.maxBidAmount, required this.incrementAmount, this.isActive = true});
  factory _AutoBidConfig.fromJson(Map<String, dynamic> json) => _$AutoBidConfigFromJson(json);

@override final  double maxBidAmount;
@override final  double incrementAmount;
@override@JsonKey() final  bool isActive;

/// Create a copy of AutoBidConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AutoBidConfigCopyWith<_AutoBidConfig> get copyWith => __$AutoBidConfigCopyWithImpl<_AutoBidConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AutoBidConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AutoBidConfig&&(identical(other.maxBidAmount, maxBidAmount) || other.maxBidAmount == maxBidAmount)&&(identical(other.incrementAmount, incrementAmount) || other.incrementAmount == incrementAmount)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxBidAmount,incrementAmount,isActive);

@override
String toString() {
  return 'AutoBidConfig(maxBidAmount: $maxBidAmount, incrementAmount: $incrementAmount, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$AutoBidConfigCopyWith<$Res> implements $AutoBidConfigCopyWith<$Res> {
  factory _$AutoBidConfigCopyWith(_AutoBidConfig value, $Res Function(_AutoBidConfig) _then) = __$AutoBidConfigCopyWithImpl;
@override @useResult
$Res call({
 double maxBidAmount, double incrementAmount, bool isActive
});




}
/// @nodoc
class __$AutoBidConfigCopyWithImpl<$Res>
    implements _$AutoBidConfigCopyWith<$Res> {
  __$AutoBidConfigCopyWithImpl(this._self, this._then);

  final _AutoBidConfig _self;
  final $Res Function(_AutoBidConfig) _then;

/// Create a copy of AutoBidConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxBidAmount = null,Object? incrementAmount = null,Object? isActive = null,}) {
  return _then(_AutoBidConfig(
maxBidAmount: null == maxBidAmount ? _self.maxBidAmount : maxBidAmount // ignore: cast_nullable_to_non_nullable
as double,incrementAmount: null == incrementAmount ? _self.incrementAmount : incrementAmount // ignore: cast_nullable_to_non_nullable
as double,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
