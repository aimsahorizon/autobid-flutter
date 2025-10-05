// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'car_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CarLocation {
  String get city;
  String get province;
/// Create a copy of CarLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CarLocationCopyWith<CarLocation> get copyWith => _$CarLocationCopyWithImpl<CarLocation>(this as CarLocation, _$identity);

  /// Serializes this CarLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CarLocation&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,province);

@override
String toString() {
  return 'CarLocation(city: $city, province: $province)';
}


}

/// @nodoc
abstract mixin class $CarLocationCopyWith<$Res>  {
  factory $CarLocationCopyWith(CarLocation value, $Res Function(CarLocation) _then) = _$CarLocationCopyWithImpl;
@useResult
$Res call({
 String city, String province
});




}
/// @nodoc
class _$CarLocationCopyWithImpl<$Res>
    implements $CarLocationCopyWith<$Res> {
  _$CarLocationCopyWithImpl(this._self, this._then);

  final CarLocation _self;
  final $Res Function(CarLocation) _then;

/// Create a copy of CarLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? city = null,Object? province = null,}) {
  return _then(_self.copyWith(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CarLocation].
extension CarLocationPatterns on CarLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CarLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CarLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CarLocation value)  $default,){
final _that = this;
switch (_that) {
case _CarLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CarLocation value)?  $default,){
final _that = this;
switch (_that) {
case _CarLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String city,  String province)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CarLocation() when $default != null:
return $default(_that.city,_that.province);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String city,  String province)  $default,) {final _that = this;
switch (_that) {
case _CarLocation():
return $default(_that.city,_that.province);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String city,  String province)?  $default,) {final _that = this;
switch (_that) {
case _CarLocation() when $default != null:
return $default(_that.city,_that.province);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CarLocation implements CarLocation {
  const _CarLocation({required this.city, required this.province});
  factory _CarLocation.fromJson(Map<String, dynamic> json) => _$CarLocationFromJson(json);

  @override
  final String city;

  @override
  final String province;

/// Create a copy of CarLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CarLocationCopyWith<_CarLocation> get copyWith => __$CarLocationCopyWithImpl<_CarLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CarLocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CarLocation&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,province);

@override
String toString() {
  return 'CarLocation(city: $city, province: $province)';
}


}

/// @nodoc
abstract mixin class _$CarLocationCopyWith<$Res> implements $CarLocationCopyWith<$Res> {
  factory _$CarLocationCopyWith(_CarLocation value, $Res Function(_CarLocation) _then) = __$CarLocationCopyWithImpl;
@override @useResult
$Res call({
 String city, String province
});




}
/// @nodoc
class __$CarLocationCopyWithImpl<$Res>
    implements _$CarLocationCopyWith<$Res> {
  __$CarLocationCopyWithImpl(this._self, this._then);

  final _CarLocation _self;
  final $Res Function(_CarLocation) _then;

/// Create a copy of CarLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? city = null,Object? province = null,}) {
  return _then(_CarLocation(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,province: null == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CarModel {
  // Basic Info
  String get id;
  String get sellerId;
  String get sellerName;
  String get brand;
  String get model;
  String get variant;
  int get year;
  int get mileage;

  // Technical Details
  TransmissionType get transmission;
  FuelType get fuelType;
  BodyType get bodyType;
  String get color;
  String get engineSize;
  int get seats;
  int get doors;

  // Documents
  String get plateNumber;
  String get orcrNumber;
  CarLocation get location;
  int get numberOfOwners;
  bool get serviceHistoryComplete;
  bool get hasAccidentHistory;

  // Condition & Description
  CarCondition get condition;
  String get description;
  String? get issues;
  List<String> get images;
  List<String> get features;

  // Status
  ListingStatus get status;
  DateTime get createdAt;
  DateTime get updatedAt;
  int get viewCount;
/// Create a copy of CarModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CarModelCopyWith<CarModel> get copyWith => _$CarModelCopyWithImpl<CarModel>(this as CarModel, _$identity);

  /// Serializes this CarModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CarModel&&(identical(other.id, id) || other.id == id)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.model, model) || other.model == model)&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.year, year) || other.year == year)&&(identical(other.mileage, mileage) || other.mileage == mileage)&&(identical(other.transmission, transmission) || other.transmission == transmission)&&(identical(other.fuelType, fuelType) || other.fuelType == fuelType)&&(identical(other.bodyType, bodyType) || other.bodyType == bodyType)&&(identical(other.color, color) || other.color == color)&&(identical(other.engineSize, engineSize) || other.engineSize == engineSize)&&(identical(other.seats, seats) || other.seats == seats)&&(identical(other.doors, doors) || other.doors == doors)&&(identical(other.plateNumber, plateNumber) || other.plateNumber == plateNumber)&&(identical(other.orcrNumber, orcrNumber) || other.orcrNumber == orcrNumber)&&(identical(other.location, location) || other.location == location)&&(identical(other.numberOfOwners, numberOfOwners) || other.numberOfOwners == numberOfOwners)&&(identical(other.serviceHistoryComplete, serviceHistoryComplete) || other.serviceHistoryComplete == serviceHistoryComplete)&&(identical(other.hasAccidentHistory, hasAccidentHistory) || other.hasAccidentHistory == hasAccidentHistory)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.description, description) || other.description == description)&&(identical(other.issues, issues) || other.issues == issues)&&const DeepCollectionEquality().equals(other.images, images)&&const DeepCollectionEquality().equals(other.features, features)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,sellerId,sellerName,brand,model,variant,year,mileage,transmission,fuelType,bodyType,color,engineSize,seats,doors,plateNumber,orcrNumber,location,numberOfOwners,serviceHistoryComplete,hasAccidentHistory,condition,description,issues,const DeepCollectionEquality().hash(images),const DeepCollectionEquality().hash(features),status,createdAt,updatedAt,viewCount]);

@override
String toString() {
  return 'CarModel(id: $id, sellerId: $sellerId, sellerName: $sellerName, brand: $brand, model: $model, variant: $variant, year: $year, mileage: $mileage, transmission: $transmission, fuelType: $fuelType, bodyType: $bodyType, color: $color, engineSize: $engineSize, seats: $seats, doors: $doors, plateNumber: $plateNumber, orcrNumber: $orcrNumber, location: $location, numberOfOwners: $numberOfOwners, serviceHistoryComplete: $serviceHistoryComplete, hasAccidentHistory: $hasAccidentHistory, condition: $condition, description: $description, issues: $issues, images: $images, features: $features, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, viewCount: $viewCount)';
}


}

/// @nodoc
abstract mixin class $CarModelCopyWith<$Res>  {
  factory $CarModelCopyWith(CarModel value, $Res Function(CarModel) _then) = _$CarModelCopyWithImpl;
@useResult
$Res call({
 String id, String sellerId, String sellerName, String brand, String model, String variant, int year, int mileage, TransmissionType transmission, FuelType fuelType, BodyType bodyType, String color, String engineSize, int seats, int doors, String plateNumber, String orcrNumber, CarLocation location, int numberOfOwners, bool serviceHistoryComplete, bool hasAccidentHistory, CarCondition condition, String description, String? issues, List<String> images, List<String> features, ListingStatus status, DateTime createdAt, DateTime updatedAt, int viewCount
});


$CarLocationCopyWith<$Res> get location;

}
/// @nodoc
class _$CarModelCopyWithImpl<$Res>
    implements $CarModelCopyWith<$Res> {
  _$CarModelCopyWithImpl(this._self, this._then);

  final CarModel _self;
  final $Res Function(CarModel) _then;

/// Create a copy of CarModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sellerId = null,Object? sellerName = null,Object? brand = null,Object? model = null,Object? variant = null,Object? year = null,Object? mileage = null,Object? transmission = null,Object? fuelType = null,Object? bodyType = null,Object? color = null,Object? engineSize = null,Object? seats = null,Object? doors = null,Object? plateNumber = null,Object? orcrNumber = null,Object? location = null,Object? numberOfOwners = null,Object? serviceHistoryComplete = null,Object? hasAccidentHistory = null,Object? condition = null,Object? description = null,Object? issues = freezed,Object? images = null,Object? features = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? viewCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,sellerName: null == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,variant: null == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,mileage: null == mileage ? _self.mileage : mileage // ignore: cast_nullable_to_non_nullable
as int,transmission: null == transmission ? _self.transmission : transmission // ignore: cast_nullable_to_non_nullable
as TransmissionType,fuelType: null == fuelType ? _self.fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as FuelType,bodyType: null == bodyType ? _self.bodyType : bodyType // ignore: cast_nullable_to_non_nullable
as BodyType,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,engineSize: null == engineSize ? _self.engineSize : engineSize // ignore: cast_nullable_to_non_nullable
as String,seats: null == seats ? _self.seats : seats // ignore: cast_nullable_to_non_nullable
as int,doors: null == doors ? _self.doors : doors // ignore: cast_nullable_to_non_nullable
as int,plateNumber: null == plateNumber ? _self.plateNumber : plateNumber // ignore: cast_nullable_to_non_nullable
as String,orcrNumber: null == orcrNumber ? _self.orcrNumber : orcrNumber // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as CarLocation,numberOfOwners: null == numberOfOwners ? _self.numberOfOwners : numberOfOwners // ignore: cast_nullable_to_non_nullable
as int,serviceHistoryComplete: null == serviceHistoryComplete ? _self.serviceHistoryComplete : serviceHistoryComplete // ignore: cast_nullable_to_non_nullable
as bool,hasAccidentHistory: null == hasAccidentHistory ? _self.hasAccidentHistory : hasAccidentHistory // ignore: cast_nullable_to_non_nullable
as bool,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as CarCondition,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,issues: freezed == issues ? _self.issues : issues // ignore: cast_nullable_to_non_nullable
as String?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ListingStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,viewCount: null == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of CarModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CarLocationCopyWith<$Res> get location {
  
  return $CarLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [CarModel].
extension CarModelPatterns on CarModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CarModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CarModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CarModel value)  $default,){
final _that = this;
switch (_that) {
case _CarModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CarModel value)?  $default,){
final _that = this;
switch (_that) {
case _CarModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String sellerId,  String sellerName,  String brand,  String model,  String variant,  int year,  int mileage,  TransmissionType transmission,  FuelType fuelType,  BodyType bodyType,  String color,  String engineSize,  int seats,  int doors,  String plateNumber,  String orcrNumber,  CarLocation location,  int numberOfOwners,  bool serviceHistoryComplete,  bool hasAccidentHistory,  CarCondition condition,  String description,  String? issues,  List<String> images,  List<String> features,  ListingStatus status,  DateTime createdAt,  DateTime updatedAt,  int viewCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CarModel() when $default != null:
return $default(_that.id,_that.sellerId,_that.sellerName,_that.brand,_that.model,_that.variant,_that.year,_that.mileage,_that.transmission,_that.fuelType,_that.bodyType,_that.color,_that.engineSize,_that.seats,_that.doors,_that.plateNumber,_that.orcrNumber,_that.location,_that.numberOfOwners,_that.serviceHistoryComplete,_that.hasAccidentHistory,_that.condition,_that.description,_that.issues,_that.images,_that.features,_that.status,_that.createdAt,_that.updatedAt,_that.viewCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String sellerId,  String sellerName,  String brand,  String model,  String variant,  int year,  int mileage,  TransmissionType transmission,  FuelType fuelType,  BodyType bodyType,  String color,  String engineSize,  int seats,  int doors,  String plateNumber,  String orcrNumber,  CarLocation location,  int numberOfOwners,  bool serviceHistoryComplete,  bool hasAccidentHistory,  CarCondition condition,  String description,  String? issues,  List<String> images,  List<String> features,  ListingStatus status,  DateTime createdAt,  DateTime updatedAt,  int viewCount)  $default,) {final _that = this;
switch (_that) {
case _CarModel():
return $default(_that.id,_that.sellerId,_that.sellerName,_that.brand,_that.model,_that.variant,_that.year,_that.mileage,_that.transmission,_that.fuelType,_that.bodyType,_that.color,_that.engineSize,_that.seats,_that.doors,_that.plateNumber,_that.orcrNumber,_that.location,_that.numberOfOwners,_that.serviceHistoryComplete,_that.hasAccidentHistory,_that.condition,_that.description,_that.issues,_that.images,_that.features,_that.status,_that.createdAt,_that.updatedAt,_that.viewCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String sellerId,  String sellerName,  String brand,  String model,  String variant,  int year,  int mileage,  TransmissionType transmission,  FuelType fuelType,  BodyType bodyType,  String color,  String engineSize,  int seats,  int doors,  String plateNumber,  String orcrNumber,  CarLocation location,  int numberOfOwners,  bool serviceHistoryComplete,  bool hasAccidentHistory,  CarCondition condition,  String description,  String? issues,  List<String> images,  List<String> features,  ListingStatus status,  DateTime createdAt,  DateTime updatedAt,  int viewCount)?  $default,) {final _that = this;
switch (_that) {
case _CarModel() when $default != null:
return $default(_that.id,_that.sellerId,_that.sellerName,_that.brand,_that.model,_that.variant,_that.year,_that.mileage,_that.transmission,_that.fuelType,_that.bodyType,_that.color,_that.engineSize,_that.seats,_that.doors,_that.plateNumber,_that.orcrNumber,_that.location,_that.numberOfOwners,_that.serviceHistoryComplete,_that.hasAccidentHistory,_that.condition,_that.description,_that.issues,_that.images,_that.features,_that.status,_that.createdAt,_that.updatedAt,_that.viewCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CarModel implements CarModel {
  const _CarModel({required this.id, required this.sellerId, required this.sellerName, required this.brand, required this.model, required this.variant, required this.year, required this.mileage, required this.transmission, required this.fuelType, required this.bodyType, required this.color, required this.engineSize, required this.seats, required this.doors, required this.plateNumber, required this.orcrNumber, required this.location, required this.numberOfOwners, required this.serviceHistoryComplete, required this.hasAccidentHistory, required this.condition, required this.description, this.issues, required final  List<String> images, final  List<String> features = const [], required this.status, required this.createdAt, required this.updatedAt, this.viewCount = 0}): _images = images,_features = features;
  factory _CarModel.fromJson(Map<String, dynamic> json) => _$CarModelFromJson(json);

  @override
  final String id;

  @override
  final String sellerId;

  @override
  final String sellerName;

  // Basic Info
  @override
  final String brand;

  @override
  final String model;

  @override
  final String variant;

  @override
  final int year;

  @override
  final int mileage;

  // Technical Details
  @override
  final TransmissionType transmission;

  @override
  final FuelType fuelType;

  @override
  final BodyType bodyType;

  @override
  final String color;

  @override
  final String engineSize;

  @override
  final int seats;

  @override
  final int doors;

  // Documents
  @override
  final String plateNumber;

  @override
  final String orcrNumber;

  @override
  final CarLocation location;

  @override
  final int numberOfOwners;

  @override
  final bool serviceHistoryComplete;

  @override
  final bool hasAccidentHistory;

  // Condition & Description
  @override
  final CarCondition condition;

  @override
  final String description;

  @override
  final String? issues;

  final List<String> _images;

  @override
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  final List<String> _features;

  @override
  @JsonKey()
  List<String> get features {
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_features);
  }

  // Status
  @override
  final ListingStatus status;

  @override
  final DateTime createdAt;

  @override
  final DateTime updatedAt;

  @override
  @JsonKey()
  final int viewCount;

/// Create a copy of CarModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CarModelCopyWith<_CarModel> get copyWith => __$CarModelCopyWithImpl<_CarModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CarModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CarModel&&(identical(other.id, id) || other.id == id)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.model, model) || other.model == model)&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.year, year) || other.year == year)&&(identical(other.mileage, mileage) || other.mileage == mileage)&&(identical(other.transmission, transmission) || other.transmission == transmission)&&(identical(other.fuelType, fuelType) || other.fuelType == fuelType)&&(identical(other.bodyType, bodyType) || other.bodyType == bodyType)&&(identical(other.color, color) || other.color == color)&&(identical(other.engineSize, engineSize) || other.engineSize == engineSize)&&(identical(other.seats, seats) || other.seats == seats)&&(identical(other.doors, doors) || other.doors == doors)&&(identical(other.plateNumber, plateNumber) || other.plateNumber == plateNumber)&&(identical(other.orcrNumber, orcrNumber) || other.orcrNumber == orcrNumber)&&(identical(other.location, location) || other.location == location)&&(identical(other.numberOfOwners, numberOfOwners) || other.numberOfOwners == numberOfOwners)&&(identical(other.serviceHistoryComplete, serviceHistoryComplete) || other.serviceHistoryComplete == serviceHistoryComplete)&&(identical(other.hasAccidentHistory, hasAccidentHistory) || other.hasAccidentHistory == hasAccidentHistory)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.description, description) || other.description == description)&&(identical(other.issues, issues) || other.issues == issues)&&const DeepCollectionEquality().equals(other._images, _images)&&const DeepCollectionEquality().equals(other._features, _features)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,sellerId,sellerName,brand,model,variant,year,mileage,transmission,fuelType,bodyType,color,engineSize,seats,doors,plateNumber,orcrNumber,location,numberOfOwners,serviceHistoryComplete,hasAccidentHistory,condition,description,issues,const DeepCollectionEquality().hash(_images),const DeepCollectionEquality().hash(_features),status,createdAt,updatedAt,viewCount]);

@override
String toString() {
  return 'CarModel(id: $id, sellerId: $sellerId, sellerName: $sellerName, brand: $brand, model: $model, variant: $variant, year: $year, mileage: $mileage, transmission: $transmission, fuelType: $fuelType, bodyType: $bodyType, color: $color, engineSize: $engineSize, seats: $seats, doors: $doors, plateNumber: $plateNumber, orcrNumber: $orcrNumber, location: $location, numberOfOwners: $numberOfOwners, serviceHistoryComplete: $serviceHistoryComplete, hasAccidentHistory: $hasAccidentHistory, condition: $condition, description: $description, issues: $issues, images: $images, features: $features, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, viewCount: $viewCount)';
}


}

/// @nodoc
abstract mixin class _$CarModelCopyWith<$Res> implements $CarModelCopyWith<$Res> {
  factory _$CarModelCopyWith(_CarModel value, $Res Function(_CarModel) _then) = __$CarModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String sellerId, String sellerName, String brand, String model, String variant, int year, int mileage, TransmissionType transmission, FuelType fuelType, BodyType bodyType, String color, String engineSize, int seats, int doors, String plateNumber, String orcrNumber, CarLocation location, int numberOfOwners, bool serviceHistoryComplete, bool hasAccidentHistory, CarCondition condition, String description, String? issues, List<String> images, List<String> features, ListingStatus status, DateTime createdAt, DateTime updatedAt, int viewCount
});


@override $CarLocationCopyWith<$Res> get location;

}
/// @nodoc
class __$CarModelCopyWithImpl<$Res>
    implements _$CarModelCopyWith<$Res> {
  __$CarModelCopyWithImpl(this._self, this._then);

  final _CarModel _self;
  final $Res Function(_CarModel) _then;

/// Create a copy of CarModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sellerId = null,Object? sellerName = null,Object? brand = null,Object? model = null,Object? variant = null,Object? year = null,Object? mileage = null,Object? transmission = null,Object? fuelType = null,Object? bodyType = null,Object? color = null,Object? engineSize = null,Object? seats = null,Object? doors = null,Object? plateNumber = null,Object? orcrNumber = null,Object? location = null,Object? numberOfOwners = null,Object? serviceHistoryComplete = null,Object? hasAccidentHistory = null,Object? condition = null,Object? description = null,Object? issues = freezed,Object? images = null,Object? features = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? viewCount = null,}) {
  return _then(_CarModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,sellerName: null == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,variant: null == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,mileage: null == mileage ? _self.mileage : mileage // ignore: cast_nullable_to_non_nullable
as int,transmission: null == transmission ? _self.transmission : transmission // ignore: cast_nullable_to_non_nullable
as TransmissionType,fuelType: null == fuelType ? _self.fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as FuelType,bodyType: null == bodyType ? _self.bodyType : bodyType // ignore: cast_nullable_to_non_nullable
as BodyType,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,engineSize: null == engineSize ? _self.engineSize : engineSize // ignore: cast_nullable_to_non_nullable
as String,seats: null == seats ? _self.seats : seats // ignore: cast_nullable_to_non_nullable
as int,doors: null == doors ? _self.doors : doors // ignore: cast_nullable_to_non_nullable
as int,plateNumber: null == plateNumber ? _self.plateNumber : plateNumber // ignore: cast_nullable_to_non_nullable
as String,orcrNumber: null == orcrNumber ? _self.orcrNumber : orcrNumber // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as CarLocation,numberOfOwners: null == numberOfOwners ? _self.numberOfOwners : numberOfOwners // ignore: cast_nullable_to_non_nullable
as int,serviceHistoryComplete: null == serviceHistoryComplete ? _self.serviceHistoryComplete : serviceHistoryComplete // ignore: cast_nullable_to_non_nullable
as bool,hasAccidentHistory: null == hasAccidentHistory ? _self.hasAccidentHistory : hasAccidentHistory // ignore: cast_nullable_to_non_nullable
as bool,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as CarCondition,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,issues: freezed == issues ? _self.issues : issues // ignore: cast_nullable_to_non_nullable
as String?,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ListingStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,viewCount: null == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of CarModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CarLocationCopyWith<$Res> get location {
  
  return $CarLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

// dart format on
