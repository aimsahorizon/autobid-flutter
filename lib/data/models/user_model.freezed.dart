// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProofOfAddress {

 ProofOfAddressType get type; String get imageUrl; DateTime get uploadedAt; bool get verified;
/// Create a copy of ProofOfAddress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProofOfAddressCopyWith<ProofOfAddress> get copyWith => _$ProofOfAddressCopyWithImpl<ProofOfAddress>(this as ProofOfAddress, _$identity);

  /// Serializes this ProofOfAddress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProofOfAddress&&(identical(other.type, type) || other.type == type)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.uploadedAt, uploadedAt) || other.uploadedAt == uploadedAt)&&(identical(other.verified, verified) || other.verified == verified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,imageUrl,uploadedAt,verified);

@override
String toString() {
  return 'ProofOfAddress(type: $type, imageUrl: $imageUrl, uploadedAt: $uploadedAt, verified: $verified)';
}


}

/// @nodoc
abstract mixin class $ProofOfAddressCopyWith<$Res>  {
  factory $ProofOfAddressCopyWith(ProofOfAddress value, $Res Function(ProofOfAddress) _then) = _$ProofOfAddressCopyWithImpl;
@useResult
$Res call({
 ProofOfAddressType type, String imageUrl, DateTime uploadedAt, bool verified
});




}
/// @nodoc
class _$ProofOfAddressCopyWithImpl<$Res>
    implements $ProofOfAddressCopyWith<$Res> {
  _$ProofOfAddressCopyWithImpl(this._self, this._then);

  final ProofOfAddress _self;
  final $Res Function(ProofOfAddress) _then;

/// Create a copy of ProofOfAddress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? imageUrl = null,Object? uploadedAt = null,Object? verified = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ProofOfAddressType,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,uploadedAt: null == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProofOfAddress].
extension ProofOfAddressPatterns on ProofOfAddress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProofOfAddress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProofOfAddress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProofOfAddress value)  $default,){
final _that = this;
switch (_that) {
case _ProofOfAddress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProofOfAddress value)?  $default,){
final _that = this;
switch (_that) {
case _ProofOfAddress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProofOfAddressType type,  String imageUrl,  DateTime uploadedAt,  bool verified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProofOfAddress() when $default != null:
return $default(_that.type,_that.imageUrl,_that.uploadedAt,_that.verified);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProofOfAddressType type,  String imageUrl,  DateTime uploadedAt,  bool verified)  $default,) {final _that = this;
switch (_that) {
case _ProofOfAddress():
return $default(_that.type,_that.imageUrl,_that.uploadedAt,_that.verified);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProofOfAddressType type,  String imageUrl,  DateTime uploadedAt,  bool verified)?  $default,) {final _that = this;
switch (_that) {
case _ProofOfAddress() when $default != null:
return $default(_that.type,_that.imageUrl,_that.uploadedAt,_that.verified);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProofOfAddress implements ProofOfAddress {
  const _ProofOfAddress({required this.type, required this.imageUrl, required this.uploadedAt, this.verified = false});
  factory _ProofOfAddress.fromJson(Map<String, dynamic> json) => _$ProofOfAddressFromJson(json);

@override final  ProofOfAddressType type;
@override final  String imageUrl;
@override final  DateTime uploadedAt;
@override@JsonKey() final  bool verified;

/// Create a copy of ProofOfAddress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProofOfAddressCopyWith<_ProofOfAddress> get copyWith => __$ProofOfAddressCopyWithImpl<_ProofOfAddress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProofOfAddressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProofOfAddress&&(identical(other.type, type) || other.type == type)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.uploadedAt, uploadedAt) || other.uploadedAt == uploadedAt)&&(identical(other.verified, verified) || other.verified == verified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,imageUrl,uploadedAt,verified);

@override
String toString() {
  return 'ProofOfAddress(type: $type, imageUrl: $imageUrl, uploadedAt: $uploadedAt, verified: $verified)';
}


}

/// @nodoc
abstract mixin class _$ProofOfAddressCopyWith<$Res> implements $ProofOfAddressCopyWith<$Res> {
  factory _$ProofOfAddressCopyWith(_ProofOfAddress value, $Res Function(_ProofOfAddress) _then) = __$ProofOfAddressCopyWithImpl;
@override @useResult
$Res call({
 ProofOfAddressType type, String imageUrl, DateTime uploadedAt, bool verified
});




}
/// @nodoc
class __$ProofOfAddressCopyWithImpl<$Res>
    implements _$ProofOfAddressCopyWith<$Res> {
  __$ProofOfAddressCopyWithImpl(this._self, this._then);

  final _ProofOfAddress _self;
  final $Res Function(_ProofOfAddress) _then;

/// Create a copy of ProofOfAddress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? imageUrl = null,Object? uploadedAt = null,Object? verified = null,}) {
  return _then(_ProofOfAddress(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ProofOfAddressType,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,uploadedAt: null == uploadedAt ? _self.uploadedAt : uploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$NbiClearance {

 String get imageUrl; DateTime get issueDate; DateTime get expiryDate;
/// Create a copy of NbiClearance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NbiClearanceCopyWith<NbiClearance> get copyWith => _$NbiClearanceCopyWithImpl<NbiClearance>(this as NbiClearance, _$identity);

  /// Serializes this NbiClearance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NbiClearance&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.issueDate, issueDate) || other.issueDate == issueDate)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,issueDate,expiryDate);

@override
String toString() {
  return 'NbiClearance(imageUrl: $imageUrl, issueDate: $issueDate, expiryDate: $expiryDate)';
}


}

/// @nodoc
abstract mixin class $NbiClearanceCopyWith<$Res>  {
  factory $NbiClearanceCopyWith(NbiClearance value, $Res Function(NbiClearance) _then) = _$NbiClearanceCopyWithImpl;
@useResult
$Res call({
 String imageUrl, DateTime issueDate, DateTime expiryDate
});




}
/// @nodoc
class _$NbiClearanceCopyWithImpl<$Res>
    implements $NbiClearanceCopyWith<$Res> {
  _$NbiClearanceCopyWithImpl(this._self, this._then);

  final NbiClearance _self;
  final $Res Function(NbiClearance) _then;

/// Create a copy of NbiClearance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imageUrl = null,Object? issueDate = null,Object? expiryDate = null,}) {
  return _then(_self.copyWith(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,issueDate: null == issueDate ? _self.issueDate : issueDate // ignore: cast_nullable_to_non_nullable
as DateTime,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [NbiClearance].
extension NbiClearancePatterns on NbiClearance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NbiClearance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NbiClearance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NbiClearance value)  $default,){
final _that = this;
switch (_that) {
case _NbiClearance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NbiClearance value)?  $default,){
final _that = this;
switch (_that) {
case _NbiClearance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String imageUrl,  DateTime issueDate,  DateTime expiryDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NbiClearance() when $default != null:
return $default(_that.imageUrl,_that.issueDate,_that.expiryDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String imageUrl,  DateTime issueDate,  DateTime expiryDate)  $default,) {final _that = this;
switch (_that) {
case _NbiClearance():
return $default(_that.imageUrl,_that.issueDate,_that.expiryDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String imageUrl,  DateTime issueDate,  DateTime expiryDate)?  $default,) {final _that = this;
switch (_that) {
case _NbiClearance() when $default != null:
return $default(_that.imageUrl,_that.issueDate,_that.expiryDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NbiClearance implements NbiClearance {
  const _NbiClearance({required this.imageUrl, required this.issueDate, required this.expiryDate});
  factory _NbiClearance.fromJson(Map<String, dynamic> json) => _$NbiClearanceFromJson(json);

@override final  String imageUrl;
@override final  DateTime issueDate;
@override final  DateTime expiryDate;

/// Create a copy of NbiClearance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NbiClearanceCopyWith<_NbiClearance> get copyWith => __$NbiClearanceCopyWithImpl<_NbiClearance>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NbiClearanceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NbiClearance&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.issueDate, issueDate) || other.issueDate == issueDate)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,issueDate,expiryDate);

@override
String toString() {
  return 'NbiClearance(imageUrl: $imageUrl, issueDate: $issueDate, expiryDate: $expiryDate)';
}


}

/// @nodoc
abstract mixin class _$NbiClearanceCopyWith<$Res> implements $NbiClearanceCopyWith<$Res> {
  factory _$NbiClearanceCopyWith(_NbiClearance value, $Res Function(_NbiClearance) _then) = __$NbiClearanceCopyWithImpl;
@override @useResult
$Res call({
 String imageUrl, DateTime issueDate, DateTime expiryDate
});




}
/// @nodoc
class __$NbiClearanceCopyWithImpl<$Res>
    implements _$NbiClearanceCopyWith<$Res> {
  __$NbiClearanceCopyWithImpl(this._self, this._then);

  final _NbiClearance _self;
  final $Res Function(_NbiClearance) _then;

/// Create a copy of NbiClearance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imageUrl = null,Object? issueDate = null,Object? expiryDate = null,}) {
  return _then(_NbiClearance(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,issueDate: null == issueDate ? _self.issueDate : issueDate // ignore: cast_nullable_to_non_nullable
as DateTime,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$VerificationLimits {

 int get buyLimit; int get sellLimit;
/// Create a copy of VerificationLimits
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerificationLimitsCopyWith<VerificationLimits> get copyWith => _$VerificationLimitsCopyWithImpl<VerificationLimits>(this as VerificationLimits, _$identity);

  /// Serializes this VerificationLimits to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerificationLimits&&(identical(other.buyLimit, buyLimit) || other.buyLimit == buyLimit)&&(identical(other.sellLimit, sellLimit) || other.sellLimit == sellLimit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,buyLimit,sellLimit);

@override
String toString() {
  return 'VerificationLimits(buyLimit: $buyLimit, sellLimit: $sellLimit)';
}


}

/// @nodoc
abstract mixin class $VerificationLimitsCopyWith<$Res>  {
  factory $VerificationLimitsCopyWith(VerificationLimits value, $Res Function(VerificationLimits) _then) = _$VerificationLimitsCopyWithImpl;
@useResult
$Res call({
 int buyLimit, int sellLimit
});




}
/// @nodoc
class _$VerificationLimitsCopyWithImpl<$Res>
    implements $VerificationLimitsCopyWith<$Res> {
  _$VerificationLimitsCopyWithImpl(this._self, this._then);

  final VerificationLimits _self;
  final $Res Function(VerificationLimits) _then;

/// Create a copy of VerificationLimits
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? buyLimit = null,Object? sellLimit = null,}) {
  return _then(_self.copyWith(
buyLimit: null == buyLimit ? _self.buyLimit : buyLimit // ignore: cast_nullable_to_non_nullable
as int,sellLimit: null == sellLimit ? _self.sellLimit : sellLimit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [VerificationLimits].
extension VerificationLimitsPatterns on VerificationLimits {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerificationLimits value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerificationLimits() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerificationLimits value)  $default,){
final _that = this;
switch (_that) {
case _VerificationLimits():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerificationLimits value)?  $default,){
final _that = this;
switch (_that) {
case _VerificationLimits() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int buyLimit,  int sellLimit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerificationLimits() when $default != null:
return $default(_that.buyLimit,_that.sellLimit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int buyLimit,  int sellLimit)  $default,) {final _that = this;
switch (_that) {
case _VerificationLimits():
return $default(_that.buyLimit,_that.sellLimit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int buyLimit,  int sellLimit)?  $default,) {final _that = this;
switch (_that) {
case _VerificationLimits() when $default != null:
return $default(_that.buyLimit,_that.sellLimit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerificationLimits implements VerificationLimits {
  const _VerificationLimits({required this.buyLimit, required this.sellLimit});
  factory _VerificationLimits.fromJson(Map<String, dynamic> json) => _$VerificationLimitsFromJson(json);

@override final  int buyLimit;
@override final  int sellLimit;

/// Create a copy of VerificationLimits
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerificationLimitsCopyWith<_VerificationLimits> get copyWith => __$VerificationLimitsCopyWithImpl<_VerificationLimits>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerificationLimitsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerificationLimits&&(identical(other.buyLimit, buyLimit) || other.buyLimit == buyLimit)&&(identical(other.sellLimit, sellLimit) || other.sellLimit == sellLimit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,buyLimit,sellLimit);

@override
String toString() {
  return 'VerificationLimits(buyLimit: $buyLimit, sellLimit: $sellLimit)';
}


}

/// @nodoc
abstract mixin class _$VerificationLimitsCopyWith<$Res> implements $VerificationLimitsCopyWith<$Res> {
  factory _$VerificationLimitsCopyWith(_VerificationLimits value, $Res Function(_VerificationLimits) _then) = __$VerificationLimitsCopyWithImpl;
@override @useResult
$Res call({
 int buyLimit, int sellLimit
});




}
/// @nodoc
class __$VerificationLimitsCopyWithImpl<$Res>
    implements _$VerificationLimitsCopyWith<$Res> {
  __$VerificationLimitsCopyWithImpl(this._self, this._then);

  final _VerificationLimits _self;
  final $Res Function(_VerificationLimits) _then;

/// Create a copy of VerificationLimits
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? buyLimit = null,Object? sellLimit = null,}) {
  return _then(_VerificationLimits(
buyLimit: null == buyLimit ? _self.buyLimit : buyLimit // ignore: cast_nullable_to_non_nullable
as int,sellLimit: null == sellLimit ? _self.sellLimit : sellLimit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$UserModel {

 String get id; String get email; String get fullName; String? get firstName; String? get middleName; String? get lastName; DateTime? get dateOfBirth; String? get gender; String? get phoneNumber; String? get password; String? get street; String? get barangay; String? get city; String? get province; String? get zipCode; String? get nationality; bool get termsAccepted; bool get privacyAccepted; String get kycStatus; String? get rejectionReason; String get accountType; DateTime get createdAt; bool get verifiedBadge; KycModel? get kycData; VerificationLevel get verificationLevel; VerificationLimits? get verificationLimits; ProofOfAddress? get proofOfAddress; String? get tin; NbiClearance? get nbiClearance; BackgroundCheckStatus get backgroundCheckStatus; AccountStatus get accountStatus; int get otpFailureCount; DateTime? get lastOtpAttempt;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.middleName, middleName) || other.middleName == middleName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.password, password) || other.password == password)&&(identical(other.street, street) || other.street == street)&&(identical(other.barangay, barangay) || other.barangay == barangay)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.zipCode, zipCode) || other.zipCode == zipCode)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.termsAccepted, termsAccepted) || other.termsAccepted == termsAccepted)&&(identical(other.privacyAccepted, privacyAccepted) || other.privacyAccepted == privacyAccepted)&&(identical(other.kycStatus, kycStatus) || other.kycStatus == kycStatus)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.accountType, accountType) || other.accountType == accountType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.verifiedBadge, verifiedBadge) || other.verifiedBadge == verifiedBadge)&&(identical(other.kycData, kycData) || other.kycData == kycData)&&(identical(other.verificationLevel, verificationLevel) || other.verificationLevel == verificationLevel)&&(identical(other.verificationLimits, verificationLimits) || other.verificationLimits == verificationLimits)&&(identical(other.proofOfAddress, proofOfAddress) || other.proofOfAddress == proofOfAddress)&&(identical(other.tin, tin) || other.tin == tin)&&(identical(other.nbiClearance, nbiClearance) || other.nbiClearance == nbiClearance)&&(identical(other.backgroundCheckStatus, backgroundCheckStatus) || other.backgroundCheckStatus == backgroundCheckStatus)&&(identical(other.accountStatus, accountStatus) || other.accountStatus == accountStatus)&&(identical(other.otpFailureCount, otpFailureCount) || other.otpFailureCount == otpFailureCount)&&(identical(other.lastOtpAttempt, lastOtpAttempt) || other.lastOtpAttempt == lastOtpAttempt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,email,fullName,firstName,middleName,lastName,dateOfBirth,gender,phoneNumber,password,street,barangay,city,province,zipCode,nationality,termsAccepted,privacyAccepted,kycStatus,rejectionReason,accountType,createdAt,verifiedBadge,kycData,verificationLevel,verificationLimits,proofOfAddress,tin,nbiClearance,backgroundCheckStatus,accountStatus,otpFailureCount,lastOtpAttempt]);

@override
String toString() {
  return 'UserModel(id: $id, email: $email, fullName: $fullName, firstName: $firstName, middleName: $middleName, lastName: $lastName, dateOfBirth: $dateOfBirth, gender: $gender, phoneNumber: $phoneNumber, password: $password, street: $street, barangay: $barangay, city: $city, province: $province, zipCode: $zipCode, nationality: $nationality, termsAccepted: $termsAccepted, privacyAccepted: $privacyAccepted, kycStatus: $kycStatus, rejectionReason: $rejectionReason, accountType: $accountType, createdAt: $createdAt, verifiedBadge: $verifiedBadge, kycData: $kycData, verificationLevel: $verificationLevel, verificationLimits: $verificationLimits, proofOfAddress: $proofOfAddress, tin: $tin, nbiClearance: $nbiClearance, backgroundCheckStatus: $backgroundCheckStatus, accountStatus: $accountStatus, otpFailureCount: $otpFailureCount, lastOtpAttempt: $lastOtpAttempt)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String id, String email, String fullName, String? firstName, String? middleName, String? lastName, DateTime? dateOfBirth, String? gender, String? phoneNumber, String? password, String? street, String? barangay, String? city, String? province, String? zipCode, String? nationality, bool termsAccepted, bool privacyAccepted, String kycStatus, String? rejectionReason, String accountType, DateTime createdAt, bool verifiedBadge, KycModel? kycData, VerificationLevel verificationLevel, VerificationLimits? verificationLimits, ProofOfAddress? proofOfAddress, String? tin, NbiClearance? nbiClearance, BackgroundCheckStatus backgroundCheckStatus, AccountStatus accountStatus, int otpFailureCount, DateTime? lastOtpAttempt
});


$KycModelCopyWith<$Res>? get kycData;$VerificationLimitsCopyWith<$Res>? get verificationLimits;$ProofOfAddressCopyWith<$Res>? get proofOfAddress;$NbiClearanceCopyWith<$Res>? get nbiClearance;

}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? fullName = null,Object? firstName = freezed,Object? middleName = freezed,Object? lastName = freezed,Object? dateOfBirth = freezed,Object? gender = freezed,Object? phoneNumber = freezed,Object? password = freezed,Object? street = freezed,Object? barangay = freezed,Object? city = freezed,Object? province = freezed,Object? zipCode = freezed,Object? nationality = freezed,Object? termsAccepted = null,Object? privacyAccepted = null,Object? kycStatus = null,Object? rejectionReason = freezed,Object? accountType = null,Object? createdAt = null,Object? verifiedBadge = null,Object? kycData = freezed,Object? verificationLevel = null,Object? verificationLimits = freezed,Object? proofOfAddress = freezed,Object? tin = freezed,Object? nbiClearance = freezed,Object? backgroundCheckStatus = null,Object? accountStatus = null,Object? otpFailureCount = null,Object? lastOtpAttempt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,middleName: freezed == middleName ? _self.middleName : middleName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,street: freezed == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String?,barangay: freezed == barangay ? _self.barangay : barangay // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,province: freezed == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String?,zipCode: freezed == zipCode ? _self.zipCode : zipCode // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,termsAccepted: null == termsAccepted ? _self.termsAccepted : termsAccepted // ignore: cast_nullable_to_non_nullable
as bool,privacyAccepted: null == privacyAccepted ? _self.privacyAccepted : privacyAccepted // ignore: cast_nullable_to_non_nullable
as bool,kycStatus: null == kycStatus ? _self.kycStatus : kycStatus // ignore: cast_nullable_to_non_nullable
as String,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,accountType: null == accountType ? _self.accountType : accountType // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,verifiedBadge: null == verifiedBadge ? _self.verifiedBadge : verifiedBadge // ignore: cast_nullable_to_non_nullable
as bool,kycData: freezed == kycData ? _self.kycData : kycData // ignore: cast_nullable_to_non_nullable
as KycModel?,verificationLevel: null == verificationLevel ? _self.verificationLevel : verificationLevel // ignore: cast_nullable_to_non_nullable
as VerificationLevel,verificationLimits: freezed == verificationLimits ? _self.verificationLimits : verificationLimits // ignore: cast_nullable_to_non_nullable
as VerificationLimits?,proofOfAddress: freezed == proofOfAddress ? _self.proofOfAddress : proofOfAddress // ignore: cast_nullable_to_non_nullable
as ProofOfAddress?,tin: freezed == tin ? _self.tin : tin // ignore: cast_nullable_to_non_nullable
as String?,nbiClearance: freezed == nbiClearance ? _self.nbiClearance : nbiClearance // ignore: cast_nullable_to_non_nullable
as NbiClearance?,backgroundCheckStatus: null == backgroundCheckStatus ? _self.backgroundCheckStatus : backgroundCheckStatus // ignore: cast_nullable_to_non_nullable
as BackgroundCheckStatus,accountStatus: null == accountStatus ? _self.accountStatus : accountStatus // ignore: cast_nullable_to_non_nullable
as AccountStatus,otpFailureCount: null == otpFailureCount ? _self.otpFailureCount : otpFailureCount // ignore: cast_nullable_to_non_nullable
as int,lastOtpAttempt: freezed == lastOtpAttempt ? _self.lastOtpAttempt : lastOtpAttempt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KycModelCopyWith<$Res>? get kycData {
    if (_self.kycData == null) {
    return null;
  }

  return $KycModelCopyWith<$Res>(_self.kycData!, (value) {
    return _then(_self.copyWith(kycData: value));
  });
}/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerificationLimitsCopyWith<$Res>? get verificationLimits {
    if (_self.verificationLimits == null) {
    return null;
  }

  return $VerificationLimitsCopyWith<$Res>(_self.verificationLimits!, (value) {
    return _then(_self.copyWith(verificationLimits: value));
  });
}/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProofOfAddressCopyWith<$Res>? get proofOfAddress {
    if (_self.proofOfAddress == null) {
    return null;
  }

  return $ProofOfAddressCopyWith<$Res>(_self.proofOfAddress!, (value) {
    return _then(_self.copyWith(proofOfAddress: value));
  });
}/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NbiClearanceCopyWith<$Res>? get nbiClearance {
    if (_self.nbiClearance == null) {
    return null;
  }

  return $NbiClearanceCopyWith<$Res>(_self.nbiClearance!, (value) {
    return _then(_self.copyWith(nbiClearance: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String fullName,  String? firstName,  String? middleName,  String? lastName,  DateTime? dateOfBirth,  String? gender,  String? phoneNumber,  String? password,  String? street,  String? barangay,  String? city,  String? province,  String? zipCode,  String? nationality,  bool termsAccepted,  bool privacyAccepted,  String kycStatus,  String? rejectionReason,  String accountType,  DateTime createdAt,  bool verifiedBadge,  KycModel? kycData,  VerificationLevel verificationLevel,  VerificationLimits? verificationLimits,  ProofOfAddress? proofOfAddress,  String? tin,  NbiClearance? nbiClearance,  BackgroundCheckStatus backgroundCheckStatus,  AccountStatus accountStatus,  int otpFailureCount,  DateTime? lastOtpAttempt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.email,_that.fullName,_that.firstName,_that.middleName,_that.lastName,_that.dateOfBirth,_that.gender,_that.phoneNumber,_that.password,_that.street,_that.barangay,_that.city,_that.province,_that.zipCode,_that.nationality,_that.termsAccepted,_that.privacyAccepted,_that.kycStatus,_that.rejectionReason,_that.accountType,_that.createdAt,_that.verifiedBadge,_that.kycData,_that.verificationLevel,_that.verificationLimits,_that.proofOfAddress,_that.tin,_that.nbiClearance,_that.backgroundCheckStatus,_that.accountStatus,_that.otpFailureCount,_that.lastOtpAttempt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String fullName,  String? firstName,  String? middleName,  String? lastName,  DateTime? dateOfBirth,  String? gender,  String? phoneNumber,  String? password,  String? street,  String? barangay,  String? city,  String? province,  String? zipCode,  String? nationality,  bool termsAccepted,  bool privacyAccepted,  String kycStatus,  String? rejectionReason,  String accountType,  DateTime createdAt,  bool verifiedBadge,  KycModel? kycData,  VerificationLevel verificationLevel,  VerificationLimits? verificationLimits,  ProofOfAddress? proofOfAddress,  String? tin,  NbiClearance? nbiClearance,  BackgroundCheckStatus backgroundCheckStatus,  AccountStatus accountStatus,  int otpFailureCount,  DateTime? lastOtpAttempt)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.id,_that.email,_that.fullName,_that.firstName,_that.middleName,_that.lastName,_that.dateOfBirth,_that.gender,_that.phoneNumber,_that.password,_that.street,_that.barangay,_that.city,_that.province,_that.zipCode,_that.nationality,_that.termsAccepted,_that.privacyAccepted,_that.kycStatus,_that.rejectionReason,_that.accountType,_that.createdAt,_that.verifiedBadge,_that.kycData,_that.verificationLevel,_that.verificationLimits,_that.proofOfAddress,_that.tin,_that.nbiClearance,_that.backgroundCheckStatus,_that.accountStatus,_that.otpFailureCount,_that.lastOtpAttempt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String fullName,  String? firstName,  String? middleName,  String? lastName,  DateTime? dateOfBirth,  String? gender,  String? phoneNumber,  String? password,  String? street,  String? barangay,  String? city,  String? province,  String? zipCode,  String? nationality,  bool termsAccepted,  bool privacyAccepted,  String kycStatus,  String? rejectionReason,  String accountType,  DateTime createdAt,  bool verifiedBadge,  KycModel? kycData,  VerificationLevel verificationLevel,  VerificationLimits? verificationLimits,  ProofOfAddress? proofOfAddress,  String? tin,  NbiClearance? nbiClearance,  BackgroundCheckStatus backgroundCheckStatus,  AccountStatus accountStatus,  int otpFailureCount,  DateTime? lastOtpAttempt)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.email,_that.fullName,_that.firstName,_that.middleName,_that.lastName,_that.dateOfBirth,_that.gender,_that.phoneNumber,_that.password,_that.street,_that.barangay,_that.city,_that.province,_that.zipCode,_that.nationality,_that.termsAccepted,_that.privacyAccepted,_that.kycStatus,_that.rejectionReason,_that.accountType,_that.createdAt,_that.verifiedBadge,_that.kycData,_that.verificationLevel,_that.verificationLimits,_that.proofOfAddress,_that.tin,_that.nbiClearance,_that.backgroundCheckStatus,_that.accountStatus,_that.otpFailureCount,_that.lastOtpAttempt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserModel implements UserModel {
  const _UserModel({required this.id, required this.email, required this.fullName, this.firstName, this.middleName, this.lastName, this.dateOfBirth, this.gender, this.phoneNumber, this.password, this.street, this.barangay, this.city, this.province, this.zipCode, this.nationality, this.termsAccepted = false, this.privacyAccepted = false, this.kycStatus = 'pending', this.rejectionReason, this.accountType = 'individual', required this.createdAt, this.verifiedBadge = false, this.kycData, this.verificationLevel = VerificationLevel.unverified, this.verificationLimits, this.proofOfAddress, this.tin, this.nbiClearance, this.backgroundCheckStatus = BackgroundCheckStatus.none, this.accountStatus = AccountStatus.guest, this.otpFailureCount = 0, this.lastOtpAttempt});
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override final  String id;
@override final  String email;
@override final  String fullName;
@override final  String? firstName;
@override final  String? middleName;
@override final  String? lastName;
@override final  DateTime? dateOfBirth;
@override final  String? gender;
@override final  String? phoneNumber;
@override final  String? password;
@override final  String? street;
@override final  String? barangay;
@override final  String? city;
@override final  String? province;
@override final  String? zipCode;
@override final  String? nationality;
@override@JsonKey() final  bool termsAccepted;
@override@JsonKey() final  bool privacyAccepted;
@override@JsonKey() final  String kycStatus;
@override final  String? rejectionReason;
@override@JsonKey() final  String accountType;
@override final  DateTime createdAt;
@override@JsonKey() final  bool verifiedBadge;
@override final  KycModel? kycData;
@override@JsonKey() final  VerificationLevel verificationLevel;
@override final  VerificationLimits? verificationLimits;
@override final  ProofOfAddress? proofOfAddress;
@override final  String? tin;
@override final  NbiClearance? nbiClearance;
@override@JsonKey() final  BackgroundCheckStatus backgroundCheckStatus;
@override@JsonKey() final  AccountStatus accountStatus;
@override@JsonKey() final  int otpFailureCount;
@override final  DateTime? lastOtpAttempt;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.middleName, middleName) || other.middleName == middleName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.password, password) || other.password == password)&&(identical(other.street, street) || other.street == street)&&(identical(other.barangay, barangay) || other.barangay == barangay)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.zipCode, zipCode) || other.zipCode == zipCode)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.termsAccepted, termsAccepted) || other.termsAccepted == termsAccepted)&&(identical(other.privacyAccepted, privacyAccepted) || other.privacyAccepted == privacyAccepted)&&(identical(other.kycStatus, kycStatus) || other.kycStatus == kycStatus)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.accountType, accountType) || other.accountType == accountType)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.verifiedBadge, verifiedBadge) || other.verifiedBadge == verifiedBadge)&&(identical(other.kycData, kycData) || other.kycData == kycData)&&(identical(other.verificationLevel, verificationLevel) || other.verificationLevel == verificationLevel)&&(identical(other.verificationLimits, verificationLimits) || other.verificationLimits == verificationLimits)&&(identical(other.proofOfAddress, proofOfAddress) || other.proofOfAddress == proofOfAddress)&&(identical(other.tin, tin) || other.tin == tin)&&(identical(other.nbiClearance, nbiClearance) || other.nbiClearance == nbiClearance)&&(identical(other.backgroundCheckStatus, backgroundCheckStatus) || other.backgroundCheckStatus == backgroundCheckStatus)&&(identical(other.accountStatus, accountStatus) || other.accountStatus == accountStatus)&&(identical(other.otpFailureCount, otpFailureCount) || other.otpFailureCount == otpFailureCount)&&(identical(other.lastOtpAttempt, lastOtpAttempt) || other.lastOtpAttempt == lastOtpAttempt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,email,fullName,firstName,middleName,lastName,dateOfBirth,gender,phoneNumber,password,street,barangay,city,province,zipCode,nationality,termsAccepted,privacyAccepted,kycStatus,rejectionReason,accountType,createdAt,verifiedBadge,kycData,verificationLevel,verificationLimits,proofOfAddress,tin,nbiClearance,backgroundCheckStatus,accountStatus,otpFailureCount,lastOtpAttempt]);

@override
String toString() {
  return 'UserModel(id: $id, email: $email, fullName: $fullName, firstName: $firstName, middleName: $middleName, lastName: $lastName, dateOfBirth: $dateOfBirth, gender: $gender, phoneNumber: $phoneNumber, password: $password, street: $street, barangay: $barangay, city: $city, province: $province, zipCode: $zipCode, nationality: $nationality, termsAccepted: $termsAccepted, privacyAccepted: $privacyAccepted, kycStatus: $kycStatus, rejectionReason: $rejectionReason, accountType: $accountType, createdAt: $createdAt, verifiedBadge: $verifiedBadge, kycData: $kycData, verificationLevel: $verificationLevel, verificationLimits: $verificationLimits, proofOfAddress: $proofOfAddress, tin: $tin, nbiClearance: $nbiClearance, backgroundCheckStatus: $backgroundCheckStatus, accountStatus: $accountStatus, otpFailureCount: $otpFailureCount, lastOtpAttempt: $lastOtpAttempt)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String fullName, String? firstName, String? middleName, String? lastName, DateTime? dateOfBirth, String? gender, String? phoneNumber, String? password, String? street, String? barangay, String? city, String? province, String? zipCode, String? nationality, bool termsAccepted, bool privacyAccepted, String kycStatus, String? rejectionReason, String accountType, DateTime createdAt, bool verifiedBadge, KycModel? kycData, VerificationLevel verificationLevel, VerificationLimits? verificationLimits, ProofOfAddress? proofOfAddress, String? tin, NbiClearance? nbiClearance, BackgroundCheckStatus backgroundCheckStatus, AccountStatus accountStatus, int otpFailureCount, DateTime? lastOtpAttempt
});


@override $KycModelCopyWith<$Res>? get kycData;@override $VerificationLimitsCopyWith<$Res>? get verificationLimits;@override $ProofOfAddressCopyWith<$Res>? get proofOfAddress;@override $NbiClearanceCopyWith<$Res>? get nbiClearance;

}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? fullName = null,Object? firstName = freezed,Object? middleName = freezed,Object? lastName = freezed,Object? dateOfBirth = freezed,Object? gender = freezed,Object? phoneNumber = freezed,Object? password = freezed,Object? street = freezed,Object? barangay = freezed,Object? city = freezed,Object? province = freezed,Object? zipCode = freezed,Object? nationality = freezed,Object? termsAccepted = null,Object? privacyAccepted = null,Object? kycStatus = null,Object? rejectionReason = freezed,Object? accountType = null,Object? createdAt = null,Object? verifiedBadge = null,Object? kycData = freezed,Object? verificationLevel = null,Object? verificationLimits = freezed,Object? proofOfAddress = freezed,Object? tin = freezed,Object? nbiClearance = freezed,Object? backgroundCheckStatus = null,Object? accountStatus = null,Object? otpFailureCount = null,Object? lastOtpAttempt = freezed,}) {
  return _then(_UserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,middleName: freezed == middleName ? _self.middleName : middleName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,street: freezed == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String?,barangay: freezed == barangay ? _self.barangay : barangay // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,province: freezed == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String?,zipCode: freezed == zipCode ? _self.zipCode : zipCode // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,termsAccepted: null == termsAccepted ? _self.termsAccepted : termsAccepted // ignore: cast_nullable_to_non_nullable
as bool,privacyAccepted: null == privacyAccepted ? _self.privacyAccepted : privacyAccepted // ignore: cast_nullable_to_non_nullable
as bool,kycStatus: null == kycStatus ? _self.kycStatus : kycStatus // ignore: cast_nullable_to_non_nullable
as String,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,accountType: null == accountType ? _self.accountType : accountType // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,verifiedBadge: null == verifiedBadge ? _self.verifiedBadge : verifiedBadge // ignore: cast_nullable_to_non_nullable
as bool,kycData: freezed == kycData ? _self.kycData : kycData // ignore: cast_nullable_to_non_nullable
as KycModel?,verificationLevel: null == verificationLevel ? _self.verificationLevel : verificationLevel // ignore: cast_nullable_to_non_nullable
as VerificationLevel,verificationLimits: freezed == verificationLimits ? _self.verificationLimits : verificationLimits // ignore: cast_nullable_to_non_nullable
as VerificationLimits?,proofOfAddress: freezed == proofOfAddress ? _self.proofOfAddress : proofOfAddress // ignore: cast_nullable_to_non_nullable
as ProofOfAddress?,tin: freezed == tin ? _self.tin : tin // ignore: cast_nullable_to_non_nullable
as String?,nbiClearance: freezed == nbiClearance ? _self.nbiClearance : nbiClearance // ignore: cast_nullable_to_non_nullable
as NbiClearance?,backgroundCheckStatus: null == backgroundCheckStatus ? _self.backgroundCheckStatus : backgroundCheckStatus // ignore: cast_nullable_to_non_nullable
as BackgroundCheckStatus,accountStatus: null == accountStatus ? _self.accountStatus : accountStatus // ignore: cast_nullable_to_non_nullable
as AccountStatus,otpFailureCount: null == otpFailureCount ? _self.otpFailureCount : otpFailureCount // ignore: cast_nullable_to_non_nullable
as int,lastOtpAttempt: freezed == lastOtpAttempt ? _self.lastOtpAttempt : lastOtpAttempt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KycModelCopyWith<$Res>? get kycData {
    if (_self.kycData == null) {
    return null;
  }

  return $KycModelCopyWith<$Res>(_self.kycData!, (value) {
    return _then(_self.copyWith(kycData: value));
  });
}/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerificationLimitsCopyWith<$Res>? get verificationLimits {
    if (_self.verificationLimits == null) {
    return null;
  }

  return $VerificationLimitsCopyWith<$Res>(_self.verificationLimits!, (value) {
    return _then(_self.copyWith(verificationLimits: value));
  });
}/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProofOfAddressCopyWith<$Res>? get proofOfAddress {
    if (_self.proofOfAddress == null) {
    return null;
  }

  return $ProofOfAddressCopyWith<$Res>(_self.proofOfAddress!, (value) {
    return _then(_self.copyWith(proofOfAddress: value));
  });
}/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NbiClearanceCopyWith<$Res>? get nbiClearance {
    if (_self.nbiClearance == null) {
    return null;
  }

  return $NbiClearanceCopyWith<$Res>(_self.nbiClearance!, (value) {
    return _then(_self.copyWith(nbiClearance: value));
  });
}
}

// dart format on
