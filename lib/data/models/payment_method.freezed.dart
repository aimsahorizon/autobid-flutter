// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentMethod {

 PaymentMethodType get type; String get displayName; String get icon; String get description; String? get accountNumber; bool get isDefault;
/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentMethodCopyWith<PaymentMethod> get copyWith => _$PaymentMethodCopyWithImpl<PaymentMethod>(this as PaymentMethod, _$identity);

  /// Serializes this PaymentMethod to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentMethod&&(identical(other.type, type) || other.type == type)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.description, description) || other.description == description)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,displayName,icon,description,accountNumber,isDefault);

@override
String toString() {
  return 'PaymentMethod(type: $type, displayName: $displayName, icon: $icon, description: $description, accountNumber: $accountNumber, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class $PaymentMethodCopyWith<$Res>  {
  factory $PaymentMethodCopyWith(PaymentMethod value, $Res Function(PaymentMethod) _then) = _$PaymentMethodCopyWithImpl;
@useResult
$Res call({
 PaymentMethodType type, String displayName, String icon, String description, String? accountNumber, bool isDefault
});




}
/// @nodoc
class _$PaymentMethodCopyWithImpl<$Res>
    implements $PaymentMethodCopyWith<$Res> {
  _$PaymentMethodCopyWithImpl(this._self, this._then);

  final PaymentMethod _self;
  final $Res Function(PaymentMethod) _then;

/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? displayName = null,Object? icon = null,Object? description = null,Object? accountNumber = freezed,Object? isDefault = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PaymentMethodType,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentMethod].
extension PaymentMethodPatterns on PaymentMethod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentMethod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentMethod() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentMethod value)  $default,){
final _that = this;
switch (_that) {
case _PaymentMethod():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentMethod value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentMethod() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PaymentMethodType type,  String displayName,  String icon,  String description,  String? accountNumber,  bool isDefault)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentMethod() when $default != null:
return $default(_that.type,_that.displayName,_that.icon,_that.description,_that.accountNumber,_that.isDefault);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PaymentMethodType type,  String displayName,  String icon,  String description,  String? accountNumber,  bool isDefault)  $default,) {final _that = this;
switch (_that) {
case _PaymentMethod():
return $default(_that.type,_that.displayName,_that.icon,_that.description,_that.accountNumber,_that.isDefault);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PaymentMethodType type,  String displayName,  String icon,  String description,  String? accountNumber,  bool isDefault)?  $default,) {final _that = this;
switch (_that) {
case _PaymentMethod() when $default != null:
return $default(_that.type,_that.displayName,_that.icon,_that.description,_that.accountNumber,_that.isDefault);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentMethod implements PaymentMethod {
  const _PaymentMethod({required this.type, required this.displayName, required this.icon, required this.description, this.accountNumber, this.isDefault = false});
  factory _PaymentMethod.fromJson(Map<String, dynamic> json) => _$PaymentMethodFromJson(json);

@override final  PaymentMethodType type;
@override final  String displayName;
@override final  String icon;
@override final  String description;
@override final  String? accountNumber;
@override@JsonKey() final  bool isDefault;

/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentMethodCopyWith<_PaymentMethod> get copyWith => __$PaymentMethodCopyWithImpl<_PaymentMethod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentMethodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentMethod&&(identical(other.type, type) || other.type == type)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.description, description) || other.description == description)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,displayName,icon,description,accountNumber,isDefault);

@override
String toString() {
  return 'PaymentMethod(type: $type, displayName: $displayName, icon: $icon, description: $description, accountNumber: $accountNumber, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class _$PaymentMethodCopyWith<$Res> implements $PaymentMethodCopyWith<$Res> {
  factory _$PaymentMethodCopyWith(_PaymentMethod value, $Res Function(_PaymentMethod) _then) = __$PaymentMethodCopyWithImpl;
@override @useResult
$Res call({
 PaymentMethodType type, String displayName, String icon, String description, String? accountNumber, bool isDefault
});




}
/// @nodoc
class __$PaymentMethodCopyWithImpl<$Res>
    implements _$PaymentMethodCopyWith<$Res> {
  __$PaymentMethodCopyWithImpl(this._self, this._then);

  final _PaymentMethod _self;
  final $Res Function(_PaymentMethod) _then;

/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? displayName = null,Object? icon = null,Object? description = null,Object? accountNumber = freezed,Object? isDefault = null,}) {
  return _then(_PaymentMethod(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PaymentMethodType,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,accountNumber: freezed == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String?,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
