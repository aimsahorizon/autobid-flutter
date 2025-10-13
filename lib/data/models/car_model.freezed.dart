// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'car_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CarLocation {

 String get city; String get province;
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

@override final  String city;
@override final  String province;

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

 String get id; String get sellerId; String get sellerName;// BASIC INFO
 String get brand; String get model; String get variant; int get year;// MECHANICAL
 String get engineSize; EngineType get engineType; int get cylinders; int get horsepower; int get torque; TransmissionType get transmission; int get transmissionSpeeds; DriveType get driveType; FuelType get fuelType; double get fuelConsumption; int? get electricRange; double? get batteryCapacity; String? get chargingTime;// DIMENSIONS & CAPACITY
 BodyType get bodyType; int get doors; int get seats; int get curbWeight; int get grossWeight; int get cargoCapacity; int? get towingCapacity; int? get groundClearance; int get length; int get width; int get height; int get wheelbase;// EXTERIOR
 String get color; PaintType get paintType; int get rimSize; RimType get rimType; TireCondition get tireCondition;// CONDITION & HISTORY
 CarCondition get condition; int get mileage; int get numberOfOwners; bool get hasAccidentHistory; bool get floodDamage; bool get fireDamage; bool get frameDamage; bool get isRepainted; bool get hasModifications; bool get originalParts; bool get commercialUse; bool get smokerVehicle; bool get serviceHistoryComplete; bool get warrantyRemaining; DateTime? get registrationExpiry;// FEATURES & TECHNOLOGY
 List<String> get features;// LOCATION & AVAILABILITY
 CarLocation get location; bool get availableForTestDrive; bool get deliveryAvailable;// DOCUMENTATION
 String get plateNumber; String get orcrNumber; RegistrationStatus get registrationStatus; bool get emissionTestValid; bool get comprehensiveInsurance;// SELLER PREFERENCES
 bool get acceptsTrade; bool get financingAvailable; bool get priceNegotiable;// DESCRIPTION
 String get description; String? get issues;// MEDIA & STATUS
 List<String> get images; Map<String, List<String>> get categorizedImages; ListingStatus get status; DateTime get createdAt; DateTime get updatedAt; int get viewCount;
/// Create a copy of CarModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CarModelCopyWith<CarModel> get copyWith => _$CarModelCopyWithImpl<CarModel>(this as CarModel, _$identity);

  /// Serializes this CarModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CarModel&&(identical(other.id, id) || other.id == id)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.model, model) || other.model == model)&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.year, year) || other.year == year)&&(identical(other.engineSize, engineSize) || other.engineSize == engineSize)&&(identical(other.engineType, engineType) || other.engineType == engineType)&&(identical(other.cylinders, cylinders) || other.cylinders == cylinders)&&(identical(other.horsepower, horsepower) || other.horsepower == horsepower)&&(identical(other.torque, torque) || other.torque == torque)&&(identical(other.transmission, transmission) || other.transmission == transmission)&&(identical(other.transmissionSpeeds, transmissionSpeeds) || other.transmissionSpeeds == transmissionSpeeds)&&(identical(other.driveType, driveType) || other.driveType == driveType)&&(identical(other.fuelType, fuelType) || other.fuelType == fuelType)&&(identical(other.fuelConsumption, fuelConsumption) || other.fuelConsumption == fuelConsumption)&&(identical(other.electricRange, electricRange) || other.electricRange == electricRange)&&(identical(other.batteryCapacity, batteryCapacity) || other.batteryCapacity == batteryCapacity)&&(identical(other.chargingTime, chargingTime) || other.chargingTime == chargingTime)&&(identical(other.bodyType, bodyType) || other.bodyType == bodyType)&&(identical(other.doors, doors) || other.doors == doors)&&(identical(other.seats, seats) || other.seats == seats)&&(identical(other.curbWeight, curbWeight) || other.curbWeight == curbWeight)&&(identical(other.grossWeight, grossWeight) || other.grossWeight == grossWeight)&&(identical(other.cargoCapacity, cargoCapacity) || other.cargoCapacity == cargoCapacity)&&(identical(other.towingCapacity, towingCapacity) || other.towingCapacity == towingCapacity)&&(identical(other.groundClearance, groundClearance) || other.groundClearance == groundClearance)&&(identical(other.length, length) || other.length == length)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.wheelbase, wheelbase) || other.wheelbase == wheelbase)&&(identical(other.color, color) || other.color == color)&&(identical(other.paintType, paintType) || other.paintType == paintType)&&(identical(other.rimSize, rimSize) || other.rimSize == rimSize)&&(identical(other.rimType, rimType) || other.rimType == rimType)&&(identical(other.tireCondition, tireCondition) || other.tireCondition == tireCondition)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.mileage, mileage) || other.mileage == mileage)&&(identical(other.numberOfOwners, numberOfOwners) || other.numberOfOwners == numberOfOwners)&&(identical(other.hasAccidentHistory, hasAccidentHistory) || other.hasAccidentHistory == hasAccidentHistory)&&(identical(other.floodDamage, floodDamage) || other.floodDamage == floodDamage)&&(identical(other.fireDamage, fireDamage) || other.fireDamage == fireDamage)&&(identical(other.frameDamage, frameDamage) || other.frameDamage == frameDamage)&&(identical(other.isRepainted, isRepainted) || other.isRepainted == isRepainted)&&(identical(other.hasModifications, hasModifications) || other.hasModifications == hasModifications)&&(identical(other.originalParts, originalParts) || other.originalParts == originalParts)&&(identical(other.commercialUse, commercialUse) || other.commercialUse == commercialUse)&&(identical(other.smokerVehicle, smokerVehicle) || other.smokerVehicle == smokerVehicle)&&(identical(other.serviceHistoryComplete, serviceHistoryComplete) || other.serviceHistoryComplete == serviceHistoryComplete)&&(identical(other.warrantyRemaining, warrantyRemaining) || other.warrantyRemaining == warrantyRemaining)&&(identical(other.registrationExpiry, registrationExpiry) || other.registrationExpiry == registrationExpiry)&&const DeepCollectionEquality().equals(other.features, features)&&(identical(other.location, location) || other.location == location)&&(identical(other.availableForTestDrive, availableForTestDrive) || other.availableForTestDrive == availableForTestDrive)&&(identical(other.deliveryAvailable, deliveryAvailable) || other.deliveryAvailable == deliveryAvailable)&&(identical(other.plateNumber, plateNumber) || other.plateNumber == plateNumber)&&(identical(other.orcrNumber, orcrNumber) || other.orcrNumber == orcrNumber)&&(identical(other.registrationStatus, registrationStatus) || other.registrationStatus == registrationStatus)&&(identical(other.emissionTestValid, emissionTestValid) || other.emissionTestValid == emissionTestValid)&&(identical(other.comprehensiveInsurance, comprehensiveInsurance) || other.comprehensiveInsurance == comprehensiveInsurance)&&(identical(other.acceptsTrade, acceptsTrade) || other.acceptsTrade == acceptsTrade)&&(identical(other.financingAvailable, financingAvailable) || other.financingAvailable == financingAvailable)&&(identical(other.priceNegotiable, priceNegotiable) || other.priceNegotiable == priceNegotiable)&&(identical(other.description, description) || other.description == description)&&(identical(other.issues, issues) || other.issues == issues)&&const DeepCollectionEquality().equals(other.images, images)&&const DeepCollectionEquality().equals(other.categorizedImages, categorizedImages)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,sellerId,sellerName,brand,model,variant,year,engineSize,engineType,cylinders,horsepower,torque,transmission,transmissionSpeeds,driveType,fuelType,fuelConsumption,electricRange,batteryCapacity,chargingTime,bodyType,doors,seats,curbWeight,grossWeight,cargoCapacity,towingCapacity,groundClearance,length,width,height,wheelbase,color,paintType,rimSize,rimType,tireCondition,condition,mileage,numberOfOwners,hasAccidentHistory,floodDamage,fireDamage,frameDamage,isRepainted,hasModifications,originalParts,commercialUse,smokerVehicle,serviceHistoryComplete,warrantyRemaining,registrationExpiry,const DeepCollectionEquality().hash(features),location,availableForTestDrive,deliveryAvailable,plateNumber,orcrNumber,registrationStatus,emissionTestValid,comprehensiveInsurance,acceptsTrade,financingAvailable,priceNegotiable,description,issues,const DeepCollectionEquality().hash(images),const DeepCollectionEquality().hash(categorizedImages),status,createdAt,updatedAt,viewCount]);

@override
String toString() {
  return 'CarModel(id: $id, sellerId: $sellerId, sellerName: $sellerName, brand: $brand, model: $model, variant: $variant, year: $year, engineSize: $engineSize, engineType: $engineType, cylinders: $cylinders, horsepower: $horsepower, torque: $torque, transmission: $transmission, transmissionSpeeds: $transmissionSpeeds, driveType: $driveType, fuelType: $fuelType, fuelConsumption: $fuelConsumption, electricRange: $electricRange, batteryCapacity: $batteryCapacity, chargingTime: $chargingTime, bodyType: $bodyType, doors: $doors, seats: $seats, curbWeight: $curbWeight, grossWeight: $grossWeight, cargoCapacity: $cargoCapacity, towingCapacity: $towingCapacity, groundClearance: $groundClearance, length: $length, width: $width, height: $height, wheelbase: $wheelbase, color: $color, paintType: $paintType, rimSize: $rimSize, rimType: $rimType, tireCondition: $tireCondition, condition: $condition, mileage: $mileage, numberOfOwners: $numberOfOwners, hasAccidentHistory: $hasAccidentHistory, floodDamage: $floodDamage, fireDamage: $fireDamage, frameDamage: $frameDamage, isRepainted: $isRepainted, hasModifications: $hasModifications, originalParts: $originalParts, commercialUse: $commercialUse, smokerVehicle: $smokerVehicle, serviceHistoryComplete: $serviceHistoryComplete, warrantyRemaining: $warrantyRemaining, registrationExpiry: $registrationExpiry, features: $features, location: $location, availableForTestDrive: $availableForTestDrive, deliveryAvailable: $deliveryAvailable, plateNumber: $plateNumber, orcrNumber: $orcrNumber, registrationStatus: $registrationStatus, emissionTestValid: $emissionTestValid, comprehensiveInsurance: $comprehensiveInsurance, acceptsTrade: $acceptsTrade, financingAvailable: $financingAvailable, priceNegotiable: $priceNegotiable, description: $description, issues: $issues, images: $images, categorizedImages: $categorizedImages, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, viewCount: $viewCount)';
}


}

/// @nodoc
abstract mixin class $CarModelCopyWith<$Res>  {
  factory $CarModelCopyWith(CarModel value, $Res Function(CarModel) _then) = _$CarModelCopyWithImpl;
@useResult
$Res call({
 String id, String sellerId, String sellerName, String brand, String model, String variant, int year, String engineSize, EngineType engineType, int cylinders, int horsepower, int torque, TransmissionType transmission, int transmissionSpeeds, DriveType driveType, FuelType fuelType, double fuelConsumption, int? electricRange, double? batteryCapacity, String? chargingTime, BodyType bodyType, int doors, int seats, int curbWeight, int grossWeight, int cargoCapacity, int? towingCapacity, int? groundClearance, int length, int width, int height, int wheelbase, String color, PaintType paintType, int rimSize, RimType rimType, TireCondition tireCondition, CarCondition condition, int mileage, int numberOfOwners, bool hasAccidentHistory, bool floodDamage, bool fireDamage, bool frameDamage, bool isRepainted, bool hasModifications, bool originalParts, bool commercialUse, bool smokerVehicle, bool serviceHistoryComplete, bool warrantyRemaining, DateTime? registrationExpiry, List<String> features, CarLocation location, bool availableForTestDrive, bool deliveryAvailable, String plateNumber, String orcrNumber, RegistrationStatus registrationStatus, bool emissionTestValid, bool comprehensiveInsurance, bool acceptsTrade, bool financingAvailable, bool priceNegotiable, String description, String? issues, List<String> images, Map<String, List<String>> categorizedImages, ListingStatus status, DateTime createdAt, DateTime updatedAt, int viewCount
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sellerId = null,Object? sellerName = null,Object? brand = null,Object? model = null,Object? variant = null,Object? year = null,Object? engineSize = null,Object? engineType = null,Object? cylinders = null,Object? horsepower = null,Object? torque = null,Object? transmission = null,Object? transmissionSpeeds = null,Object? driveType = null,Object? fuelType = null,Object? fuelConsumption = null,Object? electricRange = freezed,Object? batteryCapacity = freezed,Object? chargingTime = freezed,Object? bodyType = null,Object? doors = null,Object? seats = null,Object? curbWeight = null,Object? grossWeight = null,Object? cargoCapacity = null,Object? towingCapacity = freezed,Object? groundClearance = freezed,Object? length = null,Object? width = null,Object? height = null,Object? wheelbase = null,Object? color = null,Object? paintType = null,Object? rimSize = null,Object? rimType = null,Object? tireCondition = null,Object? condition = null,Object? mileage = null,Object? numberOfOwners = null,Object? hasAccidentHistory = null,Object? floodDamage = null,Object? fireDamage = null,Object? frameDamage = null,Object? isRepainted = null,Object? hasModifications = null,Object? originalParts = null,Object? commercialUse = null,Object? smokerVehicle = null,Object? serviceHistoryComplete = null,Object? warrantyRemaining = null,Object? registrationExpiry = freezed,Object? features = null,Object? location = null,Object? availableForTestDrive = null,Object? deliveryAvailable = null,Object? plateNumber = null,Object? orcrNumber = null,Object? registrationStatus = null,Object? emissionTestValid = null,Object? comprehensiveInsurance = null,Object? acceptsTrade = null,Object? financingAvailable = null,Object? priceNegotiable = null,Object? description = null,Object? issues = freezed,Object? images = null,Object? categorizedImages = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? viewCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,sellerName: null == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,variant: null == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,engineSize: null == engineSize ? _self.engineSize : engineSize // ignore: cast_nullable_to_non_nullable
as String,engineType: null == engineType ? _self.engineType : engineType // ignore: cast_nullable_to_non_nullable
as EngineType,cylinders: null == cylinders ? _self.cylinders : cylinders // ignore: cast_nullable_to_non_nullable
as int,horsepower: null == horsepower ? _self.horsepower : horsepower // ignore: cast_nullable_to_non_nullable
as int,torque: null == torque ? _self.torque : torque // ignore: cast_nullable_to_non_nullable
as int,transmission: null == transmission ? _self.transmission : transmission // ignore: cast_nullable_to_non_nullable
as TransmissionType,transmissionSpeeds: null == transmissionSpeeds ? _self.transmissionSpeeds : transmissionSpeeds // ignore: cast_nullable_to_non_nullable
as int,driveType: null == driveType ? _self.driveType : driveType // ignore: cast_nullable_to_non_nullable
as DriveType,fuelType: null == fuelType ? _self.fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as FuelType,fuelConsumption: null == fuelConsumption ? _self.fuelConsumption : fuelConsumption // ignore: cast_nullable_to_non_nullable
as double,electricRange: freezed == electricRange ? _self.electricRange : electricRange // ignore: cast_nullable_to_non_nullable
as int?,batteryCapacity: freezed == batteryCapacity ? _self.batteryCapacity : batteryCapacity // ignore: cast_nullable_to_non_nullable
as double?,chargingTime: freezed == chargingTime ? _self.chargingTime : chargingTime // ignore: cast_nullable_to_non_nullable
as String?,bodyType: null == bodyType ? _self.bodyType : bodyType // ignore: cast_nullable_to_non_nullable
as BodyType,doors: null == doors ? _self.doors : doors // ignore: cast_nullable_to_non_nullable
as int,seats: null == seats ? _self.seats : seats // ignore: cast_nullable_to_non_nullable
as int,curbWeight: null == curbWeight ? _self.curbWeight : curbWeight // ignore: cast_nullable_to_non_nullable
as int,grossWeight: null == grossWeight ? _self.grossWeight : grossWeight // ignore: cast_nullable_to_non_nullable
as int,cargoCapacity: null == cargoCapacity ? _self.cargoCapacity : cargoCapacity // ignore: cast_nullable_to_non_nullable
as int,towingCapacity: freezed == towingCapacity ? _self.towingCapacity : towingCapacity // ignore: cast_nullable_to_non_nullable
as int?,groundClearance: freezed == groundClearance ? _self.groundClearance : groundClearance // ignore: cast_nullable_to_non_nullable
as int?,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,wheelbase: null == wheelbase ? _self.wheelbase : wheelbase // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,paintType: null == paintType ? _self.paintType : paintType // ignore: cast_nullable_to_non_nullable
as PaintType,rimSize: null == rimSize ? _self.rimSize : rimSize // ignore: cast_nullable_to_non_nullable
as int,rimType: null == rimType ? _self.rimType : rimType // ignore: cast_nullable_to_non_nullable
as RimType,tireCondition: null == tireCondition ? _self.tireCondition : tireCondition // ignore: cast_nullable_to_non_nullable
as TireCondition,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as CarCondition,mileage: null == mileage ? _self.mileage : mileage // ignore: cast_nullable_to_non_nullable
as int,numberOfOwners: null == numberOfOwners ? _self.numberOfOwners : numberOfOwners // ignore: cast_nullable_to_non_nullable
as int,hasAccidentHistory: null == hasAccidentHistory ? _self.hasAccidentHistory : hasAccidentHistory // ignore: cast_nullable_to_non_nullable
as bool,floodDamage: null == floodDamage ? _self.floodDamage : floodDamage // ignore: cast_nullable_to_non_nullable
as bool,fireDamage: null == fireDamage ? _self.fireDamage : fireDamage // ignore: cast_nullable_to_non_nullable
as bool,frameDamage: null == frameDamage ? _self.frameDamage : frameDamage // ignore: cast_nullable_to_non_nullable
as bool,isRepainted: null == isRepainted ? _self.isRepainted : isRepainted // ignore: cast_nullable_to_non_nullable
as bool,hasModifications: null == hasModifications ? _self.hasModifications : hasModifications // ignore: cast_nullable_to_non_nullable
as bool,originalParts: null == originalParts ? _self.originalParts : originalParts // ignore: cast_nullable_to_non_nullable
as bool,commercialUse: null == commercialUse ? _self.commercialUse : commercialUse // ignore: cast_nullable_to_non_nullable
as bool,smokerVehicle: null == smokerVehicle ? _self.smokerVehicle : smokerVehicle // ignore: cast_nullable_to_non_nullable
as bool,serviceHistoryComplete: null == serviceHistoryComplete ? _self.serviceHistoryComplete : serviceHistoryComplete // ignore: cast_nullable_to_non_nullable
as bool,warrantyRemaining: null == warrantyRemaining ? _self.warrantyRemaining : warrantyRemaining // ignore: cast_nullable_to_non_nullable
as bool,registrationExpiry: freezed == registrationExpiry ? _self.registrationExpiry : registrationExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as List<String>,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as CarLocation,availableForTestDrive: null == availableForTestDrive ? _self.availableForTestDrive : availableForTestDrive // ignore: cast_nullable_to_non_nullable
as bool,deliveryAvailable: null == deliveryAvailable ? _self.deliveryAvailable : deliveryAvailable // ignore: cast_nullable_to_non_nullable
as bool,plateNumber: null == plateNumber ? _self.plateNumber : plateNumber // ignore: cast_nullable_to_non_nullable
as String,orcrNumber: null == orcrNumber ? _self.orcrNumber : orcrNumber // ignore: cast_nullable_to_non_nullable
as String,registrationStatus: null == registrationStatus ? _self.registrationStatus : registrationStatus // ignore: cast_nullable_to_non_nullable
as RegistrationStatus,emissionTestValid: null == emissionTestValid ? _self.emissionTestValid : emissionTestValid // ignore: cast_nullable_to_non_nullable
as bool,comprehensiveInsurance: null == comprehensiveInsurance ? _self.comprehensiveInsurance : comprehensiveInsurance // ignore: cast_nullable_to_non_nullable
as bool,acceptsTrade: null == acceptsTrade ? _self.acceptsTrade : acceptsTrade // ignore: cast_nullable_to_non_nullable
as bool,financingAvailable: null == financingAvailable ? _self.financingAvailable : financingAvailable // ignore: cast_nullable_to_non_nullable
as bool,priceNegotiable: null == priceNegotiable ? _self.priceNegotiable : priceNegotiable // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,issues: freezed == issues ? _self.issues : issues // ignore: cast_nullable_to_non_nullable
as String?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,categorizedImages: null == categorizedImages ? _self.categorizedImages : categorizedImages // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String sellerId,  String sellerName,  String brand,  String model,  String variant,  int year,  String engineSize,  EngineType engineType,  int cylinders,  int horsepower,  int torque,  TransmissionType transmission,  int transmissionSpeeds,  DriveType driveType,  FuelType fuelType,  double fuelConsumption,  int? electricRange,  double? batteryCapacity,  String? chargingTime,  BodyType bodyType,  int doors,  int seats,  int curbWeight,  int grossWeight,  int cargoCapacity,  int? towingCapacity,  int? groundClearance,  int length,  int width,  int height,  int wheelbase,  String color,  PaintType paintType,  int rimSize,  RimType rimType,  TireCondition tireCondition,  CarCondition condition,  int mileage,  int numberOfOwners,  bool hasAccidentHistory,  bool floodDamage,  bool fireDamage,  bool frameDamage,  bool isRepainted,  bool hasModifications,  bool originalParts,  bool commercialUse,  bool smokerVehicle,  bool serviceHistoryComplete,  bool warrantyRemaining,  DateTime? registrationExpiry,  List<String> features,  CarLocation location,  bool availableForTestDrive,  bool deliveryAvailable,  String plateNumber,  String orcrNumber,  RegistrationStatus registrationStatus,  bool emissionTestValid,  bool comprehensiveInsurance,  bool acceptsTrade,  bool financingAvailable,  bool priceNegotiable,  String description,  String? issues,  List<String> images,  Map<String, List<String>> categorizedImages,  ListingStatus status,  DateTime createdAt,  DateTime updatedAt,  int viewCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CarModel() when $default != null:
return $default(_that.id,_that.sellerId,_that.sellerName,_that.brand,_that.model,_that.variant,_that.year,_that.engineSize,_that.engineType,_that.cylinders,_that.horsepower,_that.torque,_that.transmission,_that.transmissionSpeeds,_that.driveType,_that.fuelType,_that.fuelConsumption,_that.electricRange,_that.batteryCapacity,_that.chargingTime,_that.bodyType,_that.doors,_that.seats,_that.curbWeight,_that.grossWeight,_that.cargoCapacity,_that.towingCapacity,_that.groundClearance,_that.length,_that.width,_that.height,_that.wheelbase,_that.color,_that.paintType,_that.rimSize,_that.rimType,_that.tireCondition,_that.condition,_that.mileage,_that.numberOfOwners,_that.hasAccidentHistory,_that.floodDamage,_that.fireDamage,_that.frameDamage,_that.isRepainted,_that.hasModifications,_that.originalParts,_that.commercialUse,_that.smokerVehicle,_that.serviceHistoryComplete,_that.warrantyRemaining,_that.registrationExpiry,_that.features,_that.location,_that.availableForTestDrive,_that.deliveryAvailable,_that.plateNumber,_that.orcrNumber,_that.registrationStatus,_that.emissionTestValid,_that.comprehensiveInsurance,_that.acceptsTrade,_that.financingAvailable,_that.priceNegotiable,_that.description,_that.issues,_that.images,_that.categorizedImages,_that.status,_that.createdAt,_that.updatedAt,_that.viewCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String sellerId,  String sellerName,  String brand,  String model,  String variant,  int year,  String engineSize,  EngineType engineType,  int cylinders,  int horsepower,  int torque,  TransmissionType transmission,  int transmissionSpeeds,  DriveType driveType,  FuelType fuelType,  double fuelConsumption,  int? electricRange,  double? batteryCapacity,  String? chargingTime,  BodyType bodyType,  int doors,  int seats,  int curbWeight,  int grossWeight,  int cargoCapacity,  int? towingCapacity,  int? groundClearance,  int length,  int width,  int height,  int wheelbase,  String color,  PaintType paintType,  int rimSize,  RimType rimType,  TireCondition tireCondition,  CarCondition condition,  int mileage,  int numberOfOwners,  bool hasAccidentHistory,  bool floodDamage,  bool fireDamage,  bool frameDamage,  bool isRepainted,  bool hasModifications,  bool originalParts,  bool commercialUse,  bool smokerVehicle,  bool serviceHistoryComplete,  bool warrantyRemaining,  DateTime? registrationExpiry,  List<String> features,  CarLocation location,  bool availableForTestDrive,  bool deliveryAvailable,  String plateNumber,  String orcrNumber,  RegistrationStatus registrationStatus,  bool emissionTestValid,  bool comprehensiveInsurance,  bool acceptsTrade,  bool financingAvailable,  bool priceNegotiable,  String description,  String? issues,  List<String> images,  Map<String, List<String>> categorizedImages,  ListingStatus status,  DateTime createdAt,  DateTime updatedAt,  int viewCount)  $default,) {final _that = this;
switch (_that) {
case _CarModel():
return $default(_that.id,_that.sellerId,_that.sellerName,_that.brand,_that.model,_that.variant,_that.year,_that.engineSize,_that.engineType,_that.cylinders,_that.horsepower,_that.torque,_that.transmission,_that.transmissionSpeeds,_that.driveType,_that.fuelType,_that.fuelConsumption,_that.electricRange,_that.batteryCapacity,_that.chargingTime,_that.bodyType,_that.doors,_that.seats,_that.curbWeight,_that.grossWeight,_that.cargoCapacity,_that.towingCapacity,_that.groundClearance,_that.length,_that.width,_that.height,_that.wheelbase,_that.color,_that.paintType,_that.rimSize,_that.rimType,_that.tireCondition,_that.condition,_that.mileage,_that.numberOfOwners,_that.hasAccidentHistory,_that.floodDamage,_that.fireDamage,_that.frameDamage,_that.isRepainted,_that.hasModifications,_that.originalParts,_that.commercialUse,_that.smokerVehicle,_that.serviceHistoryComplete,_that.warrantyRemaining,_that.registrationExpiry,_that.features,_that.location,_that.availableForTestDrive,_that.deliveryAvailable,_that.plateNumber,_that.orcrNumber,_that.registrationStatus,_that.emissionTestValid,_that.comprehensiveInsurance,_that.acceptsTrade,_that.financingAvailable,_that.priceNegotiable,_that.description,_that.issues,_that.images,_that.categorizedImages,_that.status,_that.createdAt,_that.updatedAt,_that.viewCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String sellerId,  String sellerName,  String brand,  String model,  String variant,  int year,  String engineSize,  EngineType engineType,  int cylinders,  int horsepower,  int torque,  TransmissionType transmission,  int transmissionSpeeds,  DriveType driveType,  FuelType fuelType,  double fuelConsumption,  int? electricRange,  double? batteryCapacity,  String? chargingTime,  BodyType bodyType,  int doors,  int seats,  int curbWeight,  int grossWeight,  int cargoCapacity,  int? towingCapacity,  int? groundClearance,  int length,  int width,  int height,  int wheelbase,  String color,  PaintType paintType,  int rimSize,  RimType rimType,  TireCondition tireCondition,  CarCondition condition,  int mileage,  int numberOfOwners,  bool hasAccidentHistory,  bool floodDamage,  bool fireDamage,  bool frameDamage,  bool isRepainted,  bool hasModifications,  bool originalParts,  bool commercialUse,  bool smokerVehicle,  bool serviceHistoryComplete,  bool warrantyRemaining,  DateTime? registrationExpiry,  List<String> features,  CarLocation location,  bool availableForTestDrive,  bool deliveryAvailable,  String plateNumber,  String orcrNumber,  RegistrationStatus registrationStatus,  bool emissionTestValid,  bool comprehensiveInsurance,  bool acceptsTrade,  bool financingAvailable,  bool priceNegotiable,  String description,  String? issues,  List<String> images,  Map<String, List<String>> categorizedImages,  ListingStatus status,  DateTime createdAt,  DateTime updatedAt,  int viewCount)?  $default,) {final _that = this;
switch (_that) {
case _CarModel() when $default != null:
return $default(_that.id,_that.sellerId,_that.sellerName,_that.brand,_that.model,_that.variant,_that.year,_that.engineSize,_that.engineType,_that.cylinders,_that.horsepower,_that.torque,_that.transmission,_that.transmissionSpeeds,_that.driveType,_that.fuelType,_that.fuelConsumption,_that.electricRange,_that.batteryCapacity,_that.chargingTime,_that.bodyType,_that.doors,_that.seats,_that.curbWeight,_that.grossWeight,_that.cargoCapacity,_that.towingCapacity,_that.groundClearance,_that.length,_that.width,_that.height,_that.wheelbase,_that.color,_that.paintType,_that.rimSize,_that.rimType,_that.tireCondition,_that.condition,_that.mileage,_that.numberOfOwners,_that.hasAccidentHistory,_that.floodDamage,_that.fireDamage,_that.frameDamage,_that.isRepainted,_that.hasModifications,_that.originalParts,_that.commercialUse,_that.smokerVehicle,_that.serviceHistoryComplete,_that.warrantyRemaining,_that.registrationExpiry,_that.features,_that.location,_that.availableForTestDrive,_that.deliveryAvailable,_that.plateNumber,_that.orcrNumber,_that.registrationStatus,_that.emissionTestValid,_that.comprehensiveInsurance,_that.acceptsTrade,_that.financingAvailable,_that.priceNegotiable,_that.description,_that.issues,_that.images,_that.categorizedImages,_that.status,_that.createdAt,_that.updatedAt,_that.viewCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CarModel implements CarModel {
  const _CarModel({required this.id, required this.sellerId, required this.sellerName, required this.brand, required this.model, required this.variant, required this.year, required this.engineSize, required this.engineType, required this.cylinders, required this.horsepower, required this.torque, required this.transmission, required this.transmissionSpeeds, required this.driveType, required this.fuelType, required this.fuelConsumption, this.electricRange, this.batteryCapacity, this.chargingTime, required this.bodyType, required this.doors, required this.seats, required this.curbWeight, required this.grossWeight, required this.cargoCapacity, this.towingCapacity, this.groundClearance, required this.length, required this.width, required this.height, required this.wheelbase, required this.color, required this.paintType, required this.rimSize, required this.rimType, required this.tireCondition, required this.condition, required this.mileage, required this.numberOfOwners, required this.hasAccidentHistory, required this.floodDamage, this.fireDamage = false, this.frameDamage = false, this.isRepainted = false, this.hasModifications = false, this.originalParts = true, this.commercialUse = false, this.smokerVehicle = false, required this.serviceHistoryComplete, required this.warrantyRemaining, this.registrationExpiry, final  List<String> features = const [], required this.location, this.availableForTestDrive = false, this.deliveryAvailable = false, required this.plateNumber, required this.orcrNumber, required this.registrationStatus, required this.emissionTestValid, required this.comprehensiveInsurance, this.acceptsTrade = false, this.financingAvailable = false, this.priceNegotiable = false, required this.description, this.issues, required final  List<String> images, required final  Map<String, List<String>> categorizedImages, required this.status, required this.createdAt, required this.updatedAt, this.viewCount = 0}): _features = features,_images = images,_categorizedImages = categorizedImages;
  factory _CarModel.fromJson(Map<String, dynamic> json) => _$CarModelFromJson(json);

@override final  String id;
@override final  String sellerId;
@override final  String sellerName;
// BASIC INFO
@override final  String brand;
@override final  String model;
@override final  String variant;
@override final  int year;
// MECHANICAL
@override final  String engineSize;
@override final  EngineType engineType;
@override final  int cylinders;
@override final  int horsepower;
@override final  int torque;
@override final  TransmissionType transmission;
@override final  int transmissionSpeeds;
@override final  DriveType driveType;
@override final  FuelType fuelType;
@override final  double fuelConsumption;
@override final  int? electricRange;
@override final  double? batteryCapacity;
@override final  String? chargingTime;
// DIMENSIONS & CAPACITY
@override final  BodyType bodyType;
@override final  int doors;
@override final  int seats;
@override final  int curbWeight;
@override final  int grossWeight;
@override final  int cargoCapacity;
@override final  int? towingCapacity;
@override final  int? groundClearance;
@override final  int length;
@override final  int width;
@override final  int height;
@override final  int wheelbase;
// EXTERIOR
@override final  String color;
@override final  PaintType paintType;
@override final  int rimSize;
@override final  RimType rimType;
@override final  TireCondition tireCondition;
// CONDITION & HISTORY
@override final  CarCondition condition;
@override final  int mileage;
@override final  int numberOfOwners;
@override final  bool hasAccidentHistory;
@override final  bool floodDamage;
@override@JsonKey() final  bool fireDamage;
@override@JsonKey() final  bool frameDamage;
@override@JsonKey() final  bool isRepainted;
@override@JsonKey() final  bool hasModifications;
@override@JsonKey() final  bool originalParts;
@override@JsonKey() final  bool commercialUse;
@override@JsonKey() final  bool smokerVehicle;
@override final  bool serviceHistoryComplete;
@override final  bool warrantyRemaining;
@override final  DateTime? registrationExpiry;
// FEATURES & TECHNOLOGY
 final  List<String> _features;
// FEATURES & TECHNOLOGY
@override@JsonKey() List<String> get features {
  if (_features is EqualUnmodifiableListView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_features);
}

// LOCATION & AVAILABILITY
@override final  CarLocation location;
@override@JsonKey() final  bool availableForTestDrive;
@override@JsonKey() final  bool deliveryAvailable;
// DOCUMENTATION
@override final  String plateNumber;
@override final  String orcrNumber;
@override final  RegistrationStatus registrationStatus;
@override final  bool emissionTestValid;
@override final  bool comprehensiveInsurance;
// SELLER PREFERENCES
@override@JsonKey() final  bool acceptsTrade;
@override@JsonKey() final  bool financingAvailable;
@override@JsonKey() final  bool priceNegotiable;
// DESCRIPTION
@override final  String description;
@override final  String? issues;
// MEDIA & STATUS
 final  List<String> _images;
// MEDIA & STATUS
@override List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

 final  Map<String, List<String>> _categorizedImages;
@override Map<String, List<String>> get categorizedImages {
  if (_categorizedImages is EqualUnmodifiableMapView) return _categorizedImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_categorizedImages);
}

@override final  ListingStatus status;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  int viewCount;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CarModel&&(identical(other.id, id) || other.id == id)&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId)&&(identical(other.sellerName, sellerName) || other.sellerName == sellerName)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.model, model) || other.model == model)&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.year, year) || other.year == year)&&(identical(other.engineSize, engineSize) || other.engineSize == engineSize)&&(identical(other.engineType, engineType) || other.engineType == engineType)&&(identical(other.cylinders, cylinders) || other.cylinders == cylinders)&&(identical(other.horsepower, horsepower) || other.horsepower == horsepower)&&(identical(other.torque, torque) || other.torque == torque)&&(identical(other.transmission, transmission) || other.transmission == transmission)&&(identical(other.transmissionSpeeds, transmissionSpeeds) || other.transmissionSpeeds == transmissionSpeeds)&&(identical(other.driveType, driveType) || other.driveType == driveType)&&(identical(other.fuelType, fuelType) || other.fuelType == fuelType)&&(identical(other.fuelConsumption, fuelConsumption) || other.fuelConsumption == fuelConsumption)&&(identical(other.electricRange, electricRange) || other.electricRange == electricRange)&&(identical(other.batteryCapacity, batteryCapacity) || other.batteryCapacity == batteryCapacity)&&(identical(other.chargingTime, chargingTime) || other.chargingTime == chargingTime)&&(identical(other.bodyType, bodyType) || other.bodyType == bodyType)&&(identical(other.doors, doors) || other.doors == doors)&&(identical(other.seats, seats) || other.seats == seats)&&(identical(other.curbWeight, curbWeight) || other.curbWeight == curbWeight)&&(identical(other.grossWeight, grossWeight) || other.grossWeight == grossWeight)&&(identical(other.cargoCapacity, cargoCapacity) || other.cargoCapacity == cargoCapacity)&&(identical(other.towingCapacity, towingCapacity) || other.towingCapacity == towingCapacity)&&(identical(other.groundClearance, groundClearance) || other.groundClearance == groundClearance)&&(identical(other.length, length) || other.length == length)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.wheelbase, wheelbase) || other.wheelbase == wheelbase)&&(identical(other.color, color) || other.color == color)&&(identical(other.paintType, paintType) || other.paintType == paintType)&&(identical(other.rimSize, rimSize) || other.rimSize == rimSize)&&(identical(other.rimType, rimType) || other.rimType == rimType)&&(identical(other.tireCondition, tireCondition) || other.tireCondition == tireCondition)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.mileage, mileage) || other.mileage == mileage)&&(identical(other.numberOfOwners, numberOfOwners) || other.numberOfOwners == numberOfOwners)&&(identical(other.hasAccidentHistory, hasAccidentHistory) || other.hasAccidentHistory == hasAccidentHistory)&&(identical(other.floodDamage, floodDamage) || other.floodDamage == floodDamage)&&(identical(other.fireDamage, fireDamage) || other.fireDamage == fireDamage)&&(identical(other.frameDamage, frameDamage) || other.frameDamage == frameDamage)&&(identical(other.isRepainted, isRepainted) || other.isRepainted == isRepainted)&&(identical(other.hasModifications, hasModifications) || other.hasModifications == hasModifications)&&(identical(other.originalParts, originalParts) || other.originalParts == originalParts)&&(identical(other.commercialUse, commercialUse) || other.commercialUse == commercialUse)&&(identical(other.smokerVehicle, smokerVehicle) || other.smokerVehicle == smokerVehicle)&&(identical(other.serviceHistoryComplete, serviceHistoryComplete) || other.serviceHistoryComplete == serviceHistoryComplete)&&(identical(other.warrantyRemaining, warrantyRemaining) || other.warrantyRemaining == warrantyRemaining)&&(identical(other.registrationExpiry, registrationExpiry) || other.registrationExpiry == registrationExpiry)&&const DeepCollectionEquality().equals(other._features, _features)&&(identical(other.location, location) || other.location == location)&&(identical(other.availableForTestDrive, availableForTestDrive) || other.availableForTestDrive == availableForTestDrive)&&(identical(other.deliveryAvailable, deliveryAvailable) || other.deliveryAvailable == deliveryAvailable)&&(identical(other.plateNumber, plateNumber) || other.plateNumber == plateNumber)&&(identical(other.orcrNumber, orcrNumber) || other.orcrNumber == orcrNumber)&&(identical(other.registrationStatus, registrationStatus) || other.registrationStatus == registrationStatus)&&(identical(other.emissionTestValid, emissionTestValid) || other.emissionTestValid == emissionTestValid)&&(identical(other.comprehensiveInsurance, comprehensiveInsurance) || other.comprehensiveInsurance == comprehensiveInsurance)&&(identical(other.acceptsTrade, acceptsTrade) || other.acceptsTrade == acceptsTrade)&&(identical(other.financingAvailable, financingAvailable) || other.financingAvailable == financingAvailable)&&(identical(other.priceNegotiable, priceNegotiable) || other.priceNegotiable == priceNegotiable)&&(identical(other.description, description) || other.description == description)&&(identical(other.issues, issues) || other.issues == issues)&&const DeepCollectionEquality().equals(other._images, _images)&&const DeepCollectionEquality().equals(other._categorizedImages, _categorizedImages)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,sellerId,sellerName,brand,model,variant,year,engineSize,engineType,cylinders,horsepower,torque,transmission,transmissionSpeeds,driveType,fuelType,fuelConsumption,electricRange,batteryCapacity,chargingTime,bodyType,doors,seats,curbWeight,grossWeight,cargoCapacity,towingCapacity,groundClearance,length,width,height,wheelbase,color,paintType,rimSize,rimType,tireCondition,condition,mileage,numberOfOwners,hasAccidentHistory,floodDamage,fireDamage,frameDamage,isRepainted,hasModifications,originalParts,commercialUse,smokerVehicle,serviceHistoryComplete,warrantyRemaining,registrationExpiry,const DeepCollectionEquality().hash(_features),location,availableForTestDrive,deliveryAvailable,plateNumber,orcrNumber,registrationStatus,emissionTestValid,comprehensiveInsurance,acceptsTrade,financingAvailable,priceNegotiable,description,issues,const DeepCollectionEquality().hash(_images),const DeepCollectionEquality().hash(_categorizedImages),status,createdAt,updatedAt,viewCount]);

@override
String toString() {
  return 'CarModel(id: $id, sellerId: $sellerId, sellerName: $sellerName, brand: $brand, model: $model, variant: $variant, year: $year, engineSize: $engineSize, engineType: $engineType, cylinders: $cylinders, horsepower: $horsepower, torque: $torque, transmission: $transmission, transmissionSpeeds: $transmissionSpeeds, driveType: $driveType, fuelType: $fuelType, fuelConsumption: $fuelConsumption, electricRange: $electricRange, batteryCapacity: $batteryCapacity, chargingTime: $chargingTime, bodyType: $bodyType, doors: $doors, seats: $seats, curbWeight: $curbWeight, grossWeight: $grossWeight, cargoCapacity: $cargoCapacity, towingCapacity: $towingCapacity, groundClearance: $groundClearance, length: $length, width: $width, height: $height, wheelbase: $wheelbase, color: $color, paintType: $paintType, rimSize: $rimSize, rimType: $rimType, tireCondition: $tireCondition, condition: $condition, mileage: $mileage, numberOfOwners: $numberOfOwners, hasAccidentHistory: $hasAccidentHistory, floodDamage: $floodDamage, fireDamage: $fireDamage, frameDamage: $frameDamage, isRepainted: $isRepainted, hasModifications: $hasModifications, originalParts: $originalParts, commercialUse: $commercialUse, smokerVehicle: $smokerVehicle, serviceHistoryComplete: $serviceHistoryComplete, warrantyRemaining: $warrantyRemaining, registrationExpiry: $registrationExpiry, features: $features, location: $location, availableForTestDrive: $availableForTestDrive, deliveryAvailable: $deliveryAvailable, plateNumber: $plateNumber, orcrNumber: $orcrNumber, registrationStatus: $registrationStatus, emissionTestValid: $emissionTestValid, comprehensiveInsurance: $comprehensiveInsurance, acceptsTrade: $acceptsTrade, financingAvailable: $financingAvailable, priceNegotiable: $priceNegotiable, description: $description, issues: $issues, images: $images, categorizedImages: $categorizedImages, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, viewCount: $viewCount)';
}


}

/// @nodoc
abstract mixin class _$CarModelCopyWith<$Res> implements $CarModelCopyWith<$Res> {
  factory _$CarModelCopyWith(_CarModel value, $Res Function(_CarModel) _then) = __$CarModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String sellerId, String sellerName, String brand, String model, String variant, int year, String engineSize, EngineType engineType, int cylinders, int horsepower, int torque, TransmissionType transmission, int transmissionSpeeds, DriveType driveType, FuelType fuelType, double fuelConsumption, int? electricRange, double? batteryCapacity, String? chargingTime, BodyType bodyType, int doors, int seats, int curbWeight, int grossWeight, int cargoCapacity, int? towingCapacity, int? groundClearance, int length, int width, int height, int wheelbase, String color, PaintType paintType, int rimSize, RimType rimType, TireCondition tireCondition, CarCondition condition, int mileage, int numberOfOwners, bool hasAccidentHistory, bool floodDamage, bool fireDamage, bool frameDamage, bool isRepainted, bool hasModifications, bool originalParts, bool commercialUse, bool smokerVehicle, bool serviceHistoryComplete, bool warrantyRemaining, DateTime? registrationExpiry, List<String> features, CarLocation location, bool availableForTestDrive, bool deliveryAvailable, String plateNumber, String orcrNumber, RegistrationStatus registrationStatus, bool emissionTestValid, bool comprehensiveInsurance, bool acceptsTrade, bool financingAvailable, bool priceNegotiable, String description, String? issues, List<String> images, Map<String, List<String>> categorizedImages, ListingStatus status, DateTime createdAt, DateTime updatedAt, int viewCount
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sellerId = null,Object? sellerName = null,Object? brand = null,Object? model = null,Object? variant = null,Object? year = null,Object? engineSize = null,Object? engineType = null,Object? cylinders = null,Object? horsepower = null,Object? torque = null,Object? transmission = null,Object? transmissionSpeeds = null,Object? driveType = null,Object? fuelType = null,Object? fuelConsumption = null,Object? electricRange = freezed,Object? batteryCapacity = freezed,Object? chargingTime = freezed,Object? bodyType = null,Object? doors = null,Object? seats = null,Object? curbWeight = null,Object? grossWeight = null,Object? cargoCapacity = null,Object? towingCapacity = freezed,Object? groundClearance = freezed,Object? length = null,Object? width = null,Object? height = null,Object? wheelbase = null,Object? color = null,Object? paintType = null,Object? rimSize = null,Object? rimType = null,Object? tireCondition = null,Object? condition = null,Object? mileage = null,Object? numberOfOwners = null,Object? hasAccidentHistory = null,Object? floodDamage = null,Object? fireDamage = null,Object? frameDamage = null,Object? isRepainted = null,Object? hasModifications = null,Object? originalParts = null,Object? commercialUse = null,Object? smokerVehicle = null,Object? serviceHistoryComplete = null,Object? warrantyRemaining = null,Object? registrationExpiry = freezed,Object? features = null,Object? location = null,Object? availableForTestDrive = null,Object? deliveryAvailable = null,Object? plateNumber = null,Object? orcrNumber = null,Object? registrationStatus = null,Object? emissionTestValid = null,Object? comprehensiveInsurance = null,Object? acceptsTrade = null,Object? financingAvailable = null,Object? priceNegotiable = null,Object? description = null,Object? issues = freezed,Object? images = null,Object? categorizedImages = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? viewCount = null,}) {
  return _then(_CarModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as String,sellerName: null == sellerName ? _self.sellerName : sellerName // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,variant: null == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,engineSize: null == engineSize ? _self.engineSize : engineSize // ignore: cast_nullable_to_non_nullable
as String,engineType: null == engineType ? _self.engineType : engineType // ignore: cast_nullable_to_non_nullable
as EngineType,cylinders: null == cylinders ? _self.cylinders : cylinders // ignore: cast_nullable_to_non_nullable
as int,horsepower: null == horsepower ? _self.horsepower : horsepower // ignore: cast_nullable_to_non_nullable
as int,torque: null == torque ? _self.torque : torque // ignore: cast_nullable_to_non_nullable
as int,transmission: null == transmission ? _self.transmission : transmission // ignore: cast_nullable_to_non_nullable
as TransmissionType,transmissionSpeeds: null == transmissionSpeeds ? _self.transmissionSpeeds : transmissionSpeeds // ignore: cast_nullable_to_non_nullable
as int,driveType: null == driveType ? _self.driveType : driveType // ignore: cast_nullable_to_non_nullable
as DriveType,fuelType: null == fuelType ? _self.fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as FuelType,fuelConsumption: null == fuelConsumption ? _self.fuelConsumption : fuelConsumption // ignore: cast_nullable_to_non_nullable
as double,electricRange: freezed == electricRange ? _self.electricRange : electricRange // ignore: cast_nullable_to_non_nullable
as int?,batteryCapacity: freezed == batteryCapacity ? _self.batteryCapacity : batteryCapacity // ignore: cast_nullable_to_non_nullable
as double?,chargingTime: freezed == chargingTime ? _self.chargingTime : chargingTime // ignore: cast_nullable_to_non_nullable
as String?,bodyType: null == bodyType ? _self.bodyType : bodyType // ignore: cast_nullable_to_non_nullable
as BodyType,doors: null == doors ? _self.doors : doors // ignore: cast_nullable_to_non_nullable
as int,seats: null == seats ? _self.seats : seats // ignore: cast_nullable_to_non_nullable
as int,curbWeight: null == curbWeight ? _self.curbWeight : curbWeight // ignore: cast_nullable_to_non_nullable
as int,grossWeight: null == grossWeight ? _self.grossWeight : grossWeight // ignore: cast_nullable_to_non_nullable
as int,cargoCapacity: null == cargoCapacity ? _self.cargoCapacity : cargoCapacity // ignore: cast_nullable_to_non_nullable
as int,towingCapacity: freezed == towingCapacity ? _self.towingCapacity : towingCapacity // ignore: cast_nullable_to_non_nullable
as int?,groundClearance: freezed == groundClearance ? _self.groundClearance : groundClearance // ignore: cast_nullable_to_non_nullable
as int?,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as int,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,wheelbase: null == wheelbase ? _self.wheelbase : wheelbase // ignore: cast_nullable_to_non_nullable
as int,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,paintType: null == paintType ? _self.paintType : paintType // ignore: cast_nullable_to_non_nullable
as PaintType,rimSize: null == rimSize ? _self.rimSize : rimSize // ignore: cast_nullable_to_non_nullable
as int,rimType: null == rimType ? _self.rimType : rimType // ignore: cast_nullable_to_non_nullable
as RimType,tireCondition: null == tireCondition ? _self.tireCondition : tireCondition // ignore: cast_nullable_to_non_nullable
as TireCondition,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as CarCondition,mileage: null == mileage ? _self.mileage : mileage // ignore: cast_nullable_to_non_nullable
as int,numberOfOwners: null == numberOfOwners ? _self.numberOfOwners : numberOfOwners // ignore: cast_nullable_to_non_nullable
as int,hasAccidentHistory: null == hasAccidentHistory ? _self.hasAccidentHistory : hasAccidentHistory // ignore: cast_nullable_to_non_nullable
as bool,floodDamage: null == floodDamage ? _self.floodDamage : floodDamage // ignore: cast_nullable_to_non_nullable
as bool,fireDamage: null == fireDamage ? _self.fireDamage : fireDamage // ignore: cast_nullable_to_non_nullable
as bool,frameDamage: null == frameDamage ? _self.frameDamage : frameDamage // ignore: cast_nullable_to_non_nullable
as bool,isRepainted: null == isRepainted ? _self.isRepainted : isRepainted // ignore: cast_nullable_to_non_nullable
as bool,hasModifications: null == hasModifications ? _self.hasModifications : hasModifications // ignore: cast_nullable_to_non_nullable
as bool,originalParts: null == originalParts ? _self.originalParts : originalParts // ignore: cast_nullable_to_non_nullable
as bool,commercialUse: null == commercialUse ? _self.commercialUse : commercialUse // ignore: cast_nullable_to_non_nullable
as bool,smokerVehicle: null == smokerVehicle ? _self.smokerVehicle : smokerVehicle // ignore: cast_nullable_to_non_nullable
as bool,serviceHistoryComplete: null == serviceHistoryComplete ? _self.serviceHistoryComplete : serviceHistoryComplete // ignore: cast_nullable_to_non_nullable
as bool,warrantyRemaining: null == warrantyRemaining ? _self.warrantyRemaining : warrantyRemaining // ignore: cast_nullable_to_non_nullable
as bool,registrationExpiry: freezed == registrationExpiry ? _self.registrationExpiry : registrationExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as List<String>,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as CarLocation,availableForTestDrive: null == availableForTestDrive ? _self.availableForTestDrive : availableForTestDrive // ignore: cast_nullable_to_non_nullable
as bool,deliveryAvailable: null == deliveryAvailable ? _self.deliveryAvailable : deliveryAvailable // ignore: cast_nullable_to_non_nullable
as bool,plateNumber: null == plateNumber ? _self.plateNumber : plateNumber // ignore: cast_nullable_to_non_nullable
as String,orcrNumber: null == orcrNumber ? _self.orcrNumber : orcrNumber // ignore: cast_nullable_to_non_nullable
as String,registrationStatus: null == registrationStatus ? _self.registrationStatus : registrationStatus // ignore: cast_nullable_to_non_nullable
as RegistrationStatus,emissionTestValid: null == emissionTestValid ? _self.emissionTestValid : emissionTestValid // ignore: cast_nullable_to_non_nullable
as bool,comprehensiveInsurance: null == comprehensiveInsurance ? _self.comprehensiveInsurance : comprehensiveInsurance // ignore: cast_nullable_to_non_nullable
as bool,acceptsTrade: null == acceptsTrade ? _self.acceptsTrade : acceptsTrade // ignore: cast_nullable_to_non_nullable
as bool,financingAvailable: null == financingAvailable ? _self.financingAvailable : financingAvailable // ignore: cast_nullable_to_non_nullable
as bool,priceNegotiable: null == priceNegotiable ? _self.priceNegotiable : priceNegotiable // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,issues: freezed == issues ? _self.issues : issues // ignore: cast_nullable_to_non_nullable
as String?,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,categorizedImages: null == categorizedImages ? _self._categorizedImages : categorizedImages // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
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
