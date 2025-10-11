// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_condition_attribute.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VehicleConditionAttribute {

/// Unique identifier for the attribute (e.g., "hasAccidentHistory")
 String get id;/// Display label shown to the user
 String get label;/// Descriptive subtitle explaining what this condition means
 String get description;/// Category grouping (e.g., "Service", "Damage", "Body & Modifications", "Usage")
 String get category;/// Current toggle value (true/false)
 bool get value;/// Sort order within category (lower = appears first)
 int get sortOrder;/// Icon identifier for visual representation (optional)
 String? get iconData;/// Whether this is a positive indicator (green) or negative (orange/red)
 bool get isPositive;
/// Create a copy of VehicleConditionAttribute
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleConditionAttributeCopyWith<VehicleConditionAttribute> get copyWith => _$VehicleConditionAttributeCopyWithImpl<VehicleConditionAttribute>(this as VehicleConditionAttribute, _$identity);

  /// Serializes this VehicleConditionAttribute to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehicleConditionAttribute&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.value, value) || other.value == value)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.iconData, iconData) || other.iconData == iconData)&&(identical(other.isPositive, isPositive) || other.isPositive == isPositive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,description,category,value,sortOrder,iconData,isPositive);

@override
String toString() {
  return 'VehicleConditionAttribute(id: $id, label: $label, description: $description, category: $category, value: $value, sortOrder: $sortOrder, iconData: $iconData, isPositive: $isPositive)';
}


}

/// @nodoc
abstract mixin class $VehicleConditionAttributeCopyWith<$Res>  {
  factory $VehicleConditionAttributeCopyWith(VehicleConditionAttribute value, $Res Function(VehicleConditionAttribute) _then) = _$VehicleConditionAttributeCopyWithImpl;
@useResult
$Res call({
 String id, String label, String description, String category, bool value, int sortOrder, String? iconData, bool isPositive
});




}
/// @nodoc
class _$VehicleConditionAttributeCopyWithImpl<$Res>
    implements $VehicleConditionAttributeCopyWith<$Res> {
  _$VehicleConditionAttributeCopyWithImpl(this._self, this._then);

  final VehicleConditionAttribute _self;
  final $Res Function(VehicleConditionAttribute) _then;

/// Create a copy of VehicleConditionAttribute
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? description = null,Object? category = null,Object? value = null,Object? sortOrder = null,Object? iconData = freezed,Object? isPositive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,iconData: freezed == iconData ? _self.iconData : iconData // ignore: cast_nullable_to_non_nullable
as String?,isPositive: null == isPositive ? _self.isPositive : isPositive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VehicleConditionAttribute].
extension VehicleConditionAttributePatterns on VehicleConditionAttribute {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VehicleConditionAttribute value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VehicleConditionAttribute() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VehicleConditionAttribute value)  $default,){
final _that = this;
switch (_that) {
case _VehicleConditionAttribute():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VehicleConditionAttribute value)?  $default,){
final _that = this;
switch (_that) {
case _VehicleConditionAttribute() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  String description,  String category,  bool value,  int sortOrder,  String? iconData,  bool isPositive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VehicleConditionAttribute() when $default != null:
return $default(_that.id,_that.label,_that.description,_that.category,_that.value,_that.sortOrder,_that.iconData,_that.isPositive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  String description,  String category,  bool value,  int sortOrder,  String? iconData,  bool isPositive)  $default,) {final _that = this;
switch (_that) {
case _VehicleConditionAttribute():
return $default(_that.id,_that.label,_that.description,_that.category,_that.value,_that.sortOrder,_that.iconData,_that.isPositive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  String description,  String category,  bool value,  int sortOrder,  String? iconData,  bool isPositive)?  $default,) {final _that = this;
switch (_that) {
case _VehicleConditionAttribute() when $default != null:
return $default(_that.id,_that.label,_that.description,_that.category,_that.value,_that.sortOrder,_that.iconData,_that.isPositive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VehicleConditionAttribute implements VehicleConditionAttribute {
  const _VehicleConditionAttribute({required this.id, required this.label, required this.description, required this.category, this.value = false, this.sortOrder = 0, this.iconData, this.isPositive = false});
  factory _VehicleConditionAttribute.fromJson(Map<String, dynamic> json) => _$VehicleConditionAttributeFromJson(json);

/// Unique identifier for the attribute (e.g., "hasAccidentHistory")
@override final  String id;
/// Display label shown to the user
@override final  String label;
/// Descriptive subtitle explaining what this condition means
@override final  String description;
/// Category grouping (e.g., "Service", "Damage", "Body & Modifications", "Usage")
@override final  String category;
/// Current toggle value (true/false)
@override@JsonKey() final  bool value;
/// Sort order within category (lower = appears first)
@override@JsonKey() final  int sortOrder;
/// Icon identifier for visual representation (optional)
@override final  String? iconData;
/// Whether this is a positive indicator (green) or negative (orange/red)
@override@JsonKey() final  bool isPositive;

/// Create a copy of VehicleConditionAttribute
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleConditionAttributeCopyWith<_VehicleConditionAttribute> get copyWith => __$VehicleConditionAttributeCopyWithImpl<_VehicleConditionAttribute>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VehicleConditionAttributeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleConditionAttribute&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.value, value) || other.value == value)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.iconData, iconData) || other.iconData == iconData)&&(identical(other.isPositive, isPositive) || other.isPositive == isPositive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,description,category,value,sortOrder,iconData,isPositive);

@override
String toString() {
  return 'VehicleConditionAttribute(id: $id, label: $label, description: $description, category: $category, value: $value, sortOrder: $sortOrder, iconData: $iconData, isPositive: $isPositive)';
}


}

/// @nodoc
abstract mixin class _$VehicleConditionAttributeCopyWith<$Res> implements $VehicleConditionAttributeCopyWith<$Res> {
  factory _$VehicleConditionAttributeCopyWith(_VehicleConditionAttribute value, $Res Function(_VehicleConditionAttribute) _then) = __$VehicleConditionAttributeCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, String description, String category, bool value, int sortOrder, String? iconData, bool isPositive
});




}
/// @nodoc
class __$VehicleConditionAttributeCopyWithImpl<$Res>
    implements _$VehicleConditionAttributeCopyWith<$Res> {
  __$VehicleConditionAttributeCopyWithImpl(this._self, this._then);

  final _VehicleConditionAttribute _self;
  final $Res Function(_VehicleConditionAttribute) _then;

/// Create a copy of VehicleConditionAttribute
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? description = null,Object? category = null,Object? value = null,Object? sortOrder = null,Object? iconData = freezed,Object? isPositive = null,}) {
  return _then(_VehicleConditionAttribute(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,iconData: freezed == iconData ? _self.iconData : iconData // ignore: cast_nullable_to_non_nullable
as String?,isPositive: null == isPositive ? _self.isPositive : isPositive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
