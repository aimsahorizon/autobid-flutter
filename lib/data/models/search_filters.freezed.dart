// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_filters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchFilters {

// Basic
 String? get keyword; List<String> get brands; int? get yearMin; int? get yearMax; double? get priceMin; double? get priceMax; List<BodyType> get bodyType;// Mechanical
 List<String> get engineSizes; List<EngineType> get engineTypes; List<int> get cylinders; int? get horsepowerMin; int? get horsepowerMax; int? get torqueMin; int? get torqueMax; List<TransmissionType> get transmission; List<int> get transmissionSpeeds; List<DriveType> get driveTypes; List<FuelType> get fuelType; double? get fuelConsumptionMax; int? get electricRangeMin;// Dimensions & Capacity
 List<int> get seats; List<int> get doors; int? get curbWeightMin; int? get curbWeightMax; int? get cargoCapacityMin; int? get groundClearanceMin;// Exterior
 List<String> get colors; List<int> get rimSizes; List<PaintType> get paintTypes;// Condition
 int? get mileageMax; int? get ownersMax; bool get accidentFree; bool get floodFree; bool get withWarranty; bool get completeServiceHistory;// Features (select any from comprehensive list)
 List<String> get features;// Safety
 int? get minAirbags; bool get hasABS; bool get hasCameras; bool get hasBlindSpot; bool get hasLaneAssist; bool get hasAdaptiveCruise;// Comfort & Technology
 bool get hasClimateControl; bool get hasSunroof; bool get hasLeatherSeats; bool get hasPowerSeats; int? get minInfotainmentSize; bool get hasCarPlay; bool get hasAndroidAuto; bool get hasNavigation; bool get hasWirelessCharging; bool get hasPremiumAudio;// Location & Availability
 String? get city; String? get province; bool get testDriveAvailable; bool get deliveryAvailable;// Other
 bool get acceptsTrade; bool get financingAvailable; bool get negotiable; bool get auctionsOnly;// Sort
 SortBy get sortBy;
/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchFiltersCopyWith<SearchFilters> get copyWith => _$SearchFiltersCopyWithImpl<SearchFilters>(this as SearchFilters, _$identity);

  /// Serializes this SearchFilters to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchFilters&&(identical(other.keyword, keyword) || other.keyword == keyword)&&const DeepCollectionEquality().equals(other.brands, brands)&&(identical(other.yearMin, yearMin) || other.yearMin == yearMin)&&(identical(other.yearMax, yearMax) || other.yearMax == yearMax)&&(identical(other.priceMin, priceMin) || other.priceMin == priceMin)&&(identical(other.priceMax, priceMax) || other.priceMax == priceMax)&&const DeepCollectionEquality().equals(other.bodyType, bodyType)&&const DeepCollectionEquality().equals(other.engineSizes, engineSizes)&&const DeepCollectionEquality().equals(other.engineTypes, engineTypes)&&const DeepCollectionEquality().equals(other.cylinders, cylinders)&&(identical(other.horsepowerMin, horsepowerMin) || other.horsepowerMin == horsepowerMin)&&(identical(other.horsepowerMax, horsepowerMax) || other.horsepowerMax == horsepowerMax)&&(identical(other.torqueMin, torqueMin) || other.torqueMin == torqueMin)&&(identical(other.torqueMax, torqueMax) || other.torqueMax == torqueMax)&&const DeepCollectionEquality().equals(other.transmission, transmission)&&const DeepCollectionEquality().equals(other.transmissionSpeeds, transmissionSpeeds)&&const DeepCollectionEquality().equals(other.driveTypes, driveTypes)&&const DeepCollectionEquality().equals(other.fuelType, fuelType)&&(identical(other.fuelConsumptionMax, fuelConsumptionMax) || other.fuelConsumptionMax == fuelConsumptionMax)&&(identical(other.electricRangeMin, electricRangeMin) || other.electricRangeMin == electricRangeMin)&&const DeepCollectionEquality().equals(other.seats, seats)&&const DeepCollectionEquality().equals(other.doors, doors)&&(identical(other.curbWeightMin, curbWeightMin) || other.curbWeightMin == curbWeightMin)&&(identical(other.curbWeightMax, curbWeightMax) || other.curbWeightMax == curbWeightMax)&&(identical(other.cargoCapacityMin, cargoCapacityMin) || other.cargoCapacityMin == cargoCapacityMin)&&(identical(other.groundClearanceMin, groundClearanceMin) || other.groundClearanceMin == groundClearanceMin)&&const DeepCollectionEquality().equals(other.colors, colors)&&const DeepCollectionEquality().equals(other.rimSizes, rimSizes)&&const DeepCollectionEquality().equals(other.paintTypes, paintTypes)&&(identical(other.mileageMax, mileageMax) || other.mileageMax == mileageMax)&&(identical(other.ownersMax, ownersMax) || other.ownersMax == ownersMax)&&(identical(other.accidentFree, accidentFree) || other.accidentFree == accidentFree)&&(identical(other.floodFree, floodFree) || other.floodFree == floodFree)&&(identical(other.withWarranty, withWarranty) || other.withWarranty == withWarranty)&&(identical(other.completeServiceHistory, completeServiceHistory) || other.completeServiceHistory == completeServiceHistory)&&const DeepCollectionEquality().equals(other.features, features)&&(identical(other.minAirbags, minAirbags) || other.minAirbags == minAirbags)&&(identical(other.hasABS, hasABS) || other.hasABS == hasABS)&&(identical(other.hasCameras, hasCameras) || other.hasCameras == hasCameras)&&(identical(other.hasBlindSpot, hasBlindSpot) || other.hasBlindSpot == hasBlindSpot)&&(identical(other.hasLaneAssist, hasLaneAssist) || other.hasLaneAssist == hasLaneAssist)&&(identical(other.hasAdaptiveCruise, hasAdaptiveCruise) || other.hasAdaptiveCruise == hasAdaptiveCruise)&&(identical(other.hasClimateControl, hasClimateControl) || other.hasClimateControl == hasClimateControl)&&(identical(other.hasSunroof, hasSunroof) || other.hasSunroof == hasSunroof)&&(identical(other.hasLeatherSeats, hasLeatherSeats) || other.hasLeatherSeats == hasLeatherSeats)&&(identical(other.hasPowerSeats, hasPowerSeats) || other.hasPowerSeats == hasPowerSeats)&&(identical(other.minInfotainmentSize, minInfotainmentSize) || other.minInfotainmentSize == minInfotainmentSize)&&(identical(other.hasCarPlay, hasCarPlay) || other.hasCarPlay == hasCarPlay)&&(identical(other.hasAndroidAuto, hasAndroidAuto) || other.hasAndroidAuto == hasAndroidAuto)&&(identical(other.hasNavigation, hasNavigation) || other.hasNavigation == hasNavigation)&&(identical(other.hasWirelessCharging, hasWirelessCharging) || other.hasWirelessCharging == hasWirelessCharging)&&(identical(other.hasPremiumAudio, hasPremiumAudio) || other.hasPremiumAudio == hasPremiumAudio)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.testDriveAvailable, testDriveAvailable) || other.testDriveAvailable == testDriveAvailable)&&(identical(other.deliveryAvailable, deliveryAvailable) || other.deliveryAvailable == deliveryAvailable)&&(identical(other.acceptsTrade, acceptsTrade) || other.acceptsTrade == acceptsTrade)&&(identical(other.financingAvailable, financingAvailable) || other.financingAvailable == financingAvailable)&&(identical(other.negotiable, negotiable) || other.negotiable == negotiable)&&(identical(other.auctionsOnly, auctionsOnly) || other.auctionsOnly == auctionsOnly)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,keyword,const DeepCollectionEquality().hash(brands),yearMin,yearMax,priceMin,priceMax,const DeepCollectionEquality().hash(bodyType),const DeepCollectionEquality().hash(engineSizes),const DeepCollectionEquality().hash(engineTypes),const DeepCollectionEquality().hash(cylinders),horsepowerMin,horsepowerMax,torqueMin,torqueMax,const DeepCollectionEquality().hash(transmission),const DeepCollectionEquality().hash(transmissionSpeeds),const DeepCollectionEquality().hash(driveTypes),const DeepCollectionEquality().hash(fuelType),fuelConsumptionMax,electricRangeMin,const DeepCollectionEquality().hash(seats),const DeepCollectionEquality().hash(doors),curbWeightMin,curbWeightMax,cargoCapacityMin,groundClearanceMin,const DeepCollectionEquality().hash(colors),const DeepCollectionEquality().hash(rimSizes),const DeepCollectionEquality().hash(paintTypes),mileageMax,ownersMax,accidentFree,floodFree,withWarranty,completeServiceHistory,const DeepCollectionEquality().hash(features),minAirbags,hasABS,hasCameras,hasBlindSpot,hasLaneAssist,hasAdaptiveCruise,hasClimateControl,hasSunroof,hasLeatherSeats,hasPowerSeats,minInfotainmentSize,hasCarPlay,hasAndroidAuto,hasNavigation,hasWirelessCharging,hasPremiumAudio,city,province,testDriveAvailable,deliveryAvailable,acceptsTrade,financingAvailable,negotiable,auctionsOnly,sortBy]);

@override
String toString() {
  return 'SearchFilters(keyword: $keyword, brands: $brands, yearMin: $yearMin, yearMax: $yearMax, priceMin: $priceMin, priceMax: $priceMax, bodyType: $bodyType, engineSizes: $engineSizes, engineTypes: $engineTypes, cylinders: $cylinders, horsepowerMin: $horsepowerMin, horsepowerMax: $horsepowerMax, torqueMin: $torqueMin, torqueMax: $torqueMax, transmission: $transmission, transmissionSpeeds: $transmissionSpeeds, driveTypes: $driveTypes, fuelType: $fuelType, fuelConsumptionMax: $fuelConsumptionMax, electricRangeMin: $electricRangeMin, seats: $seats, doors: $doors, curbWeightMin: $curbWeightMin, curbWeightMax: $curbWeightMax, cargoCapacityMin: $cargoCapacityMin, groundClearanceMin: $groundClearanceMin, colors: $colors, rimSizes: $rimSizes, paintTypes: $paintTypes, mileageMax: $mileageMax, ownersMax: $ownersMax, accidentFree: $accidentFree, floodFree: $floodFree, withWarranty: $withWarranty, completeServiceHistory: $completeServiceHistory, features: $features, minAirbags: $minAirbags, hasABS: $hasABS, hasCameras: $hasCameras, hasBlindSpot: $hasBlindSpot, hasLaneAssist: $hasLaneAssist, hasAdaptiveCruise: $hasAdaptiveCruise, hasClimateControl: $hasClimateControl, hasSunroof: $hasSunroof, hasLeatherSeats: $hasLeatherSeats, hasPowerSeats: $hasPowerSeats, minInfotainmentSize: $minInfotainmentSize, hasCarPlay: $hasCarPlay, hasAndroidAuto: $hasAndroidAuto, hasNavigation: $hasNavigation, hasWirelessCharging: $hasWirelessCharging, hasPremiumAudio: $hasPremiumAudio, city: $city, province: $province, testDriveAvailable: $testDriveAvailable, deliveryAvailable: $deliveryAvailable, acceptsTrade: $acceptsTrade, financingAvailable: $financingAvailable, negotiable: $negotiable, auctionsOnly: $auctionsOnly, sortBy: $sortBy)';
}


}

/// @nodoc
abstract mixin class $SearchFiltersCopyWith<$Res>  {
  factory $SearchFiltersCopyWith(SearchFilters value, $Res Function(SearchFilters) _then) = _$SearchFiltersCopyWithImpl;
@useResult
$Res call({
 String? keyword, List<String> brands, int? yearMin, int? yearMax, double? priceMin, double? priceMax, List<BodyType> bodyType, List<String> engineSizes, List<EngineType> engineTypes, List<int> cylinders, int? horsepowerMin, int? horsepowerMax, int? torqueMin, int? torqueMax, List<TransmissionType> transmission, List<int> transmissionSpeeds, List<DriveType> driveTypes, List<FuelType> fuelType, double? fuelConsumptionMax, int? electricRangeMin, List<int> seats, List<int> doors, int? curbWeightMin, int? curbWeightMax, int? cargoCapacityMin, int? groundClearanceMin, List<String> colors, List<int> rimSizes, List<PaintType> paintTypes, int? mileageMax, int? ownersMax, bool accidentFree, bool floodFree, bool withWarranty, bool completeServiceHistory, List<String> features, int? minAirbags, bool hasABS, bool hasCameras, bool hasBlindSpot, bool hasLaneAssist, bool hasAdaptiveCruise, bool hasClimateControl, bool hasSunroof, bool hasLeatherSeats, bool hasPowerSeats, int? minInfotainmentSize, bool hasCarPlay, bool hasAndroidAuto, bool hasNavigation, bool hasWirelessCharging, bool hasPremiumAudio, String? city, String? province, bool testDriveAvailable, bool deliveryAvailable, bool acceptsTrade, bool financingAvailable, bool negotiable, bool auctionsOnly, SortBy sortBy
});




}
/// @nodoc
class _$SearchFiltersCopyWithImpl<$Res>
    implements $SearchFiltersCopyWith<$Res> {
  _$SearchFiltersCopyWithImpl(this._self, this._then);

  final SearchFilters _self;
  final $Res Function(SearchFilters) _then;

/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? keyword = freezed,Object? brands = null,Object? yearMin = freezed,Object? yearMax = freezed,Object? priceMin = freezed,Object? priceMax = freezed,Object? bodyType = null,Object? engineSizes = null,Object? engineTypes = null,Object? cylinders = null,Object? horsepowerMin = freezed,Object? horsepowerMax = freezed,Object? torqueMin = freezed,Object? torqueMax = freezed,Object? transmission = null,Object? transmissionSpeeds = null,Object? driveTypes = null,Object? fuelType = null,Object? fuelConsumptionMax = freezed,Object? electricRangeMin = freezed,Object? seats = null,Object? doors = null,Object? curbWeightMin = freezed,Object? curbWeightMax = freezed,Object? cargoCapacityMin = freezed,Object? groundClearanceMin = freezed,Object? colors = null,Object? rimSizes = null,Object? paintTypes = null,Object? mileageMax = freezed,Object? ownersMax = freezed,Object? accidentFree = null,Object? floodFree = null,Object? withWarranty = null,Object? completeServiceHistory = null,Object? features = null,Object? minAirbags = freezed,Object? hasABS = null,Object? hasCameras = null,Object? hasBlindSpot = null,Object? hasLaneAssist = null,Object? hasAdaptiveCruise = null,Object? hasClimateControl = null,Object? hasSunroof = null,Object? hasLeatherSeats = null,Object? hasPowerSeats = null,Object? minInfotainmentSize = freezed,Object? hasCarPlay = null,Object? hasAndroidAuto = null,Object? hasNavigation = null,Object? hasWirelessCharging = null,Object? hasPremiumAudio = null,Object? city = freezed,Object? province = freezed,Object? testDriveAvailable = null,Object? deliveryAvailable = null,Object? acceptsTrade = null,Object? financingAvailable = null,Object? negotiable = null,Object? auctionsOnly = null,Object? sortBy = null,}) {
  return _then(_self.copyWith(
keyword: freezed == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String?,brands: null == brands ? _self.brands : brands // ignore: cast_nullable_to_non_nullable
as List<String>,yearMin: freezed == yearMin ? _self.yearMin : yearMin // ignore: cast_nullable_to_non_nullable
as int?,yearMax: freezed == yearMax ? _self.yearMax : yearMax // ignore: cast_nullable_to_non_nullable
as int?,priceMin: freezed == priceMin ? _self.priceMin : priceMin // ignore: cast_nullable_to_non_nullable
as double?,priceMax: freezed == priceMax ? _self.priceMax : priceMax // ignore: cast_nullable_to_non_nullable
as double?,bodyType: null == bodyType ? _self.bodyType : bodyType // ignore: cast_nullable_to_non_nullable
as List<BodyType>,engineSizes: null == engineSizes ? _self.engineSizes : engineSizes // ignore: cast_nullable_to_non_nullable
as List<String>,engineTypes: null == engineTypes ? _self.engineTypes : engineTypes // ignore: cast_nullable_to_non_nullable
as List<EngineType>,cylinders: null == cylinders ? _self.cylinders : cylinders // ignore: cast_nullable_to_non_nullable
as List<int>,horsepowerMin: freezed == horsepowerMin ? _self.horsepowerMin : horsepowerMin // ignore: cast_nullable_to_non_nullable
as int?,horsepowerMax: freezed == horsepowerMax ? _self.horsepowerMax : horsepowerMax // ignore: cast_nullable_to_non_nullable
as int?,torqueMin: freezed == torqueMin ? _self.torqueMin : torqueMin // ignore: cast_nullable_to_non_nullable
as int?,torqueMax: freezed == torqueMax ? _self.torqueMax : torqueMax // ignore: cast_nullable_to_non_nullable
as int?,transmission: null == transmission ? _self.transmission : transmission // ignore: cast_nullable_to_non_nullable
as List<TransmissionType>,transmissionSpeeds: null == transmissionSpeeds ? _self.transmissionSpeeds : transmissionSpeeds // ignore: cast_nullable_to_non_nullable
as List<int>,driveTypes: null == driveTypes ? _self.driveTypes : driveTypes // ignore: cast_nullable_to_non_nullable
as List<DriveType>,fuelType: null == fuelType ? _self.fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as List<FuelType>,fuelConsumptionMax: freezed == fuelConsumptionMax ? _self.fuelConsumptionMax : fuelConsumptionMax // ignore: cast_nullable_to_non_nullable
as double?,electricRangeMin: freezed == electricRangeMin ? _self.electricRangeMin : electricRangeMin // ignore: cast_nullable_to_non_nullable
as int?,seats: null == seats ? _self.seats : seats // ignore: cast_nullable_to_non_nullable
as List<int>,doors: null == doors ? _self.doors : doors // ignore: cast_nullable_to_non_nullable
as List<int>,curbWeightMin: freezed == curbWeightMin ? _self.curbWeightMin : curbWeightMin // ignore: cast_nullable_to_non_nullable
as int?,curbWeightMax: freezed == curbWeightMax ? _self.curbWeightMax : curbWeightMax // ignore: cast_nullable_to_non_nullable
as int?,cargoCapacityMin: freezed == cargoCapacityMin ? _self.cargoCapacityMin : cargoCapacityMin // ignore: cast_nullable_to_non_nullable
as int?,groundClearanceMin: freezed == groundClearanceMin ? _self.groundClearanceMin : groundClearanceMin // ignore: cast_nullable_to_non_nullable
as int?,colors: null == colors ? _self.colors : colors // ignore: cast_nullable_to_non_nullable
as List<String>,rimSizes: null == rimSizes ? _self.rimSizes : rimSizes // ignore: cast_nullable_to_non_nullable
as List<int>,paintTypes: null == paintTypes ? _self.paintTypes : paintTypes // ignore: cast_nullable_to_non_nullable
as List<PaintType>,mileageMax: freezed == mileageMax ? _self.mileageMax : mileageMax // ignore: cast_nullable_to_non_nullable
as int?,ownersMax: freezed == ownersMax ? _self.ownersMax : ownersMax // ignore: cast_nullable_to_non_nullable
as int?,accidentFree: null == accidentFree ? _self.accidentFree : accidentFree // ignore: cast_nullable_to_non_nullable
as bool,floodFree: null == floodFree ? _self.floodFree : floodFree // ignore: cast_nullable_to_non_nullable
as bool,withWarranty: null == withWarranty ? _self.withWarranty : withWarranty // ignore: cast_nullable_to_non_nullable
as bool,completeServiceHistory: null == completeServiceHistory ? _self.completeServiceHistory : completeServiceHistory // ignore: cast_nullable_to_non_nullable
as bool,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as List<String>,minAirbags: freezed == minAirbags ? _self.minAirbags : minAirbags // ignore: cast_nullable_to_non_nullable
as int?,hasABS: null == hasABS ? _self.hasABS : hasABS // ignore: cast_nullable_to_non_nullable
as bool,hasCameras: null == hasCameras ? _self.hasCameras : hasCameras // ignore: cast_nullable_to_non_nullable
as bool,hasBlindSpot: null == hasBlindSpot ? _self.hasBlindSpot : hasBlindSpot // ignore: cast_nullable_to_non_nullable
as bool,hasLaneAssist: null == hasLaneAssist ? _self.hasLaneAssist : hasLaneAssist // ignore: cast_nullable_to_non_nullable
as bool,hasAdaptiveCruise: null == hasAdaptiveCruise ? _self.hasAdaptiveCruise : hasAdaptiveCruise // ignore: cast_nullable_to_non_nullable
as bool,hasClimateControl: null == hasClimateControl ? _self.hasClimateControl : hasClimateControl // ignore: cast_nullable_to_non_nullable
as bool,hasSunroof: null == hasSunroof ? _self.hasSunroof : hasSunroof // ignore: cast_nullable_to_non_nullable
as bool,hasLeatherSeats: null == hasLeatherSeats ? _self.hasLeatherSeats : hasLeatherSeats // ignore: cast_nullable_to_non_nullable
as bool,hasPowerSeats: null == hasPowerSeats ? _self.hasPowerSeats : hasPowerSeats // ignore: cast_nullable_to_non_nullable
as bool,minInfotainmentSize: freezed == minInfotainmentSize ? _self.minInfotainmentSize : minInfotainmentSize // ignore: cast_nullable_to_non_nullable
as int?,hasCarPlay: null == hasCarPlay ? _self.hasCarPlay : hasCarPlay // ignore: cast_nullable_to_non_nullable
as bool,hasAndroidAuto: null == hasAndroidAuto ? _self.hasAndroidAuto : hasAndroidAuto // ignore: cast_nullable_to_non_nullable
as bool,hasNavigation: null == hasNavigation ? _self.hasNavigation : hasNavigation // ignore: cast_nullable_to_non_nullable
as bool,hasWirelessCharging: null == hasWirelessCharging ? _self.hasWirelessCharging : hasWirelessCharging // ignore: cast_nullable_to_non_nullable
as bool,hasPremiumAudio: null == hasPremiumAudio ? _self.hasPremiumAudio : hasPremiumAudio // ignore: cast_nullable_to_non_nullable
as bool,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,province: freezed == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String?,testDriveAvailable: null == testDriveAvailable ? _self.testDriveAvailable : testDriveAvailable // ignore: cast_nullable_to_non_nullable
as bool,deliveryAvailable: null == deliveryAvailable ? _self.deliveryAvailable : deliveryAvailable // ignore: cast_nullable_to_non_nullable
as bool,acceptsTrade: null == acceptsTrade ? _self.acceptsTrade : acceptsTrade // ignore: cast_nullable_to_non_nullable
as bool,financingAvailable: null == financingAvailable ? _self.financingAvailable : financingAvailable // ignore: cast_nullable_to_non_nullable
as bool,negotiable: null == negotiable ? _self.negotiable : negotiable // ignore: cast_nullable_to_non_nullable
as bool,auctionsOnly: null == auctionsOnly ? _self.auctionsOnly : auctionsOnly // ignore: cast_nullable_to_non_nullable
as bool,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as SortBy,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchFilters].
extension SearchFiltersPatterns on SearchFilters {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchFilters value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchFilters value)  $default,){
final _that = this;
switch (_that) {
case _SearchFilters():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchFilters value)?  $default,){
final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? keyword,  List<String> brands,  int? yearMin,  int? yearMax,  double? priceMin,  double? priceMax,  List<BodyType> bodyType,  List<String> engineSizes,  List<EngineType> engineTypes,  List<int> cylinders,  int? horsepowerMin,  int? horsepowerMax,  int? torqueMin,  int? torqueMax,  List<TransmissionType> transmission,  List<int> transmissionSpeeds,  List<DriveType> driveTypes,  List<FuelType> fuelType,  double? fuelConsumptionMax,  int? electricRangeMin,  List<int> seats,  List<int> doors,  int? curbWeightMin,  int? curbWeightMax,  int? cargoCapacityMin,  int? groundClearanceMin,  List<String> colors,  List<int> rimSizes,  List<PaintType> paintTypes,  int? mileageMax,  int? ownersMax,  bool accidentFree,  bool floodFree,  bool withWarranty,  bool completeServiceHistory,  List<String> features,  int? minAirbags,  bool hasABS,  bool hasCameras,  bool hasBlindSpot,  bool hasLaneAssist,  bool hasAdaptiveCruise,  bool hasClimateControl,  bool hasSunroof,  bool hasLeatherSeats,  bool hasPowerSeats,  int? minInfotainmentSize,  bool hasCarPlay,  bool hasAndroidAuto,  bool hasNavigation,  bool hasWirelessCharging,  bool hasPremiumAudio,  String? city,  String? province,  bool testDriveAvailable,  bool deliveryAvailable,  bool acceptsTrade,  bool financingAvailable,  bool negotiable,  bool auctionsOnly,  SortBy sortBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
return $default(_that.keyword,_that.brands,_that.yearMin,_that.yearMax,_that.priceMin,_that.priceMax,_that.bodyType,_that.engineSizes,_that.engineTypes,_that.cylinders,_that.horsepowerMin,_that.horsepowerMax,_that.torqueMin,_that.torqueMax,_that.transmission,_that.transmissionSpeeds,_that.driveTypes,_that.fuelType,_that.fuelConsumptionMax,_that.electricRangeMin,_that.seats,_that.doors,_that.curbWeightMin,_that.curbWeightMax,_that.cargoCapacityMin,_that.groundClearanceMin,_that.colors,_that.rimSizes,_that.paintTypes,_that.mileageMax,_that.ownersMax,_that.accidentFree,_that.floodFree,_that.withWarranty,_that.completeServiceHistory,_that.features,_that.minAirbags,_that.hasABS,_that.hasCameras,_that.hasBlindSpot,_that.hasLaneAssist,_that.hasAdaptiveCruise,_that.hasClimateControl,_that.hasSunroof,_that.hasLeatherSeats,_that.hasPowerSeats,_that.minInfotainmentSize,_that.hasCarPlay,_that.hasAndroidAuto,_that.hasNavigation,_that.hasWirelessCharging,_that.hasPremiumAudio,_that.city,_that.province,_that.testDriveAvailable,_that.deliveryAvailable,_that.acceptsTrade,_that.financingAvailable,_that.negotiable,_that.auctionsOnly,_that.sortBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? keyword,  List<String> brands,  int? yearMin,  int? yearMax,  double? priceMin,  double? priceMax,  List<BodyType> bodyType,  List<String> engineSizes,  List<EngineType> engineTypes,  List<int> cylinders,  int? horsepowerMin,  int? horsepowerMax,  int? torqueMin,  int? torqueMax,  List<TransmissionType> transmission,  List<int> transmissionSpeeds,  List<DriveType> driveTypes,  List<FuelType> fuelType,  double? fuelConsumptionMax,  int? electricRangeMin,  List<int> seats,  List<int> doors,  int? curbWeightMin,  int? curbWeightMax,  int? cargoCapacityMin,  int? groundClearanceMin,  List<String> colors,  List<int> rimSizes,  List<PaintType> paintTypes,  int? mileageMax,  int? ownersMax,  bool accidentFree,  bool floodFree,  bool withWarranty,  bool completeServiceHistory,  List<String> features,  int? minAirbags,  bool hasABS,  bool hasCameras,  bool hasBlindSpot,  bool hasLaneAssist,  bool hasAdaptiveCruise,  bool hasClimateControl,  bool hasSunroof,  bool hasLeatherSeats,  bool hasPowerSeats,  int? minInfotainmentSize,  bool hasCarPlay,  bool hasAndroidAuto,  bool hasNavigation,  bool hasWirelessCharging,  bool hasPremiumAudio,  String? city,  String? province,  bool testDriveAvailable,  bool deliveryAvailable,  bool acceptsTrade,  bool financingAvailable,  bool negotiable,  bool auctionsOnly,  SortBy sortBy)  $default,) {final _that = this;
switch (_that) {
case _SearchFilters():
return $default(_that.keyword,_that.brands,_that.yearMin,_that.yearMax,_that.priceMin,_that.priceMax,_that.bodyType,_that.engineSizes,_that.engineTypes,_that.cylinders,_that.horsepowerMin,_that.horsepowerMax,_that.torqueMin,_that.torqueMax,_that.transmission,_that.transmissionSpeeds,_that.driveTypes,_that.fuelType,_that.fuelConsumptionMax,_that.electricRangeMin,_that.seats,_that.doors,_that.curbWeightMin,_that.curbWeightMax,_that.cargoCapacityMin,_that.groundClearanceMin,_that.colors,_that.rimSizes,_that.paintTypes,_that.mileageMax,_that.ownersMax,_that.accidentFree,_that.floodFree,_that.withWarranty,_that.completeServiceHistory,_that.features,_that.minAirbags,_that.hasABS,_that.hasCameras,_that.hasBlindSpot,_that.hasLaneAssist,_that.hasAdaptiveCruise,_that.hasClimateControl,_that.hasSunroof,_that.hasLeatherSeats,_that.hasPowerSeats,_that.minInfotainmentSize,_that.hasCarPlay,_that.hasAndroidAuto,_that.hasNavigation,_that.hasWirelessCharging,_that.hasPremiumAudio,_that.city,_that.province,_that.testDriveAvailable,_that.deliveryAvailable,_that.acceptsTrade,_that.financingAvailable,_that.negotiable,_that.auctionsOnly,_that.sortBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? keyword,  List<String> brands,  int? yearMin,  int? yearMax,  double? priceMin,  double? priceMax,  List<BodyType> bodyType,  List<String> engineSizes,  List<EngineType> engineTypes,  List<int> cylinders,  int? horsepowerMin,  int? horsepowerMax,  int? torqueMin,  int? torqueMax,  List<TransmissionType> transmission,  List<int> transmissionSpeeds,  List<DriveType> driveTypes,  List<FuelType> fuelType,  double? fuelConsumptionMax,  int? electricRangeMin,  List<int> seats,  List<int> doors,  int? curbWeightMin,  int? curbWeightMax,  int? cargoCapacityMin,  int? groundClearanceMin,  List<String> colors,  List<int> rimSizes,  List<PaintType> paintTypes,  int? mileageMax,  int? ownersMax,  bool accidentFree,  bool floodFree,  bool withWarranty,  bool completeServiceHistory,  List<String> features,  int? minAirbags,  bool hasABS,  bool hasCameras,  bool hasBlindSpot,  bool hasLaneAssist,  bool hasAdaptiveCruise,  bool hasClimateControl,  bool hasSunroof,  bool hasLeatherSeats,  bool hasPowerSeats,  int? minInfotainmentSize,  bool hasCarPlay,  bool hasAndroidAuto,  bool hasNavigation,  bool hasWirelessCharging,  bool hasPremiumAudio,  String? city,  String? province,  bool testDriveAvailable,  bool deliveryAvailable,  bool acceptsTrade,  bool financingAvailable,  bool negotiable,  bool auctionsOnly,  SortBy sortBy)?  $default,) {final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
return $default(_that.keyword,_that.brands,_that.yearMin,_that.yearMax,_that.priceMin,_that.priceMax,_that.bodyType,_that.engineSizes,_that.engineTypes,_that.cylinders,_that.horsepowerMin,_that.horsepowerMax,_that.torqueMin,_that.torqueMax,_that.transmission,_that.transmissionSpeeds,_that.driveTypes,_that.fuelType,_that.fuelConsumptionMax,_that.electricRangeMin,_that.seats,_that.doors,_that.curbWeightMin,_that.curbWeightMax,_that.cargoCapacityMin,_that.groundClearanceMin,_that.colors,_that.rimSizes,_that.paintTypes,_that.mileageMax,_that.ownersMax,_that.accidentFree,_that.floodFree,_that.withWarranty,_that.completeServiceHistory,_that.features,_that.minAirbags,_that.hasABS,_that.hasCameras,_that.hasBlindSpot,_that.hasLaneAssist,_that.hasAdaptiveCruise,_that.hasClimateControl,_that.hasSunroof,_that.hasLeatherSeats,_that.hasPowerSeats,_that.minInfotainmentSize,_that.hasCarPlay,_that.hasAndroidAuto,_that.hasNavigation,_that.hasWirelessCharging,_that.hasPremiumAudio,_that.city,_that.province,_that.testDriveAvailable,_that.deliveryAvailable,_that.acceptsTrade,_that.financingAvailable,_that.negotiable,_that.auctionsOnly,_that.sortBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchFilters extends SearchFilters {
  const _SearchFilters({this.keyword, final  List<String> brands = const [], this.yearMin, this.yearMax, this.priceMin, this.priceMax, final  List<BodyType> bodyType = const [], final  List<String> engineSizes = const [], final  List<EngineType> engineTypes = const [], final  List<int> cylinders = const [], this.horsepowerMin, this.horsepowerMax, this.torqueMin, this.torqueMax, final  List<TransmissionType> transmission = const [], final  List<int> transmissionSpeeds = const [], final  List<DriveType> driveTypes = const [], final  List<FuelType> fuelType = const [], this.fuelConsumptionMax, this.electricRangeMin, final  List<int> seats = const [], final  List<int> doors = const [], this.curbWeightMin, this.curbWeightMax, this.cargoCapacityMin, this.groundClearanceMin, final  List<String> colors = const [], final  List<int> rimSizes = const [], final  List<PaintType> paintTypes = const [], this.mileageMax, this.ownersMax, this.accidentFree = false, this.floodFree = false, this.withWarranty = false, this.completeServiceHistory = false, final  List<String> features = const [], this.minAirbags, this.hasABS = false, this.hasCameras = false, this.hasBlindSpot = false, this.hasLaneAssist = false, this.hasAdaptiveCruise = false, this.hasClimateControl = false, this.hasSunroof = false, this.hasLeatherSeats = false, this.hasPowerSeats = false, this.minInfotainmentSize, this.hasCarPlay = false, this.hasAndroidAuto = false, this.hasNavigation = false, this.hasWirelessCharging = false, this.hasPremiumAudio = false, this.city, this.province, this.testDriveAvailable = false, this.deliveryAvailable = false, this.acceptsTrade = false, this.financingAvailable = false, this.negotiable = false, this.auctionsOnly = false, this.sortBy = SortBy.newest}): _brands = brands,_bodyType = bodyType,_engineSizes = engineSizes,_engineTypes = engineTypes,_cylinders = cylinders,_transmission = transmission,_transmissionSpeeds = transmissionSpeeds,_driveTypes = driveTypes,_fuelType = fuelType,_seats = seats,_doors = doors,_colors = colors,_rimSizes = rimSizes,_paintTypes = paintTypes,_features = features,super._();
  factory _SearchFilters.fromJson(Map<String, dynamic> json) => _$SearchFiltersFromJson(json);

// Basic
@override final  String? keyword;
 final  List<String> _brands;
@override@JsonKey() List<String> get brands {
  if (_brands is EqualUnmodifiableListView) return _brands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_brands);
}

@override final  int? yearMin;
@override final  int? yearMax;
@override final  double? priceMin;
@override final  double? priceMax;
 final  List<BodyType> _bodyType;
@override@JsonKey() List<BodyType> get bodyType {
  if (_bodyType is EqualUnmodifiableListView) return _bodyType;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bodyType);
}

// Mechanical
 final  List<String> _engineSizes;
// Mechanical
@override@JsonKey() List<String> get engineSizes {
  if (_engineSizes is EqualUnmodifiableListView) return _engineSizes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_engineSizes);
}

 final  List<EngineType> _engineTypes;
@override@JsonKey() List<EngineType> get engineTypes {
  if (_engineTypes is EqualUnmodifiableListView) return _engineTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_engineTypes);
}

 final  List<int> _cylinders;
@override@JsonKey() List<int> get cylinders {
  if (_cylinders is EqualUnmodifiableListView) return _cylinders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cylinders);
}

@override final  int? horsepowerMin;
@override final  int? horsepowerMax;
@override final  int? torqueMin;
@override final  int? torqueMax;
 final  List<TransmissionType> _transmission;
@override@JsonKey() List<TransmissionType> get transmission {
  if (_transmission is EqualUnmodifiableListView) return _transmission;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transmission);
}

 final  List<int> _transmissionSpeeds;
@override@JsonKey() List<int> get transmissionSpeeds {
  if (_transmissionSpeeds is EqualUnmodifiableListView) return _transmissionSpeeds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transmissionSpeeds);
}

 final  List<DriveType> _driveTypes;
@override@JsonKey() List<DriveType> get driveTypes {
  if (_driveTypes is EqualUnmodifiableListView) return _driveTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_driveTypes);
}

 final  List<FuelType> _fuelType;
@override@JsonKey() List<FuelType> get fuelType {
  if (_fuelType is EqualUnmodifiableListView) return _fuelType;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fuelType);
}

@override final  double? fuelConsumptionMax;
@override final  int? electricRangeMin;
// Dimensions & Capacity
 final  List<int> _seats;
// Dimensions & Capacity
@override@JsonKey() List<int> get seats {
  if (_seats is EqualUnmodifiableListView) return _seats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_seats);
}

 final  List<int> _doors;
@override@JsonKey() List<int> get doors {
  if (_doors is EqualUnmodifiableListView) return _doors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_doors);
}

@override final  int? curbWeightMin;
@override final  int? curbWeightMax;
@override final  int? cargoCapacityMin;
@override final  int? groundClearanceMin;
// Exterior
 final  List<String> _colors;
// Exterior
@override@JsonKey() List<String> get colors {
  if (_colors is EqualUnmodifiableListView) return _colors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_colors);
}

 final  List<int> _rimSizes;
@override@JsonKey() List<int> get rimSizes {
  if (_rimSizes is EqualUnmodifiableListView) return _rimSizes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rimSizes);
}

 final  List<PaintType> _paintTypes;
@override@JsonKey() List<PaintType> get paintTypes {
  if (_paintTypes is EqualUnmodifiableListView) return _paintTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paintTypes);
}

// Condition
@override final  int? mileageMax;
@override final  int? ownersMax;
@override@JsonKey() final  bool accidentFree;
@override@JsonKey() final  bool floodFree;
@override@JsonKey() final  bool withWarranty;
@override@JsonKey() final  bool completeServiceHistory;
// Features (select any from comprehensive list)
 final  List<String> _features;
// Features (select any from comprehensive list)
@override@JsonKey() List<String> get features {
  if (_features is EqualUnmodifiableListView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_features);
}

// Safety
@override final  int? minAirbags;
@override@JsonKey() final  bool hasABS;
@override@JsonKey() final  bool hasCameras;
@override@JsonKey() final  bool hasBlindSpot;
@override@JsonKey() final  bool hasLaneAssist;
@override@JsonKey() final  bool hasAdaptiveCruise;
// Comfort & Technology
@override@JsonKey() final  bool hasClimateControl;
@override@JsonKey() final  bool hasSunroof;
@override@JsonKey() final  bool hasLeatherSeats;
@override@JsonKey() final  bool hasPowerSeats;
@override final  int? minInfotainmentSize;
@override@JsonKey() final  bool hasCarPlay;
@override@JsonKey() final  bool hasAndroidAuto;
@override@JsonKey() final  bool hasNavigation;
@override@JsonKey() final  bool hasWirelessCharging;
@override@JsonKey() final  bool hasPremiumAudio;
// Location & Availability
@override final  String? city;
@override final  String? province;
@override@JsonKey() final  bool testDriveAvailable;
@override@JsonKey() final  bool deliveryAvailable;
// Other
@override@JsonKey() final  bool acceptsTrade;
@override@JsonKey() final  bool financingAvailable;
@override@JsonKey() final  bool negotiable;
@override@JsonKey() final  bool auctionsOnly;
// Sort
@override@JsonKey() final  SortBy sortBy;

/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchFiltersCopyWith<_SearchFilters> get copyWith => __$SearchFiltersCopyWithImpl<_SearchFilters>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchFiltersToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchFilters&&(identical(other.keyword, keyword) || other.keyword == keyword)&&const DeepCollectionEquality().equals(other._brands, _brands)&&(identical(other.yearMin, yearMin) || other.yearMin == yearMin)&&(identical(other.yearMax, yearMax) || other.yearMax == yearMax)&&(identical(other.priceMin, priceMin) || other.priceMin == priceMin)&&(identical(other.priceMax, priceMax) || other.priceMax == priceMax)&&const DeepCollectionEquality().equals(other._bodyType, _bodyType)&&const DeepCollectionEquality().equals(other._engineSizes, _engineSizes)&&const DeepCollectionEquality().equals(other._engineTypes, _engineTypes)&&const DeepCollectionEquality().equals(other._cylinders, _cylinders)&&(identical(other.horsepowerMin, horsepowerMin) || other.horsepowerMin == horsepowerMin)&&(identical(other.horsepowerMax, horsepowerMax) || other.horsepowerMax == horsepowerMax)&&(identical(other.torqueMin, torqueMin) || other.torqueMin == torqueMin)&&(identical(other.torqueMax, torqueMax) || other.torqueMax == torqueMax)&&const DeepCollectionEquality().equals(other._transmission, _transmission)&&const DeepCollectionEquality().equals(other._transmissionSpeeds, _transmissionSpeeds)&&const DeepCollectionEquality().equals(other._driveTypes, _driveTypes)&&const DeepCollectionEquality().equals(other._fuelType, _fuelType)&&(identical(other.fuelConsumptionMax, fuelConsumptionMax) || other.fuelConsumptionMax == fuelConsumptionMax)&&(identical(other.electricRangeMin, electricRangeMin) || other.electricRangeMin == electricRangeMin)&&const DeepCollectionEquality().equals(other._seats, _seats)&&const DeepCollectionEquality().equals(other._doors, _doors)&&(identical(other.curbWeightMin, curbWeightMin) || other.curbWeightMin == curbWeightMin)&&(identical(other.curbWeightMax, curbWeightMax) || other.curbWeightMax == curbWeightMax)&&(identical(other.cargoCapacityMin, cargoCapacityMin) || other.cargoCapacityMin == cargoCapacityMin)&&(identical(other.groundClearanceMin, groundClearanceMin) || other.groundClearanceMin == groundClearanceMin)&&const DeepCollectionEquality().equals(other._colors, _colors)&&const DeepCollectionEquality().equals(other._rimSizes, _rimSizes)&&const DeepCollectionEquality().equals(other._paintTypes, _paintTypes)&&(identical(other.mileageMax, mileageMax) || other.mileageMax == mileageMax)&&(identical(other.ownersMax, ownersMax) || other.ownersMax == ownersMax)&&(identical(other.accidentFree, accidentFree) || other.accidentFree == accidentFree)&&(identical(other.floodFree, floodFree) || other.floodFree == floodFree)&&(identical(other.withWarranty, withWarranty) || other.withWarranty == withWarranty)&&(identical(other.completeServiceHistory, completeServiceHistory) || other.completeServiceHistory == completeServiceHistory)&&const DeepCollectionEquality().equals(other._features, _features)&&(identical(other.minAirbags, minAirbags) || other.minAirbags == minAirbags)&&(identical(other.hasABS, hasABS) || other.hasABS == hasABS)&&(identical(other.hasCameras, hasCameras) || other.hasCameras == hasCameras)&&(identical(other.hasBlindSpot, hasBlindSpot) || other.hasBlindSpot == hasBlindSpot)&&(identical(other.hasLaneAssist, hasLaneAssist) || other.hasLaneAssist == hasLaneAssist)&&(identical(other.hasAdaptiveCruise, hasAdaptiveCruise) || other.hasAdaptiveCruise == hasAdaptiveCruise)&&(identical(other.hasClimateControl, hasClimateControl) || other.hasClimateControl == hasClimateControl)&&(identical(other.hasSunroof, hasSunroof) || other.hasSunroof == hasSunroof)&&(identical(other.hasLeatherSeats, hasLeatherSeats) || other.hasLeatherSeats == hasLeatherSeats)&&(identical(other.hasPowerSeats, hasPowerSeats) || other.hasPowerSeats == hasPowerSeats)&&(identical(other.minInfotainmentSize, minInfotainmentSize) || other.minInfotainmentSize == minInfotainmentSize)&&(identical(other.hasCarPlay, hasCarPlay) || other.hasCarPlay == hasCarPlay)&&(identical(other.hasAndroidAuto, hasAndroidAuto) || other.hasAndroidAuto == hasAndroidAuto)&&(identical(other.hasNavigation, hasNavigation) || other.hasNavigation == hasNavigation)&&(identical(other.hasWirelessCharging, hasWirelessCharging) || other.hasWirelessCharging == hasWirelessCharging)&&(identical(other.hasPremiumAudio, hasPremiumAudio) || other.hasPremiumAudio == hasPremiumAudio)&&(identical(other.city, city) || other.city == city)&&(identical(other.province, province) || other.province == province)&&(identical(other.testDriveAvailable, testDriveAvailable) || other.testDriveAvailable == testDriveAvailable)&&(identical(other.deliveryAvailable, deliveryAvailable) || other.deliveryAvailable == deliveryAvailable)&&(identical(other.acceptsTrade, acceptsTrade) || other.acceptsTrade == acceptsTrade)&&(identical(other.financingAvailable, financingAvailable) || other.financingAvailable == financingAvailable)&&(identical(other.negotiable, negotiable) || other.negotiable == negotiable)&&(identical(other.auctionsOnly, auctionsOnly) || other.auctionsOnly == auctionsOnly)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,keyword,const DeepCollectionEquality().hash(_brands),yearMin,yearMax,priceMin,priceMax,const DeepCollectionEquality().hash(_bodyType),const DeepCollectionEquality().hash(_engineSizes),const DeepCollectionEquality().hash(_engineTypes),const DeepCollectionEquality().hash(_cylinders),horsepowerMin,horsepowerMax,torqueMin,torqueMax,const DeepCollectionEquality().hash(_transmission),const DeepCollectionEquality().hash(_transmissionSpeeds),const DeepCollectionEquality().hash(_driveTypes),const DeepCollectionEquality().hash(_fuelType),fuelConsumptionMax,electricRangeMin,const DeepCollectionEquality().hash(_seats),const DeepCollectionEquality().hash(_doors),curbWeightMin,curbWeightMax,cargoCapacityMin,groundClearanceMin,const DeepCollectionEquality().hash(_colors),const DeepCollectionEquality().hash(_rimSizes),const DeepCollectionEquality().hash(_paintTypes),mileageMax,ownersMax,accidentFree,floodFree,withWarranty,completeServiceHistory,const DeepCollectionEquality().hash(_features),minAirbags,hasABS,hasCameras,hasBlindSpot,hasLaneAssist,hasAdaptiveCruise,hasClimateControl,hasSunroof,hasLeatherSeats,hasPowerSeats,minInfotainmentSize,hasCarPlay,hasAndroidAuto,hasNavigation,hasWirelessCharging,hasPremiumAudio,city,province,testDriveAvailable,deliveryAvailable,acceptsTrade,financingAvailable,negotiable,auctionsOnly,sortBy]);

@override
String toString() {
  return 'SearchFilters(keyword: $keyword, brands: $brands, yearMin: $yearMin, yearMax: $yearMax, priceMin: $priceMin, priceMax: $priceMax, bodyType: $bodyType, engineSizes: $engineSizes, engineTypes: $engineTypes, cylinders: $cylinders, horsepowerMin: $horsepowerMin, horsepowerMax: $horsepowerMax, torqueMin: $torqueMin, torqueMax: $torqueMax, transmission: $transmission, transmissionSpeeds: $transmissionSpeeds, driveTypes: $driveTypes, fuelType: $fuelType, fuelConsumptionMax: $fuelConsumptionMax, electricRangeMin: $electricRangeMin, seats: $seats, doors: $doors, curbWeightMin: $curbWeightMin, curbWeightMax: $curbWeightMax, cargoCapacityMin: $cargoCapacityMin, groundClearanceMin: $groundClearanceMin, colors: $colors, rimSizes: $rimSizes, paintTypes: $paintTypes, mileageMax: $mileageMax, ownersMax: $ownersMax, accidentFree: $accidentFree, floodFree: $floodFree, withWarranty: $withWarranty, completeServiceHistory: $completeServiceHistory, features: $features, minAirbags: $minAirbags, hasABS: $hasABS, hasCameras: $hasCameras, hasBlindSpot: $hasBlindSpot, hasLaneAssist: $hasLaneAssist, hasAdaptiveCruise: $hasAdaptiveCruise, hasClimateControl: $hasClimateControl, hasSunroof: $hasSunroof, hasLeatherSeats: $hasLeatherSeats, hasPowerSeats: $hasPowerSeats, minInfotainmentSize: $minInfotainmentSize, hasCarPlay: $hasCarPlay, hasAndroidAuto: $hasAndroidAuto, hasNavigation: $hasNavigation, hasWirelessCharging: $hasWirelessCharging, hasPremiumAudio: $hasPremiumAudio, city: $city, province: $province, testDriveAvailable: $testDriveAvailable, deliveryAvailable: $deliveryAvailable, acceptsTrade: $acceptsTrade, financingAvailable: $financingAvailable, negotiable: $negotiable, auctionsOnly: $auctionsOnly, sortBy: $sortBy)';
}


}

/// @nodoc
abstract mixin class _$SearchFiltersCopyWith<$Res> implements $SearchFiltersCopyWith<$Res> {
  factory _$SearchFiltersCopyWith(_SearchFilters value, $Res Function(_SearchFilters) _then) = __$SearchFiltersCopyWithImpl;
@override @useResult
$Res call({
 String? keyword, List<String> brands, int? yearMin, int? yearMax, double? priceMin, double? priceMax, List<BodyType> bodyType, List<String> engineSizes, List<EngineType> engineTypes, List<int> cylinders, int? horsepowerMin, int? horsepowerMax, int? torqueMin, int? torqueMax, List<TransmissionType> transmission, List<int> transmissionSpeeds, List<DriveType> driveTypes, List<FuelType> fuelType, double? fuelConsumptionMax, int? electricRangeMin, List<int> seats, List<int> doors, int? curbWeightMin, int? curbWeightMax, int? cargoCapacityMin, int? groundClearanceMin, List<String> colors, List<int> rimSizes, List<PaintType> paintTypes, int? mileageMax, int? ownersMax, bool accidentFree, bool floodFree, bool withWarranty, bool completeServiceHistory, List<String> features, int? minAirbags, bool hasABS, bool hasCameras, bool hasBlindSpot, bool hasLaneAssist, bool hasAdaptiveCruise, bool hasClimateControl, bool hasSunroof, bool hasLeatherSeats, bool hasPowerSeats, int? minInfotainmentSize, bool hasCarPlay, bool hasAndroidAuto, bool hasNavigation, bool hasWirelessCharging, bool hasPremiumAudio, String? city, String? province, bool testDriveAvailable, bool deliveryAvailable, bool acceptsTrade, bool financingAvailable, bool negotiable, bool auctionsOnly, SortBy sortBy
});




}
/// @nodoc
class __$SearchFiltersCopyWithImpl<$Res>
    implements _$SearchFiltersCopyWith<$Res> {
  __$SearchFiltersCopyWithImpl(this._self, this._then);

  final _SearchFilters _self;
  final $Res Function(_SearchFilters) _then;

/// Create a copy of SearchFilters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? keyword = freezed,Object? brands = null,Object? yearMin = freezed,Object? yearMax = freezed,Object? priceMin = freezed,Object? priceMax = freezed,Object? bodyType = null,Object? engineSizes = null,Object? engineTypes = null,Object? cylinders = null,Object? horsepowerMin = freezed,Object? horsepowerMax = freezed,Object? torqueMin = freezed,Object? torqueMax = freezed,Object? transmission = null,Object? transmissionSpeeds = null,Object? driveTypes = null,Object? fuelType = null,Object? fuelConsumptionMax = freezed,Object? electricRangeMin = freezed,Object? seats = null,Object? doors = null,Object? curbWeightMin = freezed,Object? curbWeightMax = freezed,Object? cargoCapacityMin = freezed,Object? groundClearanceMin = freezed,Object? colors = null,Object? rimSizes = null,Object? paintTypes = null,Object? mileageMax = freezed,Object? ownersMax = freezed,Object? accidentFree = null,Object? floodFree = null,Object? withWarranty = null,Object? completeServiceHistory = null,Object? features = null,Object? minAirbags = freezed,Object? hasABS = null,Object? hasCameras = null,Object? hasBlindSpot = null,Object? hasLaneAssist = null,Object? hasAdaptiveCruise = null,Object? hasClimateControl = null,Object? hasSunroof = null,Object? hasLeatherSeats = null,Object? hasPowerSeats = null,Object? minInfotainmentSize = freezed,Object? hasCarPlay = null,Object? hasAndroidAuto = null,Object? hasNavigation = null,Object? hasWirelessCharging = null,Object? hasPremiumAudio = null,Object? city = freezed,Object? province = freezed,Object? testDriveAvailable = null,Object? deliveryAvailable = null,Object? acceptsTrade = null,Object? financingAvailable = null,Object? negotiable = null,Object? auctionsOnly = null,Object? sortBy = null,}) {
  return _then(_SearchFilters(
keyword: freezed == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String?,brands: null == brands ? _self._brands : brands // ignore: cast_nullable_to_non_nullable
as List<String>,yearMin: freezed == yearMin ? _self.yearMin : yearMin // ignore: cast_nullable_to_non_nullable
as int?,yearMax: freezed == yearMax ? _self.yearMax : yearMax // ignore: cast_nullable_to_non_nullable
as int?,priceMin: freezed == priceMin ? _self.priceMin : priceMin // ignore: cast_nullable_to_non_nullable
as double?,priceMax: freezed == priceMax ? _self.priceMax : priceMax // ignore: cast_nullable_to_non_nullable
as double?,bodyType: null == bodyType ? _self._bodyType : bodyType // ignore: cast_nullable_to_non_nullable
as List<BodyType>,engineSizes: null == engineSizes ? _self._engineSizes : engineSizes // ignore: cast_nullable_to_non_nullable
as List<String>,engineTypes: null == engineTypes ? _self._engineTypes : engineTypes // ignore: cast_nullable_to_non_nullable
as List<EngineType>,cylinders: null == cylinders ? _self._cylinders : cylinders // ignore: cast_nullable_to_non_nullable
as List<int>,horsepowerMin: freezed == horsepowerMin ? _self.horsepowerMin : horsepowerMin // ignore: cast_nullable_to_non_nullable
as int?,horsepowerMax: freezed == horsepowerMax ? _self.horsepowerMax : horsepowerMax // ignore: cast_nullable_to_non_nullable
as int?,torqueMin: freezed == torqueMin ? _self.torqueMin : torqueMin // ignore: cast_nullable_to_non_nullable
as int?,torqueMax: freezed == torqueMax ? _self.torqueMax : torqueMax // ignore: cast_nullable_to_non_nullable
as int?,transmission: null == transmission ? _self._transmission : transmission // ignore: cast_nullable_to_non_nullable
as List<TransmissionType>,transmissionSpeeds: null == transmissionSpeeds ? _self._transmissionSpeeds : transmissionSpeeds // ignore: cast_nullable_to_non_nullable
as List<int>,driveTypes: null == driveTypes ? _self._driveTypes : driveTypes // ignore: cast_nullable_to_non_nullable
as List<DriveType>,fuelType: null == fuelType ? _self._fuelType : fuelType // ignore: cast_nullable_to_non_nullable
as List<FuelType>,fuelConsumptionMax: freezed == fuelConsumptionMax ? _self.fuelConsumptionMax : fuelConsumptionMax // ignore: cast_nullable_to_non_nullable
as double?,electricRangeMin: freezed == electricRangeMin ? _self.electricRangeMin : electricRangeMin // ignore: cast_nullable_to_non_nullable
as int?,seats: null == seats ? _self._seats : seats // ignore: cast_nullable_to_non_nullable
as List<int>,doors: null == doors ? _self._doors : doors // ignore: cast_nullable_to_non_nullable
as List<int>,curbWeightMin: freezed == curbWeightMin ? _self.curbWeightMin : curbWeightMin // ignore: cast_nullable_to_non_nullable
as int?,curbWeightMax: freezed == curbWeightMax ? _self.curbWeightMax : curbWeightMax // ignore: cast_nullable_to_non_nullable
as int?,cargoCapacityMin: freezed == cargoCapacityMin ? _self.cargoCapacityMin : cargoCapacityMin // ignore: cast_nullable_to_non_nullable
as int?,groundClearanceMin: freezed == groundClearanceMin ? _self.groundClearanceMin : groundClearanceMin // ignore: cast_nullable_to_non_nullable
as int?,colors: null == colors ? _self._colors : colors // ignore: cast_nullable_to_non_nullable
as List<String>,rimSizes: null == rimSizes ? _self._rimSizes : rimSizes // ignore: cast_nullable_to_non_nullable
as List<int>,paintTypes: null == paintTypes ? _self._paintTypes : paintTypes // ignore: cast_nullable_to_non_nullable
as List<PaintType>,mileageMax: freezed == mileageMax ? _self.mileageMax : mileageMax // ignore: cast_nullable_to_non_nullable
as int?,ownersMax: freezed == ownersMax ? _self.ownersMax : ownersMax // ignore: cast_nullable_to_non_nullable
as int?,accidentFree: null == accidentFree ? _self.accidentFree : accidentFree // ignore: cast_nullable_to_non_nullable
as bool,floodFree: null == floodFree ? _self.floodFree : floodFree // ignore: cast_nullable_to_non_nullable
as bool,withWarranty: null == withWarranty ? _self.withWarranty : withWarranty // ignore: cast_nullable_to_non_nullable
as bool,completeServiceHistory: null == completeServiceHistory ? _self.completeServiceHistory : completeServiceHistory // ignore: cast_nullable_to_non_nullable
as bool,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as List<String>,minAirbags: freezed == minAirbags ? _self.minAirbags : minAirbags // ignore: cast_nullable_to_non_nullable
as int?,hasABS: null == hasABS ? _self.hasABS : hasABS // ignore: cast_nullable_to_non_nullable
as bool,hasCameras: null == hasCameras ? _self.hasCameras : hasCameras // ignore: cast_nullable_to_non_nullable
as bool,hasBlindSpot: null == hasBlindSpot ? _self.hasBlindSpot : hasBlindSpot // ignore: cast_nullable_to_non_nullable
as bool,hasLaneAssist: null == hasLaneAssist ? _self.hasLaneAssist : hasLaneAssist // ignore: cast_nullable_to_non_nullable
as bool,hasAdaptiveCruise: null == hasAdaptiveCruise ? _self.hasAdaptiveCruise : hasAdaptiveCruise // ignore: cast_nullable_to_non_nullable
as bool,hasClimateControl: null == hasClimateControl ? _self.hasClimateControl : hasClimateControl // ignore: cast_nullable_to_non_nullable
as bool,hasSunroof: null == hasSunroof ? _self.hasSunroof : hasSunroof // ignore: cast_nullable_to_non_nullable
as bool,hasLeatherSeats: null == hasLeatherSeats ? _self.hasLeatherSeats : hasLeatherSeats // ignore: cast_nullable_to_non_nullable
as bool,hasPowerSeats: null == hasPowerSeats ? _self.hasPowerSeats : hasPowerSeats // ignore: cast_nullable_to_non_nullable
as bool,minInfotainmentSize: freezed == minInfotainmentSize ? _self.minInfotainmentSize : minInfotainmentSize // ignore: cast_nullable_to_non_nullable
as int?,hasCarPlay: null == hasCarPlay ? _self.hasCarPlay : hasCarPlay // ignore: cast_nullable_to_non_nullable
as bool,hasAndroidAuto: null == hasAndroidAuto ? _self.hasAndroidAuto : hasAndroidAuto // ignore: cast_nullable_to_non_nullable
as bool,hasNavigation: null == hasNavigation ? _self.hasNavigation : hasNavigation // ignore: cast_nullable_to_non_nullable
as bool,hasWirelessCharging: null == hasWirelessCharging ? _self.hasWirelessCharging : hasWirelessCharging // ignore: cast_nullable_to_non_nullable
as bool,hasPremiumAudio: null == hasPremiumAudio ? _self.hasPremiumAudio : hasPremiumAudio // ignore: cast_nullable_to_non_nullable
as bool,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,province: freezed == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String?,testDriveAvailable: null == testDriveAvailable ? _self.testDriveAvailable : testDriveAvailable // ignore: cast_nullable_to_non_nullable
as bool,deliveryAvailable: null == deliveryAvailable ? _self.deliveryAvailable : deliveryAvailable // ignore: cast_nullable_to_non_nullable
as bool,acceptsTrade: null == acceptsTrade ? _self.acceptsTrade : acceptsTrade // ignore: cast_nullable_to_non_nullable
as bool,financingAvailable: null == financingAvailable ? _self.financingAvailable : financingAvailable // ignore: cast_nullable_to_non_nullable
as bool,negotiable: null == negotiable ? _self.negotiable : negotiable // ignore: cast_nullable_to_non_nullable
as bool,auctionsOnly: null == auctionsOnly ? _self.auctionsOnly : auctionsOnly // ignore: cast_nullable_to_non_nullable
as bool,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as SortBy,
  ));
}


}

// dart format on
