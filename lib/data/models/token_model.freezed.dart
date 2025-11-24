// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenTransaction {

 String get id; String get userId; int get amount;// Positive = add, Negative = deduct
 TokenTransactionType get type; DateTime get createdAt; String? get relatedAuctionId;// For bid placement/refunds
 String? get relatedPurchaseId;// For token purchases
 String? get relatedSubscriptionId;// For subscription allocations
 String? get description; int? get balanceAfter;
/// Create a copy of TokenTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenTransactionCopyWith<TokenTransaction> get copyWith => _$TokenTransactionCopyWithImpl<TokenTransaction>(this as TokenTransaction, _$identity);

  /// Serializes this TokenTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.relatedAuctionId, relatedAuctionId) || other.relatedAuctionId == relatedAuctionId)&&(identical(other.relatedPurchaseId, relatedPurchaseId) || other.relatedPurchaseId == relatedPurchaseId)&&(identical(other.relatedSubscriptionId, relatedSubscriptionId) || other.relatedSubscriptionId == relatedSubscriptionId)&&(identical(other.description, description) || other.description == description)&&(identical(other.balanceAfter, balanceAfter) || other.balanceAfter == balanceAfter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,amount,type,createdAt,relatedAuctionId,relatedPurchaseId,relatedSubscriptionId,description,balanceAfter);

@override
String toString() {
  return 'TokenTransaction(id: $id, userId: $userId, amount: $amount, type: $type, createdAt: $createdAt, relatedAuctionId: $relatedAuctionId, relatedPurchaseId: $relatedPurchaseId, relatedSubscriptionId: $relatedSubscriptionId, description: $description, balanceAfter: $balanceAfter)';
}


}

/// @nodoc
abstract mixin class $TokenTransactionCopyWith<$Res>  {
  factory $TokenTransactionCopyWith(TokenTransaction value, $Res Function(TokenTransaction) _then) = _$TokenTransactionCopyWithImpl;
@useResult
$Res call({
 String id, String userId, int amount, TokenTransactionType type, DateTime createdAt, String? relatedAuctionId, String? relatedPurchaseId, String? relatedSubscriptionId, String? description, int? balanceAfter
});




}
/// @nodoc
class _$TokenTransactionCopyWithImpl<$Res>
    implements $TokenTransactionCopyWith<$Res> {
  _$TokenTransactionCopyWithImpl(this._self, this._then);

  final TokenTransaction _self;
  final $Res Function(TokenTransaction) _then;

/// Create a copy of TokenTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? amount = null,Object? type = null,Object? createdAt = null,Object? relatedAuctionId = freezed,Object? relatedPurchaseId = freezed,Object? relatedSubscriptionId = freezed,Object? description = freezed,Object? balanceAfter = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TokenTransactionType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,relatedAuctionId: freezed == relatedAuctionId ? _self.relatedAuctionId : relatedAuctionId // ignore: cast_nullable_to_non_nullable
as String?,relatedPurchaseId: freezed == relatedPurchaseId ? _self.relatedPurchaseId : relatedPurchaseId // ignore: cast_nullable_to_non_nullable
as String?,relatedSubscriptionId: freezed == relatedSubscriptionId ? _self.relatedSubscriptionId : relatedSubscriptionId // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,balanceAfter: freezed == balanceAfter ? _self.balanceAfter : balanceAfter // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TokenTransaction].
extension TokenTransactionPatterns on TokenTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenTransaction value)  $default,){
final _that = this;
switch (_that) {
case _TokenTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _TokenTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  int amount,  TokenTransactionType type,  DateTime createdAt,  String? relatedAuctionId,  String? relatedPurchaseId,  String? relatedSubscriptionId,  String? description,  int? balanceAfter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenTransaction() when $default != null:
return $default(_that.id,_that.userId,_that.amount,_that.type,_that.createdAt,_that.relatedAuctionId,_that.relatedPurchaseId,_that.relatedSubscriptionId,_that.description,_that.balanceAfter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  int amount,  TokenTransactionType type,  DateTime createdAt,  String? relatedAuctionId,  String? relatedPurchaseId,  String? relatedSubscriptionId,  String? description,  int? balanceAfter)  $default,) {final _that = this;
switch (_that) {
case _TokenTransaction():
return $default(_that.id,_that.userId,_that.amount,_that.type,_that.createdAt,_that.relatedAuctionId,_that.relatedPurchaseId,_that.relatedSubscriptionId,_that.description,_that.balanceAfter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  int amount,  TokenTransactionType type,  DateTime createdAt,  String? relatedAuctionId,  String? relatedPurchaseId,  String? relatedSubscriptionId,  String? description,  int? balanceAfter)?  $default,) {final _that = this;
switch (_that) {
case _TokenTransaction() when $default != null:
return $default(_that.id,_that.userId,_that.amount,_that.type,_that.createdAt,_that.relatedAuctionId,_that.relatedPurchaseId,_that.relatedSubscriptionId,_that.description,_that.balanceAfter);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TokenTransaction implements TokenTransaction {
  const _TokenTransaction({required this.id, required this.userId, required this.amount, required this.type, required this.createdAt, this.relatedAuctionId, this.relatedPurchaseId, this.relatedSubscriptionId, this.description, this.balanceAfter});
  factory _TokenTransaction.fromJson(Map<String, dynamic> json) => _$TokenTransactionFromJson(json);

@override final  String id;
@override final  String userId;
@override final  int amount;
// Positive = add, Negative = deduct
@override final  TokenTransactionType type;
@override final  DateTime createdAt;
@override final  String? relatedAuctionId;
// For bid placement/refunds
@override final  String? relatedPurchaseId;
// For token purchases
@override final  String? relatedSubscriptionId;
// For subscription allocations
@override final  String? description;
@override final  int? balanceAfter;

/// Create a copy of TokenTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenTransactionCopyWith<_TokenTransaction> get copyWith => __$TokenTransactionCopyWithImpl<_TokenTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokenTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.relatedAuctionId, relatedAuctionId) || other.relatedAuctionId == relatedAuctionId)&&(identical(other.relatedPurchaseId, relatedPurchaseId) || other.relatedPurchaseId == relatedPurchaseId)&&(identical(other.relatedSubscriptionId, relatedSubscriptionId) || other.relatedSubscriptionId == relatedSubscriptionId)&&(identical(other.description, description) || other.description == description)&&(identical(other.balanceAfter, balanceAfter) || other.balanceAfter == balanceAfter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,amount,type,createdAt,relatedAuctionId,relatedPurchaseId,relatedSubscriptionId,description,balanceAfter);

@override
String toString() {
  return 'TokenTransaction(id: $id, userId: $userId, amount: $amount, type: $type, createdAt: $createdAt, relatedAuctionId: $relatedAuctionId, relatedPurchaseId: $relatedPurchaseId, relatedSubscriptionId: $relatedSubscriptionId, description: $description, balanceAfter: $balanceAfter)';
}


}

/// @nodoc
abstract mixin class _$TokenTransactionCopyWith<$Res> implements $TokenTransactionCopyWith<$Res> {
  factory _$TokenTransactionCopyWith(_TokenTransaction value, $Res Function(_TokenTransaction) _then) = __$TokenTransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, int amount, TokenTransactionType type, DateTime createdAt, String? relatedAuctionId, String? relatedPurchaseId, String? relatedSubscriptionId, String? description, int? balanceAfter
});




}
/// @nodoc
class __$TokenTransactionCopyWithImpl<$Res>
    implements _$TokenTransactionCopyWith<$Res> {
  __$TokenTransactionCopyWithImpl(this._self, this._then);

  final _TokenTransaction _self;
  final $Res Function(_TokenTransaction) _then;

/// Create a copy of TokenTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? amount = null,Object? type = null,Object? createdAt = null,Object? relatedAuctionId = freezed,Object? relatedPurchaseId = freezed,Object? relatedSubscriptionId = freezed,Object? description = freezed,Object? balanceAfter = freezed,}) {
  return _then(_TokenTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TokenTransactionType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,relatedAuctionId: freezed == relatedAuctionId ? _self.relatedAuctionId : relatedAuctionId // ignore: cast_nullable_to_non_nullable
as String?,relatedPurchaseId: freezed == relatedPurchaseId ? _self.relatedPurchaseId : relatedPurchaseId // ignore: cast_nullable_to_non_nullable
as String?,relatedSubscriptionId: freezed == relatedSubscriptionId ? _self.relatedSubscriptionId : relatedSubscriptionId // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,balanceAfter: freezed == balanceAfter ? _self.balanceAfter : balanceAfter // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$TokenPurchase {

 String get id; String get userId; TokenPurchaseTier get tier; int get tokensAdded; double get amountPaid; DateTime get purchasedAt; String? get paymentTransactionId;// Payment gateway transaction ID
 String? get paymentMethod;// GCash, PayMaya, Card, etc.
 String? get paymentReference; TokenPurchaseStatus? get status;
/// Create a copy of TokenPurchase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TokenPurchaseCopyWith<TokenPurchase> get copyWith => _$TokenPurchaseCopyWithImpl<TokenPurchase>(this as TokenPurchase, _$identity);

  /// Serializes this TokenPurchase to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TokenPurchase&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.tokensAdded, tokensAdded) || other.tokensAdded == tokensAdded)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.purchasedAt, purchasedAt) || other.purchasedAt == purchasedAt)&&(identical(other.paymentTransactionId, paymentTransactionId) || other.paymentTransactionId == paymentTransactionId)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentReference, paymentReference) || other.paymentReference == paymentReference)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,tier,tokensAdded,amountPaid,purchasedAt,paymentTransactionId,paymentMethod,paymentReference,status);

@override
String toString() {
  return 'TokenPurchase(id: $id, userId: $userId, tier: $tier, tokensAdded: $tokensAdded, amountPaid: $amountPaid, purchasedAt: $purchasedAt, paymentTransactionId: $paymentTransactionId, paymentMethod: $paymentMethod, paymentReference: $paymentReference, status: $status)';
}


}

/// @nodoc
abstract mixin class $TokenPurchaseCopyWith<$Res>  {
  factory $TokenPurchaseCopyWith(TokenPurchase value, $Res Function(TokenPurchase) _then) = _$TokenPurchaseCopyWithImpl;
@useResult
$Res call({
 String id, String userId, TokenPurchaseTier tier, int tokensAdded, double amountPaid, DateTime purchasedAt, String? paymentTransactionId, String? paymentMethod, String? paymentReference, TokenPurchaseStatus? status
});




}
/// @nodoc
class _$TokenPurchaseCopyWithImpl<$Res>
    implements $TokenPurchaseCopyWith<$Res> {
  _$TokenPurchaseCopyWithImpl(this._self, this._then);

  final TokenPurchase _self;
  final $Res Function(TokenPurchase) _then;

/// Create a copy of TokenPurchase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? tier = null,Object? tokensAdded = null,Object? amountPaid = null,Object? purchasedAt = null,Object? paymentTransactionId = freezed,Object? paymentMethod = freezed,Object? paymentReference = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as TokenPurchaseTier,tokensAdded: null == tokensAdded ? _self.tokensAdded : tokensAdded // ignore: cast_nullable_to_non_nullable
as int,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as double,purchasedAt: null == purchasedAt ? _self.purchasedAt : purchasedAt // ignore: cast_nullable_to_non_nullable
as DateTime,paymentTransactionId: freezed == paymentTransactionId ? _self.paymentTransactionId : paymentTransactionId // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,paymentReference: freezed == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TokenPurchaseStatus?,
  ));
}

}


/// Adds pattern-matching-related methods to [TokenPurchase].
extension TokenPurchasePatterns on TokenPurchase {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TokenPurchase value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TokenPurchase() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TokenPurchase value)  $default,){
final _that = this;
switch (_that) {
case _TokenPurchase():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TokenPurchase value)?  $default,){
final _that = this;
switch (_that) {
case _TokenPurchase() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  TokenPurchaseTier tier,  int tokensAdded,  double amountPaid,  DateTime purchasedAt,  String? paymentTransactionId,  String? paymentMethod,  String? paymentReference,  TokenPurchaseStatus? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TokenPurchase() when $default != null:
return $default(_that.id,_that.userId,_that.tier,_that.tokensAdded,_that.amountPaid,_that.purchasedAt,_that.paymentTransactionId,_that.paymentMethod,_that.paymentReference,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  TokenPurchaseTier tier,  int tokensAdded,  double amountPaid,  DateTime purchasedAt,  String? paymentTransactionId,  String? paymentMethod,  String? paymentReference,  TokenPurchaseStatus? status)  $default,) {final _that = this;
switch (_that) {
case _TokenPurchase():
return $default(_that.id,_that.userId,_that.tier,_that.tokensAdded,_that.amountPaid,_that.purchasedAt,_that.paymentTransactionId,_that.paymentMethod,_that.paymentReference,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  TokenPurchaseTier tier,  int tokensAdded,  double amountPaid,  DateTime purchasedAt,  String? paymentTransactionId,  String? paymentMethod,  String? paymentReference,  TokenPurchaseStatus? status)?  $default,) {final _that = this;
switch (_that) {
case _TokenPurchase() when $default != null:
return $default(_that.id,_that.userId,_that.tier,_that.tokensAdded,_that.amountPaid,_that.purchasedAt,_that.paymentTransactionId,_that.paymentMethod,_that.paymentReference,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TokenPurchase implements TokenPurchase {
  const _TokenPurchase({required this.id, required this.userId, required this.tier, required this.tokensAdded, required this.amountPaid, required this.purchasedAt, this.paymentTransactionId, this.paymentMethod, this.paymentReference, this.status});
  factory _TokenPurchase.fromJson(Map<String, dynamic> json) => _$TokenPurchaseFromJson(json);

@override final  String id;
@override final  String userId;
@override final  TokenPurchaseTier tier;
@override final  int tokensAdded;
@override final  double amountPaid;
@override final  DateTime purchasedAt;
@override final  String? paymentTransactionId;
// Payment gateway transaction ID
@override final  String? paymentMethod;
// GCash, PayMaya, Card, etc.
@override final  String? paymentReference;
@override final  TokenPurchaseStatus? status;

/// Create a copy of TokenPurchase
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TokenPurchaseCopyWith<_TokenPurchase> get copyWith => __$TokenPurchaseCopyWithImpl<_TokenPurchase>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TokenPurchaseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TokenPurchase&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.tier, tier) || other.tier == tier)&&(identical(other.tokensAdded, tokensAdded) || other.tokensAdded == tokensAdded)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.purchasedAt, purchasedAt) || other.purchasedAt == purchasedAt)&&(identical(other.paymentTransactionId, paymentTransactionId) || other.paymentTransactionId == paymentTransactionId)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentReference, paymentReference) || other.paymentReference == paymentReference)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,tier,tokensAdded,amountPaid,purchasedAt,paymentTransactionId,paymentMethod,paymentReference,status);

@override
String toString() {
  return 'TokenPurchase(id: $id, userId: $userId, tier: $tier, tokensAdded: $tokensAdded, amountPaid: $amountPaid, purchasedAt: $purchasedAt, paymentTransactionId: $paymentTransactionId, paymentMethod: $paymentMethod, paymentReference: $paymentReference, status: $status)';
}


}

/// @nodoc
abstract mixin class _$TokenPurchaseCopyWith<$Res> implements $TokenPurchaseCopyWith<$Res> {
  factory _$TokenPurchaseCopyWith(_TokenPurchase value, $Res Function(_TokenPurchase) _then) = __$TokenPurchaseCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, TokenPurchaseTier tier, int tokensAdded, double amountPaid, DateTime purchasedAt, String? paymentTransactionId, String? paymentMethod, String? paymentReference, TokenPurchaseStatus? status
});




}
/// @nodoc
class __$TokenPurchaseCopyWithImpl<$Res>
    implements _$TokenPurchaseCopyWith<$Res> {
  __$TokenPurchaseCopyWithImpl(this._self, this._then);

  final _TokenPurchase _self;
  final $Res Function(_TokenPurchase) _then;

/// Create a copy of TokenPurchase
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? tier = null,Object? tokensAdded = null,Object? amountPaid = null,Object? purchasedAt = null,Object? paymentTransactionId = freezed,Object? paymentMethod = freezed,Object? paymentReference = freezed,Object? status = freezed,}) {
  return _then(_TokenPurchase(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,tier: null == tier ? _self.tier : tier // ignore: cast_nullable_to_non_nullable
as TokenPurchaseTier,tokensAdded: null == tokensAdded ? _self.tokensAdded : tokensAdded // ignore: cast_nullable_to_non_nullable
as int,amountPaid: null == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as double,purchasedAt: null == purchasedAt ? _self.purchasedAt : purchasedAt // ignore: cast_nullable_to_non_nullable
as DateTime,paymentTransactionId: freezed == paymentTransactionId ? _self.paymentTransactionId : paymentTransactionId // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,paymentReference: freezed == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TokenPurchaseStatus?,
  ));
}


}

// dart format on
