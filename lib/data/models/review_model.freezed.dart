// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CategoryRating {

 double get communication; double get accuracy; double get condition; double get process;
/// Create a copy of CategoryRating
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryRatingCopyWith<CategoryRating> get copyWith => _$CategoryRatingCopyWithImpl<CategoryRating>(this as CategoryRating, _$identity);

  /// Serializes this CategoryRating to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryRating&&(identical(other.communication, communication) || other.communication == communication)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.process, process) || other.process == process));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,communication,accuracy,condition,process);

@override
String toString() {
  return 'CategoryRating(communication: $communication, accuracy: $accuracy, condition: $condition, process: $process)';
}


}

/// @nodoc
abstract mixin class $CategoryRatingCopyWith<$Res>  {
  factory $CategoryRatingCopyWith(CategoryRating value, $Res Function(CategoryRating) _then) = _$CategoryRatingCopyWithImpl;
@useResult
$Res call({
 double communication, double accuracy, double condition, double process
});




}
/// @nodoc
class _$CategoryRatingCopyWithImpl<$Res>
    implements $CategoryRatingCopyWith<$Res> {
  _$CategoryRatingCopyWithImpl(this._self, this._then);

  final CategoryRating _self;
  final $Res Function(CategoryRating) _then;

/// Create a copy of CategoryRating
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? communication = null,Object? accuracy = null,Object? condition = null,Object? process = null,}) {
  return _then(_self.copyWith(
communication: null == communication ? _self.communication : communication // ignore: cast_nullable_to_non_nullable
as double,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as double,process: null == process ? _self.process : process // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryRating].
extension CategoryRatingPatterns on CategoryRating {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryRating value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryRating() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryRating value)  $default,){
final _that = this;
switch (_that) {
case _CategoryRating():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryRating value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryRating() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double communication,  double accuracy,  double condition,  double process)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryRating() when $default != null:
return $default(_that.communication,_that.accuracy,_that.condition,_that.process);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double communication,  double accuracy,  double condition,  double process)  $default,) {final _that = this;
switch (_that) {
case _CategoryRating():
return $default(_that.communication,_that.accuracy,_that.condition,_that.process);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double communication,  double accuracy,  double condition,  double process)?  $default,) {final _that = this;
switch (_that) {
case _CategoryRating() when $default != null:
return $default(_that.communication,_that.accuracy,_that.condition,_that.process);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategoryRating implements CategoryRating {
  const _CategoryRating({required this.communication, required this.accuracy, required this.condition, required this.process});
  factory _CategoryRating.fromJson(Map<String, dynamic> json) => _$CategoryRatingFromJson(json);

@override final  double communication;
@override final  double accuracy;
@override final  double condition;
@override final  double process;

/// Create a copy of CategoryRating
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryRatingCopyWith<_CategoryRating> get copyWith => __$CategoryRatingCopyWithImpl<_CategoryRating>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryRatingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryRating&&(identical(other.communication, communication) || other.communication == communication)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.process, process) || other.process == process));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,communication,accuracy,condition,process);

@override
String toString() {
  return 'CategoryRating(communication: $communication, accuracy: $accuracy, condition: $condition, process: $process)';
}


}

/// @nodoc
abstract mixin class _$CategoryRatingCopyWith<$Res> implements $CategoryRatingCopyWith<$Res> {
  factory _$CategoryRatingCopyWith(_CategoryRating value, $Res Function(_CategoryRating) _then) = __$CategoryRatingCopyWithImpl;
@override @useResult
$Res call({
 double communication, double accuracy, double condition, double process
});




}
/// @nodoc
class __$CategoryRatingCopyWithImpl<$Res>
    implements _$CategoryRatingCopyWith<$Res> {
  __$CategoryRatingCopyWithImpl(this._self, this._then);

  final _CategoryRating _self;
  final $Res Function(_CategoryRating) _then;

/// Create a copy of CategoryRating
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? communication = null,Object? accuracy = null,Object? condition = null,Object? process = null,}) {
  return _then(_CategoryRating(
communication: null == communication ? _self.communication : communication // ignore: cast_nullable_to_non_nullable
as double,accuracy: null == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as double,process: null == process ? _self.process : process // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ReviewModel {

 String get id; String get transactionId; String get buyerId; String get sellerId; double get overallRating; CategoryRating get categoryRatings; String? get comment; bool get isAnonymous; DateTime get createdAt; String? get sellerResponse; DateTime? get sellerRespondedAt; bool get isFlagged; String? get flagReason;
/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewModelCopyWith<ReviewModel> get copyWith => _$ReviewModelCopyWithImpl<ReviewModel>(this as ReviewModel, _$identity);

  /// Serializes this ReviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewModel&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.overallRating, overallRating) || other.overallRating == overallRating)&&(identical(other.categoryRatings, categoryRatings) || other.categoryRatings == categoryRatings)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.isAnonymous, isAnonymous) || other.isAnonymous == isAnonymous)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.sellerResponse, sellerResponse) || other.sellerResponse == sellerResponse)&&(identical(other.sellerRespondedAt, sellerRespondedAt) || other.sellerRespondedAt == sellerRespondedAt)&&(identical(other.isFlagged, isFlagged) || other.isFlagged == isFlagged)&&(identical(other.flagReason, flagReason) || other.flagReason == flagReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,transactionId,buyerId,sellerId,overallRating,categoryRatings,comment,isAnonymous,createdAt,sellerResponse,sellerRespondedAt,isFlagged,flagReason);

@override
String toString() {
  return 'ReviewModel(id: $id, transactionId: $transactionId, buyerId: $buyerId, sellerId: $sellerId, overallRating: $overallRating, categoryRatings: $categoryRatings, comment: $comment, isAnonymous: $isAnonymous, createdAt: $createdAt, sellerResponse: $sellerResponse, sellerRespondedAt: $sellerRespondedAt, isFlagged: $isFlagged, flagReason: $flagReason)';
}


}

/// @nodoc
abstract mixin class $ReviewModelCopyWith<$Res>  {
  factory $ReviewModelCopyWith(ReviewModel value, $Res Function(ReviewModel) _then) = _$ReviewModelCopyWithImpl;
@useResult
$Res call({
 String id, String transactionId, String buyerId, String sellerId, double overallRating, CategoryRating categoryRatings, String? comment, bool isAnonymous, DateTime createdAt, String? sellerResponse, DateTime? sellerRespondedAt, bool isFlagged, String? flagReason
});


$CategoryRatingCopyWith<$Res> get categoryRatings;

}
/// @nodoc
class _$ReviewModelCopyWithImpl<$Res>
    implements $ReviewModelCopyWith<$Res> {
  _$ReviewModelCopyWithImpl(this._self, this._then);

  final ReviewModel _self;
  final $Res Function(ReviewModel) _then;

/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? transactionId = null,Object? buyerId = null,Object? sellerId = null,Object? overallRating = null,Object? categoryRatings = null,Object? comment = freezed,Object? isAnonymous = null,Object? createdAt = null,Object? sellerResponse = freezed,Object? sellerRespondedAt = freezed,Object? isFlagged = null,Object? flagReason = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,buyerId: null == buyerId ? _self.buyerId : buyerId // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,overallRating: null == overallRating ? _self.overallRating : overallRating // ignore: cast_nullable_to_non_nullable
as double,categoryRatings: null == categoryRatings ? _self.categoryRatings : categoryRatings // ignore: cast_nullable_to_non_nullable
as CategoryRating,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,isAnonymous: null == isAnonymous ? _self.isAnonymous : isAnonymous // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,sellerResponse: freezed == sellerResponse ? _self.sellerResponse : sellerResponse // ignore: cast_nullable_to_non_nullable
as String?,sellerRespondedAt: freezed == sellerRespondedAt ? _self.sellerRespondedAt : sellerRespondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isFlagged: null == isFlagged ? _self.isFlagged : isFlagged // ignore: cast_nullable_to_non_nullable
as bool,flagReason: freezed == flagReason ? _self.flagReason : flagReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryRatingCopyWith<$Res> get categoryRatings {
  
  return $CategoryRatingCopyWith<$Res>(_self.categoryRatings, (value) {
    return _then(_self.copyWith(categoryRatings: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReviewModel].
extension ReviewModelPatterns on ReviewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewModel value)  $default,){
final _that = this;
switch (_that) {
case _ReviewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String transactionId,  String buyerId,  String sellerId,  double overallRating,  CategoryRating categoryRatings,  String? comment,  bool isAnonymous,  DateTime createdAt,  String? sellerResponse,  DateTime? sellerRespondedAt,  bool isFlagged,  String? flagReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
return $default(_that.id,_that.transactionId,_that.buyerId,_that.sellerId,_that.overallRating,_that.categoryRatings,_that.comment,_that.isAnonymous,_that.createdAt,_that.sellerResponse,_that.sellerRespondedAt,_that.isFlagged,_that.flagReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String transactionId,  String buyerId,  String sellerId,  double overallRating,  CategoryRating categoryRatings,  String? comment,  bool isAnonymous,  DateTime createdAt,  String? sellerResponse,  DateTime? sellerRespondedAt,  bool isFlagged,  String? flagReason)  $default,) {final _that = this;
switch (_that) {
case _ReviewModel():
return $default(_that.id,_that.transactionId,_that.buyerId,_that.sellerId,_that.overallRating,_that.categoryRatings,_that.comment,_that.isAnonymous,_that.createdAt,_that.sellerResponse,_that.sellerRespondedAt,_that.isFlagged,_that.flagReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String transactionId,  String buyerId,  String sellerId,  double overallRating,  CategoryRating categoryRatings,  String? comment,  bool isAnonymous,  DateTime createdAt,  String? sellerResponse,  DateTime? sellerRespondedAt,  bool isFlagged,  String? flagReason)?  $default,) {final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
return $default(_that.id,_that.transactionId,_that.buyerId,_that.sellerId,_that.overallRating,_that.categoryRatings,_that.comment,_that.isAnonymous,_that.createdAt,_that.sellerResponse,_that.sellerRespondedAt,_that.isFlagged,_that.flagReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReviewModel implements ReviewModel {
  const _ReviewModel({required this.id, required this.transactionId, required this.buyerId, required this.sellerId, required this.overallRating, required this.categoryRatings, this.comment, required this.isAnonymous, required this.createdAt, this.sellerResponse, this.sellerRespondedAt, this.isFlagged = false, this.flagReason});
  factory _ReviewModel.fromJson(Map<String, dynamic> json) => _$ReviewModelFromJson(json);

@override final  String id;
@override final  String transactionId;
@override final  String buyerId;
@override final  String sellerId;
@override final  double overallRating;
@override final  CategoryRating categoryRatings;
@override final  String? comment;
@override final  bool isAnonymous;
@override final  DateTime createdAt;
@override final  String? sellerResponse;
@override final  DateTime? sellerRespondedAt;
@override@JsonKey() final  bool isFlagged;
@override final  String? flagReason;

/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewModelCopyWith<_ReviewModel> get copyWith => __$ReviewModelCopyWithImpl<_ReviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewModel&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.buyerId, buyerId) || other.buyerId == buyerId)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.overallRating, overallRating) || other.overallRating == overallRating)&&(identical(other.categoryRatings, categoryRatings) || other.categoryRatings == categoryRatings)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.isAnonymous, isAnonymous) || other.isAnonymous == isAnonymous)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.sellerResponse, sellerResponse) || other.sellerResponse == sellerResponse)&&(identical(other.sellerRespondedAt, sellerRespondedAt) || other.sellerRespondedAt == sellerRespondedAt)&&(identical(other.isFlagged, isFlagged) || other.isFlagged == isFlagged)&&(identical(other.flagReason, flagReason) || other.flagReason == flagReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,transactionId,buyerId,sellerId,overallRating,categoryRatings,comment,isAnonymous,createdAt,sellerResponse,sellerRespondedAt,isFlagged,flagReason);

@override
String toString() {
  return 'ReviewModel(id: $id, transactionId: $transactionId, buyerId: $buyerId, sellerId: $sellerId, overallRating: $overallRating, categoryRatings: $categoryRatings, comment: $comment, isAnonymous: $isAnonymous, createdAt: $createdAt, sellerResponse: $sellerResponse, sellerRespondedAt: $sellerRespondedAt, isFlagged: $isFlagged, flagReason: $flagReason)';
}


}

/// @nodoc
abstract mixin class _$ReviewModelCopyWith<$Res> implements $ReviewModelCopyWith<$Res> {
  factory _$ReviewModelCopyWith(_ReviewModel value, $Res Function(_ReviewModel) _then) = __$ReviewModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String transactionId, String buyerId, String sellerId, double overallRating, CategoryRating categoryRatings, String? comment, bool isAnonymous, DateTime createdAt, String? sellerResponse, DateTime? sellerRespondedAt, bool isFlagged, String? flagReason
});


@override $CategoryRatingCopyWith<$Res> get categoryRatings;

}
/// @nodoc
class __$ReviewModelCopyWithImpl<$Res>
    implements _$ReviewModelCopyWith<$Res> {
  __$ReviewModelCopyWithImpl(this._self, this._then);

  final _ReviewModel _self;
  final $Res Function(_ReviewModel) _then;

/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? transactionId = null,Object? buyerId = null,Object? sellerId = null,Object? overallRating = null,Object? categoryRatings = null,Object? comment = freezed,Object? isAnonymous = null,Object? createdAt = null,Object? sellerResponse = freezed,Object? sellerRespondedAt = freezed,Object? isFlagged = null,Object? flagReason = freezed,}) {
  return _then(_ReviewModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,buyerId: null == buyerId ? _self.buyerId : buyerId // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,overallRating: null == overallRating ? _self.overallRating : overallRating // ignore: cast_nullable_to_non_nullable
as double,categoryRatings: null == categoryRatings ? _self.categoryRatings : categoryRatings // ignore: cast_nullable_to_non_nullable
as CategoryRating,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,isAnonymous: null == isAnonymous ? _self.isAnonymous : isAnonymous // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,sellerResponse: freezed == sellerResponse ? _self.sellerResponse : sellerResponse // ignore: cast_nullable_to_non_nullable
as String?,sellerRespondedAt: freezed == sellerRespondedAt ? _self.sellerRespondedAt : sellerRespondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isFlagged: null == isFlagged ? _self.isFlagged : isFlagged // ignore: cast_nullable_to_non_nullable
as bool,flagReason: freezed == flagReason ? _self.flagReason : flagReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryRatingCopyWith<$Res> get categoryRatings {
  
  return $CategoryRatingCopyWith<$Res>(_self.categoryRatings, (value) {
    return _then(_self.copyWith(categoryRatings: value));
  });
}
}

// dart format on
