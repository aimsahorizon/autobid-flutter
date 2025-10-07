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
 List<int> get seats; List<int> get doors; int? get curbWeightMin; int? get curbWeightMax; int? get grossWeightMin; int? get grossWeightMax; int? get cargoCapacityMin; int? get towingCapacityMin; int? get groundClearanceMin; int? get lengthMin; int? get lengthMax; int? get widthMin; int? get widthMax; int? get heightMin; int? get heightMax; int? get wheelbaseMin; int? get wheelbaseMax;// Exterior
 List<String> get colors; List<int> get rimSizes; List<PaintType> get paintTypes; List<RimType> get rimTypes; List<TireCondition> get tireConditions;// Condition & History
 int? get mileageMin; int? get mileageMax; int? get ownersMax; bool get accidentFree; bool get floodFree; bool get withWarranty; bool get completeServiceHistory; List<CarCondition> get conditions; List<RegistrationStatus> get registrationStatuses; bool get emissionTestValid; bool get comprehensiveInsurance;// Features (select any from comprehensive list)
 List<String> get features;// Safety Features
 int? get minAirbags; bool get hasABS; bool get hasTractionControl; bool get hasStabilityControl; bool get hasCameras; bool get hasRearCamera; bool get has360Camera; bool get hasBlindSpot; bool get hasLaneDepartureWarning; bool get hasLaneAssist; bool get hasAdaptiveCruise; bool get hasForwardCollisionWarning; bool get hasAutomaticEmergencyBraking; bool get hasHillStartAssist; bool get hasHillDescentControl; bool get hasParkingSensors; bool get hasFrontParkingSensors; bool get hasRearParkingSensors;// Comfort & Convenience
 bool get hasClimateControl; bool get hasDualClimateControl; bool get hasSunroof; bool get hasPanoramicSunroof; bool get hasLeatherSeats; bool get hasPowerSeats; bool get hasHeatedSeats; bool get hasVentilatedSeats; bool get hasMemorySeats; bool get hasKeylessEntry; bool get hasPushStart; bool get hasPowerWindows; bool get hasPowerMirrors; bool get hasAutoFoldingMirrors; bool get hasPowerTailgate; bool get hasCruiseControl;// Technology & Infotainment
 int? get minInfotainmentSize; bool get hasTouchscreen; bool get hasCarPlay; bool get hasAndroidAuto; bool get hasNavigation; bool get hasBluetooth; bool get hasWirelessCharging; bool get hasPremiumAudio; int? get minSpeakerCount; bool get hasHeadUpDisplay; bool get hasDigitalCluster; bool get hasWifiHotspot; int? get minUSBPorts;// Location & Availability
 String? get region; String? get province; String? get city; int? get distanceRadius; bool get testDriveAvailable; bool get deliveryAvailable; bool get homeDelivery; bool get dealershipPickup;// Seller Preferences
 bool get acceptsTrade; bool get financingAvailable; bool get bankFinancing; bool get inHouseFinancing; bool get negotiable; bool get cashOnly;// Listing Type & Status
 bool get auctionsOnly; bool get directSaleOnly; bool get liveAuctionsOnly; bool get upcomingAuctionsOnly; bool get endingSoonOnly; bool get hasBuyNowPrice; bool get belowReservePrice; bool get noBidsYet;// Special Filters
 bool get featuredOnly; bool get verifiedSeller; bool get dealerOnly; bool get privateSellerOnly; int? get recentlyAddedDays; int? get recentlyUpdatedDays; bool get priceReduced; bool get newListing; int? get minViewCount;// Media Filters
 int? get minPhotoCount; bool get hasVideo; bool get has360View; bool get hasInteriorPhotos; bool get hasEnginePhotos;// Sort
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchFilters&&(identical(other.keyword, keyword) || other.keyword == keyword)&&const DeepCollectionEquality().equals(other.brands, brands)&&(identical(other.yearMin, yearMin) || other.yearMin == yearMin)&&(identical(other.yearMax, yearMax) || other.yearMax == yearMax)&&(identical(other.priceMin, priceMin) || other.priceMin == priceMin)&&(identical(other.priceMax, priceMax) || other.priceMax == priceMax)&&const DeepCollectionEquality().equals(other.bodyType, bodyType)&&const DeepCollectionEquality().equals(other.engineSizes, engineSizes)&&const DeepCollectionEquality().equals(other.engineTypes, engineTypes)&&const DeepCollectionEquality().equals(other.cylinders, cylinders)&&(identical(other.horsepowerMin, horsepowerMin) || other.horsepowerMin == horsepowerMin)&&(identical(other.horsepowerMax, horsepowerMax) || other.horsepowerMax == horsepowerMax)&&(identical(other.torqueMin, torqueMin) || other.torqueMin == torqueMin)&&(identical(other.torqueMax, torqueMax) || other.torqueMax == torqueMax)&&const DeepCollectionEquality().equals(other.transmission, transmission)&&const DeepCollectionEquality().equals(other.transmissionSpeeds, transmissionSpeeds)&&const DeepCollectionEquality().equals(other.driveTypes, driveTypes)&&const DeepCollectionEquality().equals(other.fuelType, fuelType)&&(identical(other.fuelConsumptionMax, fuelConsumptionMax) || other.fuelConsumptionMax == fuelConsumptionMax)&&(identical(other.electricRangeMin, electricRangeMin) || other.electricRangeMin == electricRangeMin)&&const DeepCollectionEquality().equals(other.seats, seats)&&const DeepCollectionEquality().equals(other.doors, doors)&&(identical(other.curbWeightMin, curbWeightMin) || other.curbWeightMin == curbWeightMin)&&(identical(other.curbWeightMax, curbWeightMax) || other.curbWeightMax == curbWeightMax)&&(identical(other.grossWeightMin, grossWeightMin) || other.grossWeightMin == grossWeightMin)&&(identical(other.grossWeightMax, grossWeightMax) || other.grossWeightMax == grossWeightMax)&&(identical(other.cargoCapacityMin, cargoCapacityMin) || other.cargoCapacityMin == cargoCapacityMin)&&(identical(other.towingCapacityMin, towingCapacityMin) || other.towingCapacityMin == towingCapacityMin)&&(identical(other.groundClearanceMin, groundClearanceMin) || other.groundClearanceMin == groundClearanceMin)&&(identical(other.lengthMin, lengthMin) || other.lengthMin == lengthMin)&&(identical(other.lengthMax, lengthMax) || other.lengthMax == lengthMax)&&(identical(other.widthMin, widthMin) || other.widthMin == widthMin)&&(identical(other.widthMax, widthMax) || other.widthMax == widthMax)&&(identical(other.heightMin, heightMin) || other.heightMin == heightMin)&&(identical(other.heightMax, heightMax) || other.heightMax == heightMax)&&(identical(other.wheelbaseMin, wheelbaseMin) || other.wheelbaseMin == wheelbaseMin)&&(identical(other.wheelbaseMax, wheelbaseMax) || other.wheelbaseMax == wheelbaseMax)&&const DeepCollectionEquality().equals(other.colors, colors)&&const DeepCollectionEquality().equals(other.rimSizes, rimSizes)&&const DeepCollectionEquality().equals(other.paintTypes, paintTypes)&&const DeepCollectionEquality().equals(other.rimTypes, rimTypes)&&const DeepCollectionEquality().equals(other.tireConditions, tireConditions)&&(identical(other.mileageMin, mileageMin) || other.mileageMin == mileageMin)&&(identical(other.mileageMax, mileageMax) || other.mileageMax == mileageMax)&&(identical(other.ownersMax, ownersMax) || other.ownersMax == ownersMax)&&(identical(other.accidentFree, accidentFree) || other.accidentFree == accidentFree)&&(identical(other.floodFree, floodFree) || other.floodFree == floodFree)&&(identical(other.withWarranty, withWarranty) || other.withWarranty == withWarranty)&&(identical(other.completeServiceHistory, completeServiceHistory) || other.completeServiceHistory == completeServiceHistory)&&const DeepCollectionEquality().equals(other.conditions, conditions)&&const DeepCollectionEquality().equals(other.registrationStatuses, registrationStatuses)&&(identical(other.emissionTestValid, emissionTestValid) || other.emissionTestValid == emissionTestValid)&&(identical(other.comprehensiveInsurance, comprehensiveInsurance) || other.comprehensiveInsurance == comprehensiveInsurance)&&const DeepCollectionEquality().equals(other.features, features)&&(identical(other.minAirbags, minAirbags) || other.minAirbags == minAirbags)&&(identical(other.hasABS, hasABS) || other.hasABS == hasABS)&&(identical(other.hasTractionControl, hasTractionControl) || other.hasTractionControl == hasTractionControl)&&(identical(other.hasStabilityControl, hasStabilityControl) || other.hasStabilityControl == hasStabilityControl)&&(identical(other.hasCameras, hasCameras) || other.hasCameras == hasCameras)&&(identical(other.hasRearCamera, hasRearCamera) || other.hasRearCamera == hasRearCamera)&&(identical(other.has360Camera, has360Camera) || other.has360Camera == has360Camera)&&(identical(other.hasBlindSpot, hasBlindSpot) || other.hasBlindSpot == hasBlindSpot)&&(identical(other.hasLaneDepartureWarning, hasLaneDepartureWarning) || other.hasLaneDepartureWarning == hasLaneDepartureWarning)&&(identical(other.hasLaneAssist, hasLaneAssist) || other.hasLaneAssist == hasLaneAssist)&&(identical(other.hasAdaptiveCruise, hasAdaptiveCruise) || other.hasAdaptiveCruise == hasAdaptiveCruise)&&(identical(other.hasForwardCollisionWarning, hasForwardCollisionWarning) || other.hasForwardCollisionWarning == hasForwardCollisionWarning)&&(identical(other.hasAutomaticEmergencyBraking, hasAutomaticEmergencyBraking) || other.hasAutomaticEmergencyBraking == hasAutomaticEmergencyBraking)&&(identical(other.hasHillStartAssist, hasHillStartAssist) || other.hasHillStartAssist == hasHillStartAssist)&&(identical(other.hasHillDescentControl, hasHillDescentControl) || other.hasHillDescentControl == hasHillDescentControl)&&(identical(other.hasParkingSensors, hasParkingSensors) || other.hasParkingSensors == hasParkingSensors)&&(identical(other.hasFrontParkingSensors, hasFrontParkingSensors) || other.hasFrontParkingSensors == hasFrontParkingSensors)&&(identical(other.hasRearParkingSensors, hasRearParkingSensors) || other.hasRearParkingSensors == hasRearParkingSensors)&&(identical(other.hasClimateControl, hasClimateControl) || other.hasClimateControl == hasClimateControl)&&(identical(other.hasDualClimateControl, hasDualClimateControl) || other.hasDualClimateControl == hasDualClimateControl)&&(identical(other.hasSunroof, hasSunroof) || other.hasSunroof == hasSunroof)&&(identical(other.hasPanoramicSunroof, hasPanoramicSunroof) || other.hasPanoramicSunroof == hasPanoramicSunroof)&&(identical(other.hasLeatherSeats, hasLeatherSeats) || other.hasLeatherSeats == hasLeatherSeats)&&(identical(other.hasPowerSeats, hasPowerSeats) || other.hasPowerSeats == hasPowerSeats)&&(identical(other.hasHeatedSeats, hasHeatedSeats) || other.hasHeatedSeats == hasHeatedSeats)&&(identical(other.hasVentilatedSeats, hasVentilatedSeats) || other.hasVentilatedSeats == hasVentilatedSeats)&&(identical(other.hasMemorySeats, hasMemorySeats) || other.hasMemorySeats == hasMemorySeats)&&(identical(other.hasKeylessEntry, hasKeylessEntry) || other.hasKeylessEntry == hasKeylessEntry)&&(identical(other.hasPushStart, hasPushStart) || other.hasPushStart == hasPushStart)&&(identical(other.hasPowerWindows, hasPowerWindows) || other.hasPowerWindows == hasPowerWindows)&&(identical(other.hasPowerMirrors, hasPowerMirrors) || other.hasPowerMirrors == hasPowerMirrors)&&(identical(other.hasAutoFoldingMirrors, hasAutoFoldingMirrors) || other.hasAutoFoldingMirrors == hasAutoFoldingMirrors)&&(identical(other.hasPowerTailgate, hasPowerTailgate) || other.hasPowerTailgate == hasPowerTailgate)&&(identical(other.hasCruiseControl, hasCruiseControl) || other.hasCruiseControl == hasCruiseControl)&&(identical(other.minInfotainmentSize, minInfotainmentSize) || other.minInfotainmentSize == minInfotainmentSize)&&(identical(other.hasTouchscreen, hasTouchscreen) || other.hasTouchscreen == hasTouchscreen)&&(identical(other.hasCarPlay, hasCarPlay) || other.hasCarPlay == hasCarPlay)&&(identical(other.hasAndroidAuto, hasAndroidAuto) || other.hasAndroidAuto == hasAndroidAuto)&&(identical(other.hasNavigation, hasNavigation) || other.hasNavigation == hasNavigation)&&(identical(other.hasBluetooth, hasBluetooth) || other.hasBluetooth == hasBluetooth)&&(identical(other.hasWirelessCharging, hasWirelessCharging) || other.hasWirelessCharging == hasWirelessCharging)&&(identical(other.hasPremiumAudio, hasPremiumAudio) || other.hasPremiumAudio == hasPremiumAudio)&&(identical(other.minSpeakerCount, minSpeakerCount) || other.minSpeakerCount == minSpeakerCount)&&(identical(other.hasHeadUpDisplay, hasHeadUpDisplay) || other.hasHeadUpDisplay == hasHeadUpDisplay)&&(identical(other.hasDigitalCluster, hasDigitalCluster) || other.hasDigitalCluster == hasDigitalCluster)&&(identical(other.hasWifiHotspot, hasWifiHotspot) || other.hasWifiHotspot == hasWifiHotspot)&&(identical(other.minUSBPorts, minUSBPorts) || other.minUSBPorts == minUSBPorts)&&(identical(other.region, region) || other.region == region)&&(identical(other.province, province) || other.province == province)&&(identical(other.city, city) || other.city == city)&&(identical(other.distanceRadius, distanceRadius) || other.distanceRadius == distanceRadius)&&(identical(other.testDriveAvailable, testDriveAvailable) || other.testDriveAvailable == testDriveAvailable)&&(identical(other.deliveryAvailable, deliveryAvailable) || other.deliveryAvailable == deliveryAvailable)&&(identical(other.homeDelivery, homeDelivery) || other.homeDelivery == homeDelivery)&&(identical(other.dealershipPickup, dealershipPickup) || other.dealershipPickup == dealershipPickup)&&(identical(other.acceptsTrade, acceptsTrade) || other.acceptsTrade == acceptsTrade)&&(identical(other.financingAvailable, financingAvailable) || other.financingAvailable == financingAvailable)&&(identical(other.bankFinancing, bankFinancing) || other.bankFinancing == bankFinancing)&&(identical(other.inHouseFinancing, inHouseFinancing) || other.inHouseFinancing == inHouseFinancing)&&(identical(other.negotiable, negotiable) || other.negotiable == negotiable)&&(identical(other.cashOnly, cashOnly) || other.cashOnly == cashOnly)&&(identical(other.auctionsOnly, auctionsOnly) || other.auctionsOnly == auctionsOnly)&&(identical(other.directSaleOnly, directSaleOnly) || other.directSaleOnly == directSaleOnly)&&(identical(other.liveAuctionsOnly, liveAuctionsOnly) || other.liveAuctionsOnly == liveAuctionsOnly)&&(identical(other.upcomingAuctionsOnly, upcomingAuctionsOnly) || other.upcomingAuctionsOnly == upcomingAuctionsOnly)&&(identical(other.endingSoonOnly, endingSoonOnly) || other.endingSoonOnly == endingSoonOnly)&&(identical(other.hasBuyNowPrice, hasBuyNowPrice) || other.hasBuyNowPrice == hasBuyNowPrice)&&(identical(other.belowReservePrice, belowReservePrice) || other.belowReservePrice == belowReservePrice)&&(identical(other.noBidsYet, noBidsYet) || other.noBidsYet == noBidsYet)&&(identical(other.featuredOnly, featuredOnly) || other.featuredOnly == featuredOnly)&&(identical(other.verifiedSeller, verifiedSeller) || other.verifiedSeller == verifiedSeller)&&(identical(other.dealerOnly, dealerOnly) || other.dealerOnly == dealerOnly)&&(identical(other.privateSellerOnly, privateSellerOnly) || other.privateSellerOnly == privateSellerOnly)&&(identical(other.recentlyAddedDays, recentlyAddedDays) || other.recentlyAddedDays == recentlyAddedDays)&&(identical(other.recentlyUpdatedDays, recentlyUpdatedDays) || other.recentlyUpdatedDays == recentlyUpdatedDays)&&(identical(other.priceReduced, priceReduced) || other.priceReduced == priceReduced)&&(identical(other.newListing, newListing) || other.newListing == newListing)&&(identical(other.minViewCount, minViewCount) || other.minViewCount == minViewCount)&&(identical(other.minPhotoCount, minPhotoCount) || other.minPhotoCount == minPhotoCount)&&(identical(other.hasVideo, hasVideo) || other.hasVideo == hasVideo)&&(identical(other.has360View, has360View) || other.has360View == has360View)&&(identical(other.hasInteriorPhotos, hasInteriorPhotos) || other.hasInteriorPhotos == hasInteriorPhotos)&&(identical(other.hasEnginePhotos, hasEnginePhotos) || other.hasEnginePhotos == hasEnginePhotos)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,keyword,const DeepCollectionEquality().hash(brands),yearMin,yearMax,priceMin,priceMax,const DeepCollectionEquality().hash(bodyType),const DeepCollectionEquality().hash(engineSizes),const DeepCollectionEquality().hash(engineTypes),const DeepCollectionEquality().hash(cylinders),horsepowerMin,horsepowerMax,torqueMin,torqueMax,const DeepCollectionEquality().hash(transmission),const DeepCollectionEquality().hash(transmissionSpeeds),const DeepCollectionEquality().hash(driveTypes),const DeepCollectionEquality().hash(fuelType),fuelConsumptionMax,electricRangeMin,const DeepCollectionEquality().hash(seats),const DeepCollectionEquality().hash(doors),curbWeightMin,curbWeightMax,grossWeightMin,grossWeightMax,cargoCapacityMin,towingCapacityMin,groundClearanceMin,lengthMin,lengthMax,widthMin,widthMax,heightMin,heightMax,wheelbaseMin,wheelbaseMax,const DeepCollectionEquality().hash(colors),const DeepCollectionEquality().hash(rimSizes),const DeepCollectionEquality().hash(paintTypes),const DeepCollectionEquality().hash(rimTypes),const DeepCollectionEquality().hash(tireConditions),mileageMin,mileageMax,ownersMax,accidentFree,floodFree,withWarranty,completeServiceHistory,const DeepCollectionEquality().hash(conditions),const DeepCollectionEquality().hash(registrationStatuses),emissionTestValid,comprehensiveInsurance,const DeepCollectionEquality().hash(features),minAirbags,hasABS,hasTractionControl,hasStabilityControl,hasCameras,hasRearCamera,has360Camera,hasBlindSpot,hasLaneDepartureWarning,hasLaneAssist,hasAdaptiveCruise,hasForwardCollisionWarning,hasAutomaticEmergencyBraking,hasHillStartAssist,hasHillDescentControl,hasParkingSensors,hasFrontParkingSensors,hasRearParkingSensors,hasClimateControl,hasDualClimateControl,hasSunroof,hasPanoramicSunroof,hasLeatherSeats,hasPowerSeats,hasHeatedSeats,hasVentilatedSeats,hasMemorySeats,hasKeylessEntry,hasPushStart,hasPowerWindows,hasPowerMirrors,hasAutoFoldingMirrors,hasPowerTailgate,hasCruiseControl,minInfotainmentSize,hasTouchscreen,hasCarPlay,hasAndroidAuto,hasNavigation,hasBluetooth,hasWirelessCharging,hasPremiumAudio,minSpeakerCount,hasHeadUpDisplay,hasDigitalCluster,hasWifiHotspot,minUSBPorts,region,province,city,distanceRadius,testDriveAvailable,deliveryAvailable,homeDelivery,dealershipPickup,acceptsTrade,financingAvailable,bankFinancing,inHouseFinancing,negotiable,cashOnly,auctionsOnly,directSaleOnly,liveAuctionsOnly,upcomingAuctionsOnly,endingSoonOnly,hasBuyNowPrice,belowReservePrice,noBidsYet,featuredOnly,verifiedSeller,dealerOnly,privateSellerOnly,recentlyAddedDays,recentlyUpdatedDays,priceReduced,newListing,minViewCount,minPhotoCount,hasVideo,has360View,hasInteriorPhotos,hasEnginePhotos,sortBy]);

@override
String toString() {
  return 'SearchFilters(keyword: $keyword, brands: $brands, yearMin: $yearMin, yearMax: $yearMax, priceMin: $priceMin, priceMax: $priceMax, bodyType: $bodyType, engineSizes: $engineSizes, engineTypes: $engineTypes, cylinders: $cylinders, horsepowerMin: $horsepowerMin, horsepowerMax: $horsepowerMax, torqueMin: $torqueMin, torqueMax: $torqueMax, transmission: $transmission, transmissionSpeeds: $transmissionSpeeds, driveTypes: $driveTypes, fuelType: $fuelType, fuelConsumptionMax: $fuelConsumptionMax, electricRangeMin: $electricRangeMin, seats: $seats, doors: $doors, curbWeightMin: $curbWeightMin, curbWeightMax: $curbWeightMax, grossWeightMin: $grossWeightMin, grossWeightMax: $grossWeightMax, cargoCapacityMin: $cargoCapacityMin, towingCapacityMin: $towingCapacityMin, groundClearanceMin: $groundClearanceMin, lengthMin: $lengthMin, lengthMax: $lengthMax, widthMin: $widthMin, widthMax: $widthMax, heightMin: $heightMin, heightMax: $heightMax, wheelbaseMin: $wheelbaseMin, wheelbaseMax: $wheelbaseMax, colors: $colors, rimSizes: $rimSizes, paintTypes: $paintTypes, rimTypes: $rimTypes, tireConditions: $tireConditions, mileageMin: $mileageMin, mileageMax: $mileageMax, ownersMax: $ownersMax, accidentFree: $accidentFree, floodFree: $floodFree, withWarranty: $withWarranty, completeServiceHistory: $completeServiceHistory, conditions: $conditions, registrationStatuses: $registrationStatuses, emissionTestValid: $emissionTestValid, comprehensiveInsurance: $comprehensiveInsurance, features: $features, minAirbags: $minAirbags, hasABS: $hasABS, hasTractionControl: $hasTractionControl, hasStabilityControl: $hasStabilityControl, hasCameras: $hasCameras, hasRearCamera: $hasRearCamera, has360Camera: $has360Camera, hasBlindSpot: $hasBlindSpot, hasLaneDepartureWarning: $hasLaneDepartureWarning, hasLaneAssist: $hasLaneAssist, hasAdaptiveCruise: $hasAdaptiveCruise, hasForwardCollisionWarning: $hasForwardCollisionWarning, hasAutomaticEmergencyBraking: $hasAutomaticEmergencyBraking, hasHillStartAssist: $hasHillStartAssist, hasHillDescentControl: $hasHillDescentControl, hasParkingSensors: $hasParkingSensors, hasFrontParkingSensors: $hasFrontParkingSensors, hasRearParkingSensors: $hasRearParkingSensors, hasClimateControl: $hasClimateControl, hasDualClimateControl: $hasDualClimateControl, hasSunroof: $hasSunroof, hasPanoramicSunroof: $hasPanoramicSunroof, hasLeatherSeats: $hasLeatherSeats, hasPowerSeats: $hasPowerSeats, hasHeatedSeats: $hasHeatedSeats, hasVentilatedSeats: $hasVentilatedSeats, hasMemorySeats: $hasMemorySeats, hasKeylessEntry: $hasKeylessEntry, hasPushStart: $hasPushStart, hasPowerWindows: $hasPowerWindows, hasPowerMirrors: $hasPowerMirrors, hasAutoFoldingMirrors: $hasAutoFoldingMirrors, hasPowerTailgate: $hasPowerTailgate, hasCruiseControl: $hasCruiseControl, minInfotainmentSize: $minInfotainmentSize, hasTouchscreen: $hasTouchscreen, hasCarPlay: $hasCarPlay, hasAndroidAuto: $hasAndroidAuto, hasNavigation: $hasNavigation, hasBluetooth: $hasBluetooth, hasWirelessCharging: $hasWirelessCharging, hasPremiumAudio: $hasPremiumAudio, minSpeakerCount: $minSpeakerCount, hasHeadUpDisplay: $hasHeadUpDisplay, hasDigitalCluster: $hasDigitalCluster, hasWifiHotspot: $hasWifiHotspot, minUSBPorts: $minUSBPorts, region: $region, province: $province, city: $city, distanceRadius: $distanceRadius, testDriveAvailable: $testDriveAvailable, deliveryAvailable: $deliveryAvailable, homeDelivery: $homeDelivery, dealershipPickup: $dealershipPickup, acceptsTrade: $acceptsTrade, financingAvailable: $financingAvailable, bankFinancing: $bankFinancing, inHouseFinancing: $inHouseFinancing, negotiable: $negotiable, cashOnly: $cashOnly, auctionsOnly: $auctionsOnly, directSaleOnly: $directSaleOnly, liveAuctionsOnly: $liveAuctionsOnly, upcomingAuctionsOnly: $upcomingAuctionsOnly, endingSoonOnly: $endingSoonOnly, hasBuyNowPrice: $hasBuyNowPrice, belowReservePrice: $belowReservePrice, noBidsYet: $noBidsYet, featuredOnly: $featuredOnly, verifiedSeller: $verifiedSeller, dealerOnly: $dealerOnly, privateSellerOnly: $privateSellerOnly, recentlyAddedDays: $recentlyAddedDays, recentlyUpdatedDays: $recentlyUpdatedDays, priceReduced: $priceReduced, newListing: $newListing, minViewCount: $minViewCount, minPhotoCount: $minPhotoCount, hasVideo: $hasVideo, has360View: $has360View, hasInteriorPhotos: $hasInteriorPhotos, hasEnginePhotos: $hasEnginePhotos, sortBy: $sortBy)';
}


}

/// @nodoc
abstract mixin class $SearchFiltersCopyWith<$Res>  {
  factory $SearchFiltersCopyWith(SearchFilters value, $Res Function(SearchFilters) _then) = _$SearchFiltersCopyWithImpl;
@useResult
$Res call({
 String? keyword, List<String> brands, int? yearMin, int? yearMax, double? priceMin, double? priceMax, List<BodyType> bodyType, List<String> engineSizes, List<EngineType> engineTypes, List<int> cylinders, int? horsepowerMin, int? horsepowerMax, int? torqueMin, int? torqueMax, List<TransmissionType> transmission, List<int> transmissionSpeeds, List<DriveType> driveTypes, List<FuelType> fuelType, double? fuelConsumptionMax, int? electricRangeMin, List<int> seats, List<int> doors, int? curbWeightMin, int? curbWeightMax, int? grossWeightMin, int? grossWeightMax, int? cargoCapacityMin, int? towingCapacityMin, int? groundClearanceMin, int? lengthMin, int? lengthMax, int? widthMin, int? widthMax, int? heightMin, int? heightMax, int? wheelbaseMin, int? wheelbaseMax, List<String> colors, List<int> rimSizes, List<PaintType> paintTypes, List<RimType> rimTypes, List<TireCondition> tireConditions, int? mileageMin, int? mileageMax, int? ownersMax, bool accidentFree, bool floodFree, bool withWarranty, bool completeServiceHistory, List<CarCondition> conditions, List<RegistrationStatus> registrationStatuses, bool emissionTestValid, bool comprehensiveInsurance, List<String> features, int? minAirbags, bool hasABS, bool hasTractionControl, bool hasStabilityControl, bool hasCameras, bool hasRearCamera, bool has360Camera, bool hasBlindSpot, bool hasLaneDepartureWarning, bool hasLaneAssist, bool hasAdaptiveCruise, bool hasForwardCollisionWarning, bool hasAutomaticEmergencyBraking, bool hasHillStartAssist, bool hasHillDescentControl, bool hasParkingSensors, bool hasFrontParkingSensors, bool hasRearParkingSensors, bool hasClimateControl, bool hasDualClimateControl, bool hasSunroof, bool hasPanoramicSunroof, bool hasLeatherSeats, bool hasPowerSeats, bool hasHeatedSeats, bool hasVentilatedSeats, bool hasMemorySeats, bool hasKeylessEntry, bool hasPushStart, bool hasPowerWindows, bool hasPowerMirrors, bool hasAutoFoldingMirrors, bool hasPowerTailgate, bool hasCruiseControl, int? minInfotainmentSize, bool hasTouchscreen, bool hasCarPlay, bool hasAndroidAuto, bool hasNavigation, bool hasBluetooth, bool hasWirelessCharging, bool hasPremiumAudio, int? minSpeakerCount, bool hasHeadUpDisplay, bool hasDigitalCluster, bool hasWifiHotspot, int? minUSBPorts, String? region, String? province, String? city, int? distanceRadius, bool testDriveAvailable, bool deliveryAvailable, bool homeDelivery, bool dealershipPickup, bool acceptsTrade, bool financingAvailable, bool bankFinancing, bool inHouseFinancing, bool negotiable, bool cashOnly, bool auctionsOnly, bool directSaleOnly, bool liveAuctionsOnly, bool upcomingAuctionsOnly, bool endingSoonOnly, bool hasBuyNowPrice, bool belowReservePrice, bool noBidsYet, bool featuredOnly, bool verifiedSeller, bool dealerOnly, bool privateSellerOnly, int? recentlyAddedDays, int? recentlyUpdatedDays, bool priceReduced, bool newListing, int? minViewCount, int? minPhotoCount, bool hasVideo, bool has360View, bool hasInteriorPhotos, bool hasEnginePhotos, SortBy sortBy
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
@pragma('vm:prefer-inline') @override $Res call({Object? keyword = freezed,Object? brands = null,Object? yearMin = freezed,Object? yearMax = freezed,Object? priceMin = freezed,Object? priceMax = freezed,Object? bodyType = null,Object? engineSizes = null,Object? engineTypes = null,Object? cylinders = null,Object? horsepowerMin = freezed,Object? horsepowerMax = freezed,Object? torqueMin = freezed,Object? torqueMax = freezed,Object? transmission = null,Object? transmissionSpeeds = null,Object? driveTypes = null,Object? fuelType = null,Object? fuelConsumptionMax = freezed,Object? electricRangeMin = freezed,Object? seats = null,Object? doors = null,Object? curbWeightMin = freezed,Object? curbWeightMax = freezed,Object? grossWeightMin = freezed,Object? grossWeightMax = freezed,Object? cargoCapacityMin = freezed,Object? towingCapacityMin = freezed,Object? groundClearanceMin = freezed,Object? lengthMin = freezed,Object? lengthMax = freezed,Object? widthMin = freezed,Object? widthMax = freezed,Object? heightMin = freezed,Object? heightMax = freezed,Object? wheelbaseMin = freezed,Object? wheelbaseMax = freezed,Object? colors = null,Object? rimSizes = null,Object? paintTypes = null,Object? rimTypes = null,Object? tireConditions = null,Object? mileageMin = freezed,Object? mileageMax = freezed,Object? ownersMax = freezed,Object? accidentFree = null,Object? floodFree = null,Object? withWarranty = null,Object? completeServiceHistory = null,Object? conditions = null,Object? registrationStatuses = null,Object? emissionTestValid = null,Object? comprehensiveInsurance = null,Object? features = null,Object? minAirbags = freezed,Object? hasABS = null,Object? hasTractionControl = null,Object? hasStabilityControl = null,Object? hasCameras = null,Object? hasRearCamera = null,Object? has360Camera = null,Object? hasBlindSpot = null,Object? hasLaneDepartureWarning = null,Object? hasLaneAssist = null,Object? hasAdaptiveCruise = null,Object? hasForwardCollisionWarning = null,Object? hasAutomaticEmergencyBraking = null,Object? hasHillStartAssist = null,Object? hasHillDescentControl = null,Object? hasParkingSensors = null,Object? hasFrontParkingSensors = null,Object? hasRearParkingSensors = null,Object? hasClimateControl = null,Object? hasDualClimateControl = null,Object? hasSunroof = null,Object? hasPanoramicSunroof = null,Object? hasLeatherSeats = null,Object? hasPowerSeats = null,Object? hasHeatedSeats = null,Object? hasVentilatedSeats = null,Object? hasMemorySeats = null,Object? hasKeylessEntry = null,Object? hasPushStart = null,Object? hasPowerWindows = null,Object? hasPowerMirrors = null,Object? hasAutoFoldingMirrors = null,Object? hasPowerTailgate = null,Object? hasCruiseControl = null,Object? minInfotainmentSize = freezed,Object? hasTouchscreen = null,Object? hasCarPlay = null,Object? hasAndroidAuto = null,Object? hasNavigation = null,Object? hasBluetooth = null,Object? hasWirelessCharging = null,Object? hasPremiumAudio = null,Object? minSpeakerCount = freezed,Object? hasHeadUpDisplay = null,Object? hasDigitalCluster = null,Object? hasWifiHotspot = null,Object? minUSBPorts = freezed,Object? region = freezed,Object? province = freezed,Object? city = freezed,Object? distanceRadius = freezed,Object? testDriveAvailable = null,Object? deliveryAvailable = null,Object? homeDelivery = null,Object? dealershipPickup = null,Object? acceptsTrade = null,Object? financingAvailable = null,Object? bankFinancing = null,Object? inHouseFinancing = null,Object? negotiable = null,Object? cashOnly = null,Object? auctionsOnly = null,Object? directSaleOnly = null,Object? liveAuctionsOnly = null,Object? upcomingAuctionsOnly = null,Object? endingSoonOnly = null,Object? hasBuyNowPrice = null,Object? belowReservePrice = null,Object? noBidsYet = null,Object? featuredOnly = null,Object? verifiedSeller = null,Object? dealerOnly = null,Object? privateSellerOnly = null,Object? recentlyAddedDays = freezed,Object? recentlyUpdatedDays = freezed,Object? priceReduced = null,Object? newListing = null,Object? minViewCount = freezed,Object? minPhotoCount = freezed,Object? hasVideo = null,Object? has360View = null,Object? hasInteriorPhotos = null,Object? hasEnginePhotos = null,Object? sortBy = null,}) {
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
as int?,grossWeightMin: freezed == grossWeightMin ? _self.grossWeightMin : grossWeightMin // ignore: cast_nullable_to_non_nullable
as int?,grossWeightMax: freezed == grossWeightMax ? _self.grossWeightMax : grossWeightMax // ignore: cast_nullable_to_non_nullable
as int?,cargoCapacityMin: freezed == cargoCapacityMin ? _self.cargoCapacityMin : cargoCapacityMin // ignore: cast_nullable_to_non_nullable
as int?,towingCapacityMin: freezed == towingCapacityMin ? _self.towingCapacityMin : towingCapacityMin // ignore: cast_nullable_to_non_nullable
as int?,groundClearanceMin: freezed == groundClearanceMin ? _self.groundClearanceMin : groundClearanceMin // ignore: cast_nullable_to_non_nullable
as int?,lengthMin: freezed == lengthMin ? _self.lengthMin : lengthMin // ignore: cast_nullable_to_non_nullable
as int?,lengthMax: freezed == lengthMax ? _self.lengthMax : lengthMax // ignore: cast_nullable_to_non_nullable
as int?,widthMin: freezed == widthMin ? _self.widthMin : widthMin // ignore: cast_nullable_to_non_nullable
as int?,widthMax: freezed == widthMax ? _self.widthMax : widthMax // ignore: cast_nullable_to_non_nullable
as int?,heightMin: freezed == heightMin ? _self.heightMin : heightMin // ignore: cast_nullable_to_non_nullable
as int?,heightMax: freezed == heightMax ? _self.heightMax : heightMax // ignore: cast_nullable_to_non_nullable
as int?,wheelbaseMin: freezed == wheelbaseMin ? _self.wheelbaseMin : wheelbaseMin // ignore: cast_nullable_to_non_nullable
as int?,wheelbaseMax: freezed == wheelbaseMax ? _self.wheelbaseMax : wheelbaseMax // ignore: cast_nullable_to_non_nullable
as int?,colors: null == colors ? _self.colors : colors // ignore: cast_nullable_to_non_nullable
as List<String>,rimSizes: null == rimSizes ? _self.rimSizes : rimSizes // ignore: cast_nullable_to_non_nullable
as List<int>,paintTypes: null == paintTypes ? _self.paintTypes : paintTypes // ignore: cast_nullable_to_non_nullable
as List<PaintType>,rimTypes: null == rimTypes ? _self.rimTypes : rimTypes // ignore: cast_nullable_to_non_nullable
as List<RimType>,tireConditions: null == tireConditions ? _self.tireConditions : tireConditions // ignore: cast_nullable_to_non_nullable
as List<TireCondition>,mileageMin: freezed == mileageMin ? _self.mileageMin : mileageMin // ignore: cast_nullable_to_non_nullable
as int?,mileageMax: freezed == mileageMax ? _self.mileageMax : mileageMax // ignore: cast_nullable_to_non_nullable
as int?,ownersMax: freezed == ownersMax ? _self.ownersMax : ownersMax // ignore: cast_nullable_to_non_nullable
as int?,accidentFree: null == accidentFree ? _self.accidentFree : accidentFree // ignore: cast_nullable_to_non_nullable
as bool,floodFree: null == floodFree ? _self.floodFree : floodFree // ignore: cast_nullable_to_non_nullable
as bool,withWarranty: null == withWarranty ? _self.withWarranty : withWarranty // ignore: cast_nullable_to_non_nullable
as bool,completeServiceHistory: null == completeServiceHistory ? _self.completeServiceHistory : completeServiceHistory // ignore: cast_nullable_to_non_nullable
as bool,conditions: null == conditions ? _self.conditions : conditions // ignore: cast_nullable_to_non_nullable
as List<CarCondition>,registrationStatuses: null == registrationStatuses ? _self.registrationStatuses : registrationStatuses // ignore: cast_nullable_to_non_nullable
as List<RegistrationStatus>,emissionTestValid: null == emissionTestValid ? _self.emissionTestValid : emissionTestValid // ignore: cast_nullable_to_non_nullable
as bool,comprehensiveInsurance: null == comprehensiveInsurance ? _self.comprehensiveInsurance : comprehensiveInsurance // ignore: cast_nullable_to_non_nullable
as bool,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as List<String>,minAirbags: freezed == minAirbags ? _self.minAirbags : minAirbags // ignore: cast_nullable_to_non_nullable
as int?,hasABS: null == hasABS ? _self.hasABS : hasABS // ignore: cast_nullable_to_non_nullable
as bool,hasTractionControl: null == hasTractionControl ? _self.hasTractionControl : hasTractionControl // ignore: cast_nullable_to_non_nullable
as bool,hasStabilityControl: null == hasStabilityControl ? _self.hasStabilityControl : hasStabilityControl // ignore: cast_nullable_to_non_nullable
as bool,hasCameras: null == hasCameras ? _self.hasCameras : hasCameras // ignore: cast_nullable_to_non_nullable
as bool,hasRearCamera: null == hasRearCamera ? _self.hasRearCamera : hasRearCamera // ignore: cast_nullable_to_non_nullable
as bool,has360Camera: null == has360Camera ? _self.has360Camera : has360Camera // ignore: cast_nullable_to_non_nullable
as bool,hasBlindSpot: null == hasBlindSpot ? _self.hasBlindSpot : hasBlindSpot // ignore: cast_nullable_to_non_nullable
as bool,hasLaneDepartureWarning: null == hasLaneDepartureWarning ? _self.hasLaneDepartureWarning : hasLaneDepartureWarning // ignore: cast_nullable_to_non_nullable
as bool,hasLaneAssist: null == hasLaneAssist ? _self.hasLaneAssist : hasLaneAssist // ignore: cast_nullable_to_non_nullable
as bool,hasAdaptiveCruise: null == hasAdaptiveCruise ? _self.hasAdaptiveCruise : hasAdaptiveCruise // ignore: cast_nullable_to_non_nullable
as bool,hasForwardCollisionWarning: null == hasForwardCollisionWarning ? _self.hasForwardCollisionWarning : hasForwardCollisionWarning // ignore: cast_nullable_to_non_nullable
as bool,hasAutomaticEmergencyBraking: null == hasAutomaticEmergencyBraking ? _self.hasAutomaticEmergencyBraking : hasAutomaticEmergencyBraking // ignore: cast_nullable_to_non_nullable
as bool,hasHillStartAssist: null == hasHillStartAssist ? _self.hasHillStartAssist : hasHillStartAssist // ignore: cast_nullable_to_non_nullable
as bool,hasHillDescentControl: null == hasHillDescentControl ? _self.hasHillDescentControl : hasHillDescentControl // ignore: cast_nullable_to_non_nullable
as bool,hasParkingSensors: null == hasParkingSensors ? _self.hasParkingSensors : hasParkingSensors // ignore: cast_nullable_to_non_nullable
as bool,hasFrontParkingSensors: null == hasFrontParkingSensors ? _self.hasFrontParkingSensors : hasFrontParkingSensors // ignore: cast_nullable_to_non_nullable
as bool,hasRearParkingSensors: null == hasRearParkingSensors ? _self.hasRearParkingSensors : hasRearParkingSensors // ignore: cast_nullable_to_non_nullable
as bool,hasClimateControl: null == hasClimateControl ? _self.hasClimateControl : hasClimateControl // ignore: cast_nullable_to_non_nullable
as bool,hasDualClimateControl: null == hasDualClimateControl ? _self.hasDualClimateControl : hasDualClimateControl // ignore: cast_nullable_to_non_nullable
as bool,hasSunroof: null == hasSunroof ? _self.hasSunroof : hasSunroof // ignore: cast_nullable_to_non_nullable
as bool,hasPanoramicSunroof: null == hasPanoramicSunroof ? _self.hasPanoramicSunroof : hasPanoramicSunroof // ignore: cast_nullable_to_non_nullable
as bool,hasLeatherSeats: null == hasLeatherSeats ? _self.hasLeatherSeats : hasLeatherSeats // ignore: cast_nullable_to_non_nullable
as bool,hasPowerSeats: null == hasPowerSeats ? _self.hasPowerSeats : hasPowerSeats // ignore: cast_nullable_to_non_nullable
as bool,hasHeatedSeats: null == hasHeatedSeats ? _self.hasHeatedSeats : hasHeatedSeats // ignore: cast_nullable_to_non_nullable
as bool,hasVentilatedSeats: null == hasVentilatedSeats ? _self.hasVentilatedSeats : hasVentilatedSeats // ignore: cast_nullable_to_non_nullable
as bool,hasMemorySeats: null == hasMemorySeats ? _self.hasMemorySeats : hasMemorySeats // ignore: cast_nullable_to_non_nullable
as bool,hasKeylessEntry: null == hasKeylessEntry ? _self.hasKeylessEntry : hasKeylessEntry // ignore: cast_nullable_to_non_nullable
as bool,hasPushStart: null == hasPushStart ? _self.hasPushStart : hasPushStart // ignore: cast_nullable_to_non_nullable
as bool,hasPowerWindows: null == hasPowerWindows ? _self.hasPowerWindows : hasPowerWindows // ignore: cast_nullable_to_non_nullable
as bool,hasPowerMirrors: null == hasPowerMirrors ? _self.hasPowerMirrors : hasPowerMirrors // ignore: cast_nullable_to_non_nullable
as bool,hasAutoFoldingMirrors: null == hasAutoFoldingMirrors ? _self.hasAutoFoldingMirrors : hasAutoFoldingMirrors // ignore: cast_nullable_to_non_nullable
as bool,hasPowerTailgate: null == hasPowerTailgate ? _self.hasPowerTailgate : hasPowerTailgate // ignore: cast_nullable_to_non_nullable
as bool,hasCruiseControl: null == hasCruiseControl ? _self.hasCruiseControl : hasCruiseControl // ignore: cast_nullable_to_non_nullable
as bool,minInfotainmentSize: freezed == minInfotainmentSize ? _self.minInfotainmentSize : minInfotainmentSize // ignore: cast_nullable_to_non_nullable
as int?,hasTouchscreen: null == hasTouchscreen ? _self.hasTouchscreen : hasTouchscreen // ignore: cast_nullable_to_non_nullable
as bool,hasCarPlay: null == hasCarPlay ? _self.hasCarPlay : hasCarPlay // ignore: cast_nullable_to_non_nullable
as bool,hasAndroidAuto: null == hasAndroidAuto ? _self.hasAndroidAuto : hasAndroidAuto // ignore: cast_nullable_to_non_nullable
as bool,hasNavigation: null == hasNavigation ? _self.hasNavigation : hasNavigation // ignore: cast_nullable_to_non_nullable
as bool,hasBluetooth: null == hasBluetooth ? _self.hasBluetooth : hasBluetooth // ignore: cast_nullable_to_non_nullable
as bool,hasWirelessCharging: null == hasWirelessCharging ? _self.hasWirelessCharging : hasWirelessCharging // ignore: cast_nullable_to_non_nullable
as bool,hasPremiumAudio: null == hasPremiumAudio ? _self.hasPremiumAudio : hasPremiumAudio // ignore: cast_nullable_to_non_nullable
as bool,minSpeakerCount: freezed == minSpeakerCount ? _self.minSpeakerCount : minSpeakerCount // ignore: cast_nullable_to_non_nullable
as int?,hasHeadUpDisplay: null == hasHeadUpDisplay ? _self.hasHeadUpDisplay : hasHeadUpDisplay // ignore: cast_nullable_to_non_nullable
as bool,hasDigitalCluster: null == hasDigitalCluster ? _self.hasDigitalCluster : hasDigitalCluster // ignore: cast_nullable_to_non_nullable
as bool,hasWifiHotspot: null == hasWifiHotspot ? _self.hasWifiHotspot : hasWifiHotspot // ignore: cast_nullable_to_non_nullable
as bool,minUSBPorts: freezed == minUSBPorts ? _self.minUSBPorts : minUSBPorts // ignore: cast_nullable_to_non_nullable
as int?,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,province: freezed == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,distanceRadius: freezed == distanceRadius ? _self.distanceRadius : distanceRadius // ignore: cast_nullable_to_non_nullable
as int?,testDriveAvailable: null == testDriveAvailable ? _self.testDriveAvailable : testDriveAvailable // ignore: cast_nullable_to_non_nullable
as bool,deliveryAvailable: null == deliveryAvailable ? _self.deliveryAvailable : deliveryAvailable // ignore: cast_nullable_to_non_nullable
as bool,homeDelivery: null == homeDelivery ? _self.homeDelivery : homeDelivery // ignore: cast_nullable_to_non_nullable
as bool,dealershipPickup: null == dealershipPickup ? _self.dealershipPickup : dealershipPickup // ignore: cast_nullable_to_non_nullable
as bool,acceptsTrade: null == acceptsTrade ? _self.acceptsTrade : acceptsTrade // ignore: cast_nullable_to_non_nullable
as bool,financingAvailable: null == financingAvailable ? _self.financingAvailable : financingAvailable // ignore: cast_nullable_to_non_nullable
as bool,bankFinancing: null == bankFinancing ? _self.bankFinancing : bankFinancing // ignore: cast_nullable_to_non_nullable
as bool,inHouseFinancing: null == inHouseFinancing ? _self.inHouseFinancing : inHouseFinancing // ignore: cast_nullable_to_non_nullable
as bool,negotiable: null == negotiable ? _self.negotiable : negotiable // ignore: cast_nullable_to_non_nullable
as bool,cashOnly: null == cashOnly ? _self.cashOnly : cashOnly // ignore: cast_nullable_to_non_nullable
as bool,auctionsOnly: null == auctionsOnly ? _self.auctionsOnly : auctionsOnly // ignore: cast_nullable_to_non_nullable
as bool,directSaleOnly: null == directSaleOnly ? _self.directSaleOnly : directSaleOnly // ignore: cast_nullable_to_non_nullable
as bool,liveAuctionsOnly: null == liveAuctionsOnly ? _self.liveAuctionsOnly : liveAuctionsOnly // ignore: cast_nullable_to_non_nullable
as bool,upcomingAuctionsOnly: null == upcomingAuctionsOnly ? _self.upcomingAuctionsOnly : upcomingAuctionsOnly // ignore: cast_nullable_to_non_nullable
as bool,endingSoonOnly: null == endingSoonOnly ? _self.endingSoonOnly : endingSoonOnly // ignore: cast_nullable_to_non_nullable
as bool,hasBuyNowPrice: null == hasBuyNowPrice ? _self.hasBuyNowPrice : hasBuyNowPrice // ignore: cast_nullable_to_non_nullable
as bool,belowReservePrice: null == belowReservePrice ? _self.belowReservePrice : belowReservePrice // ignore: cast_nullable_to_non_nullable
as bool,noBidsYet: null == noBidsYet ? _self.noBidsYet : noBidsYet // ignore: cast_nullable_to_non_nullable
as bool,featuredOnly: null == featuredOnly ? _self.featuredOnly : featuredOnly // ignore: cast_nullable_to_non_nullable
as bool,verifiedSeller: null == verifiedSeller ? _self.verifiedSeller : verifiedSeller // ignore: cast_nullable_to_non_nullable
as bool,dealerOnly: null == dealerOnly ? _self.dealerOnly : dealerOnly // ignore: cast_nullable_to_non_nullable
as bool,privateSellerOnly: null == privateSellerOnly ? _self.privateSellerOnly : privateSellerOnly // ignore: cast_nullable_to_non_nullable
as bool,recentlyAddedDays: freezed == recentlyAddedDays ? _self.recentlyAddedDays : recentlyAddedDays // ignore: cast_nullable_to_non_nullable
as int?,recentlyUpdatedDays: freezed == recentlyUpdatedDays ? _self.recentlyUpdatedDays : recentlyUpdatedDays // ignore: cast_nullable_to_non_nullable
as int?,priceReduced: null == priceReduced ? _self.priceReduced : priceReduced // ignore: cast_nullable_to_non_nullable
as bool,newListing: null == newListing ? _self.newListing : newListing // ignore: cast_nullable_to_non_nullable
as bool,minViewCount: freezed == minViewCount ? _self.minViewCount : minViewCount // ignore: cast_nullable_to_non_nullable
as int?,minPhotoCount: freezed == minPhotoCount ? _self.minPhotoCount : minPhotoCount // ignore: cast_nullable_to_non_nullable
as int?,hasVideo: null == hasVideo ? _self.hasVideo : hasVideo // ignore: cast_nullable_to_non_nullable
as bool,has360View: null == has360View ? _self.has360View : has360View // ignore: cast_nullable_to_non_nullable
as bool,hasInteriorPhotos: null == hasInteriorPhotos ? _self.hasInteriorPhotos : hasInteriorPhotos // ignore: cast_nullable_to_non_nullable
as bool,hasEnginePhotos: null == hasEnginePhotos ? _self.hasEnginePhotos : hasEnginePhotos // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? keyword,  List<String> brands,  int? yearMin,  int? yearMax,  double? priceMin,  double? priceMax,  List<BodyType> bodyType,  List<String> engineSizes,  List<EngineType> engineTypes,  List<int> cylinders,  int? horsepowerMin,  int? horsepowerMax,  int? torqueMin,  int? torqueMax,  List<TransmissionType> transmission,  List<int> transmissionSpeeds,  List<DriveType> driveTypes,  List<FuelType> fuelType,  double? fuelConsumptionMax,  int? electricRangeMin,  List<int> seats,  List<int> doors,  int? curbWeightMin,  int? curbWeightMax,  int? grossWeightMin,  int? grossWeightMax,  int? cargoCapacityMin,  int? towingCapacityMin,  int? groundClearanceMin,  int? lengthMin,  int? lengthMax,  int? widthMin,  int? widthMax,  int? heightMin,  int? heightMax,  int? wheelbaseMin,  int? wheelbaseMax,  List<String> colors,  List<int> rimSizes,  List<PaintType> paintTypes,  List<RimType> rimTypes,  List<TireCondition> tireConditions,  int? mileageMin,  int? mileageMax,  int? ownersMax,  bool accidentFree,  bool floodFree,  bool withWarranty,  bool completeServiceHistory,  List<CarCondition> conditions,  List<RegistrationStatus> registrationStatuses,  bool emissionTestValid,  bool comprehensiveInsurance,  List<String> features,  int? minAirbags,  bool hasABS,  bool hasTractionControl,  bool hasStabilityControl,  bool hasCameras,  bool hasRearCamera,  bool has360Camera,  bool hasBlindSpot,  bool hasLaneDepartureWarning,  bool hasLaneAssist,  bool hasAdaptiveCruise,  bool hasForwardCollisionWarning,  bool hasAutomaticEmergencyBraking,  bool hasHillStartAssist,  bool hasHillDescentControl,  bool hasParkingSensors,  bool hasFrontParkingSensors,  bool hasRearParkingSensors,  bool hasClimateControl,  bool hasDualClimateControl,  bool hasSunroof,  bool hasPanoramicSunroof,  bool hasLeatherSeats,  bool hasPowerSeats,  bool hasHeatedSeats,  bool hasVentilatedSeats,  bool hasMemorySeats,  bool hasKeylessEntry,  bool hasPushStart,  bool hasPowerWindows,  bool hasPowerMirrors,  bool hasAutoFoldingMirrors,  bool hasPowerTailgate,  bool hasCruiseControl,  int? minInfotainmentSize,  bool hasTouchscreen,  bool hasCarPlay,  bool hasAndroidAuto,  bool hasNavigation,  bool hasBluetooth,  bool hasWirelessCharging,  bool hasPremiumAudio,  int? minSpeakerCount,  bool hasHeadUpDisplay,  bool hasDigitalCluster,  bool hasWifiHotspot,  int? minUSBPorts,  String? region,  String? province,  String? city,  int? distanceRadius,  bool testDriveAvailable,  bool deliveryAvailable,  bool homeDelivery,  bool dealershipPickup,  bool acceptsTrade,  bool financingAvailable,  bool bankFinancing,  bool inHouseFinancing,  bool negotiable,  bool cashOnly,  bool auctionsOnly,  bool directSaleOnly,  bool liveAuctionsOnly,  bool upcomingAuctionsOnly,  bool endingSoonOnly,  bool hasBuyNowPrice,  bool belowReservePrice,  bool noBidsYet,  bool featuredOnly,  bool verifiedSeller,  bool dealerOnly,  bool privateSellerOnly,  int? recentlyAddedDays,  int? recentlyUpdatedDays,  bool priceReduced,  bool newListing,  int? minViewCount,  int? minPhotoCount,  bool hasVideo,  bool has360View,  bool hasInteriorPhotos,  bool hasEnginePhotos,  SortBy sortBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
return $default(_that.keyword,_that.brands,_that.yearMin,_that.yearMax,_that.priceMin,_that.priceMax,_that.bodyType,_that.engineSizes,_that.engineTypes,_that.cylinders,_that.horsepowerMin,_that.horsepowerMax,_that.torqueMin,_that.torqueMax,_that.transmission,_that.transmissionSpeeds,_that.driveTypes,_that.fuelType,_that.fuelConsumptionMax,_that.electricRangeMin,_that.seats,_that.doors,_that.curbWeightMin,_that.curbWeightMax,_that.grossWeightMin,_that.grossWeightMax,_that.cargoCapacityMin,_that.towingCapacityMin,_that.groundClearanceMin,_that.lengthMin,_that.lengthMax,_that.widthMin,_that.widthMax,_that.heightMin,_that.heightMax,_that.wheelbaseMin,_that.wheelbaseMax,_that.colors,_that.rimSizes,_that.paintTypes,_that.rimTypes,_that.tireConditions,_that.mileageMin,_that.mileageMax,_that.ownersMax,_that.accidentFree,_that.floodFree,_that.withWarranty,_that.completeServiceHistory,_that.conditions,_that.registrationStatuses,_that.emissionTestValid,_that.comprehensiveInsurance,_that.features,_that.minAirbags,_that.hasABS,_that.hasTractionControl,_that.hasStabilityControl,_that.hasCameras,_that.hasRearCamera,_that.has360Camera,_that.hasBlindSpot,_that.hasLaneDepartureWarning,_that.hasLaneAssist,_that.hasAdaptiveCruise,_that.hasForwardCollisionWarning,_that.hasAutomaticEmergencyBraking,_that.hasHillStartAssist,_that.hasHillDescentControl,_that.hasParkingSensors,_that.hasFrontParkingSensors,_that.hasRearParkingSensors,_that.hasClimateControl,_that.hasDualClimateControl,_that.hasSunroof,_that.hasPanoramicSunroof,_that.hasLeatherSeats,_that.hasPowerSeats,_that.hasHeatedSeats,_that.hasVentilatedSeats,_that.hasMemorySeats,_that.hasKeylessEntry,_that.hasPushStart,_that.hasPowerWindows,_that.hasPowerMirrors,_that.hasAutoFoldingMirrors,_that.hasPowerTailgate,_that.hasCruiseControl,_that.minInfotainmentSize,_that.hasTouchscreen,_that.hasCarPlay,_that.hasAndroidAuto,_that.hasNavigation,_that.hasBluetooth,_that.hasWirelessCharging,_that.hasPremiumAudio,_that.minSpeakerCount,_that.hasHeadUpDisplay,_that.hasDigitalCluster,_that.hasWifiHotspot,_that.minUSBPorts,_that.region,_that.province,_that.city,_that.distanceRadius,_that.testDriveAvailable,_that.deliveryAvailable,_that.homeDelivery,_that.dealershipPickup,_that.acceptsTrade,_that.financingAvailable,_that.bankFinancing,_that.inHouseFinancing,_that.negotiable,_that.cashOnly,_that.auctionsOnly,_that.directSaleOnly,_that.liveAuctionsOnly,_that.upcomingAuctionsOnly,_that.endingSoonOnly,_that.hasBuyNowPrice,_that.belowReservePrice,_that.noBidsYet,_that.featuredOnly,_that.verifiedSeller,_that.dealerOnly,_that.privateSellerOnly,_that.recentlyAddedDays,_that.recentlyUpdatedDays,_that.priceReduced,_that.newListing,_that.minViewCount,_that.minPhotoCount,_that.hasVideo,_that.has360View,_that.hasInteriorPhotos,_that.hasEnginePhotos,_that.sortBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? keyword,  List<String> brands,  int? yearMin,  int? yearMax,  double? priceMin,  double? priceMax,  List<BodyType> bodyType,  List<String> engineSizes,  List<EngineType> engineTypes,  List<int> cylinders,  int? horsepowerMin,  int? horsepowerMax,  int? torqueMin,  int? torqueMax,  List<TransmissionType> transmission,  List<int> transmissionSpeeds,  List<DriveType> driveTypes,  List<FuelType> fuelType,  double? fuelConsumptionMax,  int? electricRangeMin,  List<int> seats,  List<int> doors,  int? curbWeightMin,  int? curbWeightMax,  int? grossWeightMin,  int? grossWeightMax,  int? cargoCapacityMin,  int? towingCapacityMin,  int? groundClearanceMin,  int? lengthMin,  int? lengthMax,  int? widthMin,  int? widthMax,  int? heightMin,  int? heightMax,  int? wheelbaseMin,  int? wheelbaseMax,  List<String> colors,  List<int> rimSizes,  List<PaintType> paintTypes,  List<RimType> rimTypes,  List<TireCondition> tireConditions,  int? mileageMin,  int? mileageMax,  int? ownersMax,  bool accidentFree,  bool floodFree,  bool withWarranty,  bool completeServiceHistory,  List<CarCondition> conditions,  List<RegistrationStatus> registrationStatuses,  bool emissionTestValid,  bool comprehensiveInsurance,  List<String> features,  int? minAirbags,  bool hasABS,  bool hasTractionControl,  bool hasStabilityControl,  bool hasCameras,  bool hasRearCamera,  bool has360Camera,  bool hasBlindSpot,  bool hasLaneDepartureWarning,  bool hasLaneAssist,  bool hasAdaptiveCruise,  bool hasForwardCollisionWarning,  bool hasAutomaticEmergencyBraking,  bool hasHillStartAssist,  bool hasHillDescentControl,  bool hasParkingSensors,  bool hasFrontParkingSensors,  bool hasRearParkingSensors,  bool hasClimateControl,  bool hasDualClimateControl,  bool hasSunroof,  bool hasPanoramicSunroof,  bool hasLeatherSeats,  bool hasPowerSeats,  bool hasHeatedSeats,  bool hasVentilatedSeats,  bool hasMemorySeats,  bool hasKeylessEntry,  bool hasPushStart,  bool hasPowerWindows,  bool hasPowerMirrors,  bool hasAutoFoldingMirrors,  bool hasPowerTailgate,  bool hasCruiseControl,  int? minInfotainmentSize,  bool hasTouchscreen,  bool hasCarPlay,  bool hasAndroidAuto,  bool hasNavigation,  bool hasBluetooth,  bool hasWirelessCharging,  bool hasPremiumAudio,  int? minSpeakerCount,  bool hasHeadUpDisplay,  bool hasDigitalCluster,  bool hasWifiHotspot,  int? minUSBPorts,  String? region,  String? province,  String? city,  int? distanceRadius,  bool testDriveAvailable,  bool deliveryAvailable,  bool homeDelivery,  bool dealershipPickup,  bool acceptsTrade,  bool financingAvailable,  bool bankFinancing,  bool inHouseFinancing,  bool negotiable,  bool cashOnly,  bool auctionsOnly,  bool directSaleOnly,  bool liveAuctionsOnly,  bool upcomingAuctionsOnly,  bool endingSoonOnly,  bool hasBuyNowPrice,  bool belowReservePrice,  bool noBidsYet,  bool featuredOnly,  bool verifiedSeller,  bool dealerOnly,  bool privateSellerOnly,  int? recentlyAddedDays,  int? recentlyUpdatedDays,  bool priceReduced,  bool newListing,  int? minViewCount,  int? minPhotoCount,  bool hasVideo,  bool has360View,  bool hasInteriorPhotos,  bool hasEnginePhotos,  SortBy sortBy)  $default,) {final _that = this;
switch (_that) {
case _SearchFilters():
return $default(_that.keyword,_that.brands,_that.yearMin,_that.yearMax,_that.priceMin,_that.priceMax,_that.bodyType,_that.engineSizes,_that.engineTypes,_that.cylinders,_that.horsepowerMin,_that.horsepowerMax,_that.torqueMin,_that.torqueMax,_that.transmission,_that.transmissionSpeeds,_that.driveTypes,_that.fuelType,_that.fuelConsumptionMax,_that.electricRangeMin,_that.seats,_that.doors,_that.curbWeightMin,_that.curbWeightMax,_that.grossWeightMin,_that.grossWeightMax,_that.cargoCapacityMin,_that.towingCapacityMin,_that.groundClearanceMin,_that.lengthMin,_that.lengthMax,_that.widthMin,_that.widthMax,_that.heightMin,_that.heightMax,_that.wheelbaseMin,_that.wheelbaseMax,_that.colors,_that.rimSizes,_that.paintTypes,_that.rimTypes,_that.tireConditions,_that.mileageMin,_that.mileageMax,_that.ownersMax,_that.accidentFree,_that.floodFree,_that.withWarranty,_that.completeServiceHistory,_that.conditions,_that.registrationStatuses,_that.emissionTestValid,_that.comprehensiveInsurance,_that.features,_that.minAirbags,_that.hasABS,_that.hasTractionControl,_that.hasStabilityControl,_that.hasCameras,_that.hasRearCamera,_that.has360Camera,_that.hasBlindSpot,_that.hasLaneDepartureWarning,_that.hasLaneAssist,_that.hasAdaptiveCruise,_that.hasForwardCollisionWarning,_that.hasAutomaticEmergencyBraking,_that.hasHillStartAssist,_that.hasHillDescentControl,_that.hasParkingSensors,_that.hasFrontParkingSensors,_that.hasRearParkingSensors,_that.hasClimateControl,_that.hasDualClimateControl,_that.hasSunroof,_that.hasPanoramicSunroof,_that.hasLeatherSeats,_that.hasPowerSeats,_that.hasHeatedSeats,_that.hasVentilatedSeats,_that.hasMemorySeats,_that.hasKeylessEntry,_that.hasPushStart,_that.hasPowerWindows,_that.hasPowerMirrors,_that.hasAutoFoldingMirrors,_that.hasPowerTailgate,_that.hasCruiseControl,_that.minInfotainmentSize,_that.hasTouchscreen,_that.hasCarPlay,_that.hasAndroidAuto,_that.hasNavigation,_that.hasBluetooth,_that.hasWirelessCharging,_that.hasPremiumAudio,_that.minSpeakerCount,_that.hasHeadUpDisplay,_that.hasDigitalCluster,_that.hasWifiHotspot,_that.minUSBPorts,_that.region,_that.province,_that.city,_that.distanceRadius,_that.testDriveAvailable,_that.deliveryAvailable,_that.homeDelivery,_that.dealershipPickup,_that.acceptsTrade,_that.financingAvailable,_that.bankFinancing,_that.inHouseFinancing,_that.negotiable,_that.cashOnly,_that.auctionsOnly,_that.directSaleOnly,_that.liveAuctionsOnly,_that.upcomingAuctionsOnly,_that.endingSoonOnly,_that.hasBuyNowPrice,_that.belowReservePrice,_that.noBidsYet,_that.featuredOnly,_that.verifiedSeller,_that.dealerOnly,_that.privateSellerOnly,_that.recentlyAddedDays,_that.recentlyUpdatedDays,_that.priceReduced,_that.newListing,_that.minViewCount,_that.minPhotoCount,_that.hasVideo,_that.has360View,_that.hasInteriorPhotos,_that.hasEnginePhotos,_that.sortBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? keyword,  List<String> brands,  int? yearMin,  int? yearMax,  double? priceMin,  double? priceMax,  List<BodyType> bodyType,  List<String> engineSizes,  List<EngineType> engineTypes,  List<int> cylinders,  int? horsepowerMin,  int? horsepowerMax,  int? torqueMin,  int? torqueMax,  List<TransmissionType> transmission,  List<int> transmissionSpeeds,  List<DriveType> driveTypes,  List<FuelType> fuelType,  double? fuelConsumptionMax,  int? electricRangeMin,  List<int> seats,  List<int> doors,  int? curbWeightMin,  int? curbWeightMax,  int? grossWeightMin,  int? grossWeightMax,  int? cargoCapacityMin,  int? towingCapacityMin,  int? groundClearanceMin,  int? lengthMin,  int? lengthMax,  int? widthMin,  int? widthMax,  int? heightMin,  int? heightMax,  int? wheelbaseMin,  int? wheelbaseMax,  List<String> colors,  List<int> rimSizes,  List<PaintType> paintTypes,  List<RimType> rimTypes,  List<TireCondition> tireConditions,  int? mileageMin,  int? mileageMax,  int? ownersMax,  bool accidentFree,  bool floodFree,  bool withWarranty,  bool completeServiceHistory,  List<CarCondition> conditions,  List<RegistrationStatus> registrationStatuses,  bool emissionTestValid,  bool comprehensiveInsurance,  List<String> features,  int? minAirbags,  bool hasABS,  bool hasTractionControl,  bool hasStabilityControl,  bool hasCameras,  bool hasRearCamera,  bool has360Camera,  bool hasBlindSpot,  bool hasLaneDepartureWarning,  bool hasLaneAssist,  bool hasAdaptiveCruise,  bool hasForwardCollisionWarning,  bool hasAutomaticEmergencyBraking,  bool hasHillStartAssist,  bool hasHillDescentControl,  bool hasParkingSensors,  bool hasFrontParkingSensors,  bool hasRearParkingSensors,  bool hasClimateControl,  bool hasDualClimateControl,  bool hasSunroof,  bool hasPanoramicSunroof,  bool hasLeatherSeats,  bool hasPowerSeats,  bool hasHeatedSeats,  bool hasVentilatedSeats,  bool hasMemorySeats,  bool hasKeylessEntry,  bool hasPushStart,  bool hasPowerWindows,  bool hasPowerMirrors,  bool hasAutoFoldingMirrors,  bool hasPowerTailgate,  bool hasCruiseControl,  int? minInfotainmentSize,  bool hasTouchscreen,  bool hasCarPlay,  bool hasAndroidAuto,  bool hasNavigation,  bool hasBluetooth,  bool hasWirelessCharging,  bool hasPremiumAudio,  int? minSpeakerCount,  bool hasHeadUpDisplay,  bool hasDigitalCluster,  bool hasWifiHotspot,  int? minUSBPorts,  String? region,  String? province,  String? city,  int? distanceRadius,  bool testDriveAvailable,  bool deliveryAvailable,  bool homeDelivery,  bool dealershipPickup,  bool acceptsTrade,  bool financingAvailable,  bool bankFinancing,  bool inHouseFinancing,  bool negotiable,  bool cashOnly,  bool auctionsOnly,  bool directSaleOnly,  bool liveAuctionsOnly,  bool upcomingAuctionsOnly,  bool endingSoonOnly,  bool hasBuyNowPrice,  bool belowReservePrice,  bool noBidsYet,  bool featuredOnly,  bool verifiedSeller,  bool dealerOnly,  bool privateSellerOnly,  int? recentlyAddedDays,  int? recentlyUpdatedDays,  bool priceReduced,  bool newListing,  int? minViewCount,  int? minPhotoCount,  bool hasVideo,  bool has360View,  bool hasInteriorPhotos,  bool hasEnginePhotos,  SortBy sortBy)?  $default,) {final _that = this;
switch (_that) {
case _SearchFilters() when $default != null:
return $default(_that.keyword,_that.brands,_that.yearMin,_that.yearMax,_that.priceMin,_that.priceMax,_that.bodyType,_that.engineSizes,_that.engineTypes,_that.cylinders,_that.horsepowerMin,_that.horsepowerMax,_that.torqueMin,_that.torqueMax,_that.transmission,_that.transmissionSpeeds,_that.driveTypes,_that.fuelType,_that.fuelConsumptionMax,_that.electricRangeMin,_that.seats,_that.doors,_that.curbWeightMin,_that.curbWeightMax,_that.grossWeightMin,_that.grossWeightMax,_that.cargoCapacityMin,_that.towingCapacityMin,_that.groundClearanceMin,_that.lengthMin,_that.lengthMax,_that.widthMin,_that.widthMax,_that.heightMin,_that.heightMax,_that.wheelbaseMin,_that.wheelbaseMax,_that.colors,_that.rimSizes,_that.paintTypes,_that.rimTypes,_that.tireConditions,_that.mileageMin,_that.mileageMax,_that.ownersMax,_that.accidentFree,_that.floodFree,_that.withWarranty,_that.completeServiceHistory,_that.conditions,_that.registrationStatuses,_that.emissionTestValid,_that.comprehensiveInsurance,_that.features,_that.minAirbags,_that.hasABS,_that.hasTractionControl,_that.hasStabilityControl,_that.hasCameras,_that.hasRearCamera,_that.has360Camera,_that.hasBlindSpot,_that.hasLaneDepartureWarning,_that.hasLaneAssist,_that.hasAdaptiveCruise,_that.hasForwardCollisionWarning,_that.hasAutomaticEmergencyBraking,_that.hasHillStartAssist,_that.hasHillDescentControl,_that.hasParkingSensors,_that.hasFrontParkingSensors,_that.hasRearParkingSensors,_that.hasClimateControl,_that.hasDualClimateControl,_that.hasSunroof,_that.hasPanoramicSunroof,_that.hasLeatherSeats,_that.hasPowerSeats,_that.hasHeatedSeats,_that.hasVentilatedSeats,_that.hasMemorySeats,_that.hasKeylessEntry,_that.hasPushStart,_that.hasPowerWindows,_that.hasPowerMirrors,_that.hasAutoFoldingMirrors,_that.hasPowerTailgate,_that.hasCruiseControl,_that.minInfotainmentSize,_that.hasTouchscreen,_that.hasCarPlay,_that.hasAndroidAuto,_that.hasNavigation,_that.hasBluetooth,_that.hasWirelessCharging,_that.hasPremiumAudio,_that.minSpeakerCount,_that.hasHeadUpDisplay,_that.hasDigitalCluster,_that.hasWifiHotspot,_that.minUSBPorts,_that.region,_that.province,_that.city,_that.distanceRadius,_that.testDriveAvailable,_that.deliveryAvailable,_that.homeDelivery,_that.dealershipPickup,_that.acceptsTrade,_that.financingAvailable,_that.bankFinancing,_that.inHouseFinancing,_that.negotiable,_that.cashOnly,_that.auctionsOnly,_that.directSaleOnly,_that.liveAuctionsOnly,_that.upcomingAuctionsOnly,_that.endingSoonOnly,_that.hasBuyNowPrice,_that.belowReservePrice,_that.noBidsYet,_that.featuredOnly,_that.verifiedSeller,_that.dealerOnly,_that.privateSellerOnly,_that.recentlyAddedDays,_that.recentlyUpdatedDays,_that.priceReduced,_that.newListing,_that.minViewCount,_that.minPhotoCount,_that.hasVideo,_that.has360View,_that.hasInteriorPhotos,_that.hasEnginePhotos,_that.sortBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchFilters extends SearchFilters {
  const _SearchFilters({this.keyword, final  List<String> brands = const [], this.yearMin, this.yearMax, this.priceMin, this.priceMax, final  List<BodyType> bodyType = const [], final  List<String> engineSizes = const [], final  List<EngineType> engineTypes = const [], final  List<int> cylinders = const [], this.horsepowerMin, this.horsepowerMax, this.torqueMin, this.torqueMax, final  List<TransmissionType> transmission = const [], final  List<int> transmissionSpeeds = const [], final  List<DriveType> driveTypes = const [], final  List<FuelType> fuelType = const [], this.fuelConsumptionMax, this.electricRangeMin, final  List<int> seats = const [], final  List<int> doors = const [], this.curbWeightMin, this.curbWeightMax, this.grossWeightMin, this.grossWeightMax, this.cargoCapacityMin, this.towingCapacityMin, this.groundClearanceMin, this.lengthMin, this.lengthMax, this.widthMin, this.widthMax, this.heightMin, this.heightMax, this.wheelbaseMin, this.wheelbaseMax, final  List<String> colors = const [], final  List<int> rimSizes = const [], final  List<PaintType> paintTypes = const [], final  List<RimType> rimTypes = const [], final  List<TireCondition> tireConditions = const [], this.mileageMin, this.mileageMax, this.ownersMax, this.accidentFree = false, this.floodFree = false, this.withWarranty = false, this.completeServiceHistory = false, final  List<CarCondition> conditions = const [], final  List<RegistrationStatus> registrationStatuses = const [], this.emissionTestValid = false, this.comprehensiveInsurance = false, final  List<String> features = const [], this.minAirbags, this.hasABS = false, this.hasTractionControl = false, this.hasStabilityControl = false, this.hasCameras = false, this.hasRearCamera = false, this.has360Camera = false, this.hasBlindSpot = false, this.hasLaneDepartureWarning = false, this.hasLaneAssist = false, this.hasAdaptiveCruise = false, this.hasForwardCollisionWarning = false, this.hasAutomaticEmergencyBraking = false, this.hasHillStartAssist = false, this.hasHillDescentControl = false, this.hasParkingSensors = false, this.hasFrontParkingSensors = false, this.hasRearParkingSensors = false, this.hasClimateControl = false, this.hasDualClimateControl = false, this.hasSunroof = false, this.hasPanoramicSunroof = false, this.hasLeatherSeats = false, this.hasPowerSeats = false, this.hasHeatedSeats = false, this.hasVentilatedSeats = false, this.hasMemorySeats = false, this.hasKeylessEntry = false, this.hasPushStart = false, this.hasPowerWindows = false, this.hasPowerMirrors = false, this.hasAutoFoldingMirrors = false, this.hasPowerTailgate = false, this.hasCruiseControl = false, this.minInfotainmentSize, this.hasTouchscreen = false, this.hasCarPlay = false, this.hasAndroidAuto = false, this.hasNavigation = false, this.hasBluetooth = false, this.hasWirelessCharging = false, this.hasPremiumAudio = false, this.minSpeakerCount, this.hasHeadUpDisplay = false, this.hasDigitalCluster = false, this.hasWifiHotspot = false, this.minUSBPorts, this.region, this.province, this.city, this.distanceRadius, this.testDriveAvailable = false, this.deliveryAvailable = false, this.homeDelivery = false, this.dealershipPickup = false, this.acceptsTrade = false, this.financingAvailable = false, this.bankFinancing = false, this.inHouseFinancing = false, this.negotiable = false, this.cashOnly = false, this.auctionsOnly = false, this.directSaleOnly = false, this.liveAuctionsOnly = false, this.upcomingAuctionsOnly = false, this.endingSoonOnly = false, this.hasBuyNowPrice = false, this.belowReservePrice = false, this.noBidsYet = false, this.featuredOnly = false, this.verifiedSeller = false, this.dealerOnly = false, this.privateSellerOnly = false, this.recentlyAddedDays, this.recentlyUpdatedDays, this.priceReduced = false, this.newListing = false, this.minViewCount, this.minPhotoCount, this.hasVideo = false, this.has360View = false, this.hasInteriorPhotos = false, this.hasEnginePhotos = false, this.sortBy = SortBy.newest}): _brands = brands,_bodyType = bodyType,_engineSizes = engineSizes,_engineTypes = engineTypes,_cylinders = cylinders,_transmission = transmission,_transmissionSpeeds = transmissionSpeeds,_driveTypes = driveTypes,_fuelType = fuelType,_seats = seats,_doors = doors,_colors = colors,_rimSizes = rimSizes,_paintTypes = paintTypes,_rimTypes = rimTypes,_tireConditions = tireConditions,_conditions = conditions,_registrationStatuses = registrationStatuses,_features = features,super._();
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
@override final  int? grossWeightMin;
@override final  int? grossWeightMax;
@override final  int? cargoCapacityMin;
@override final  int? towingCapacityMin;
@override final  int? groundClearanceMin;
@override final  int? lengthMin;
@override final  int? lengthMax;
@override final  int? widthMin;
@override final  int? widthMax;
@override final  int? heightMin;
@override final  int? heightMax;
@override final  int? wheelbaseMin;
@override final  int? wheelbaseMax;
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

 final  List<RimType> _rimTypes;
@override@JsonKey() List<RimType> get rimTypes {
  if (_rimTypes is EqualUnmodifiableListView) return _rimTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rimTypes);
}

 final  List<TireCondition> _tireConditions;
@override@JsonKey() List<TireCondition> get tireConditions {
  if (_tireConditions is EqualUnmodifiableListView) return _tireConditions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tireConditions);
}

// Condition & History
@override final  int? mileageMin;
@override final  int? mileageMax;
@override final  int? ownersMax;
@override@JsonKey() final  bool accidentFree;
@override@JsonKey() final  bool floodFree;
@override@JsonKey() final  bool withWarranty;
@override@JsonKey() final  bool completeServiceHistory;
 final  List<CarCondition> _conditions;
@override@JsonKey() List<CarCondition> get conditions {
  if (_conditions is EqualUnmodifiableListView) return _conditions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conditions);
}

 final  List<RegistrationStatus> _registrationStatuses;
@override@JsonKey() List<RegistrationStatus> get registrationStatuses {
  if (_registrationStatuses is EqualUnmodifiableListView) return _registrationStatuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_registrationStatuses);
}

@override@JsonKey() final  bool emissionTestValid;
@override@JsonKey() final  bool comprehensiveInsurance;
// Features (select any from comprehensive list)
 final  List<String> _features;
// Features (select any from comprehensive list)
@override@JsonKey() List<String> get features {
  if (_features is EqualUnmodifiableListView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_features);
}

// Safety Features
@override final  int? minAirbags;
@override@JsonKey() final  bool hasABS;
@override@JsonKey() final  bool hasTractionControl;
@override@JsonKey() final  bool hasStabilityControl;
@override@JsonKey() final  bool hasCameras;
@override@JsonKey() final  bool hasRearCamera;
@override@JsonKey() final  bool has360Camera;
@override@JsonKey() final  bool hasBlindSpot;
@override@JsonKey() final  bool hasLaneDepartureWarning;
@override@JsonKey() final  bool hasLaneAssist;
@override@JsonKey() final  bool hasAdaptiveCruise;
@override@JsonKey() final  bool hasForwardCollisionWarning;
@override@JsonKey() final  bool hasAutomaticEmergencyBraking;
@override@JsonKey() final  bool hasHillStartAssist;
@override@JsonKey() final  bool hasHillDescentControl;
@override@JsonKey() final  bool hasParkingSensors;
@override@JsonKey() final  bool hasFrontParkingSensors;
@override@JsonKey() final  bool hasRearParkingSensors;
// Comfort & Convenience
@override@JsonKey() final  bool hasClimateControl;
@override@JsonKey() final  bool hasDualClimateControl;
@override@JsonKey() final  bool hasSunroof;
@override@JsonKey() final  bool hasPanoramicSunroof;
@override@JsonKey() final  bool hasLeatherSeats;
@override@JsonKey() final  bool hasPowerSeats;
@override@JsonKey() final  bool hasHeatedSeats;
@override@JsonKey() final  bool hasVentilatedSeats;
@override@JsonKey() final  bool hasMemorySeats;
@override@JsonKey() final  bool hasKeylessEntry;
@override@JsonKey() final  bool hasPushStart;
@override@JsonKey() final  bool hasPowerWindows;
@override@JsonKey() final  bool hasPowerMirrors;
@override@JsonKey() final  bool hasAutoFoldingMirrors;
@override@JsonKey() final  bool hasPowerTailgate;
@override@JsonKey() final  bool hasCruiseControl;
// Technology & Infotainment
@override final  int? minInfotainmentSize;
@override@JsonKey() final  bool hasTouchscreen;
@override@JsonKey() final  bool hasCarPlay;
@override@JsonKey() final  bool hasAndroidAuto;
@override@JsonKey() final  bool hasNavigation;
@override@JsonKey() final  bool hasBluetooth;
@override@JsonKey() final  bool hasWirelessCharging;
@override@JsonKey() final  bool hasPremiumAudio;
@override final  int? minSpeakerCount;
@override@JsonKey() final  bool hasHeadUpDisplay;
@override@JsonKey() final  bool hasDigitalCluster;
@override@JsonKey() final  bool hasWifiHotspot;
@override final  int? minUSBPorts;
// Location & Availability
@override final  String? region;
@override final  String? province;
@override final  String? city;
@override final  int? distanceRadius;
@override@JsonKey() final  bool testDriveAvailable;
@override@JsonKey() final  bool deliveryAvailable;
@override@JsonKey() final  bool homeDelivery;
@override@JsonKey() final  bool dealershipPickup;
// Seller Preferences
@override@JsonKey() final  bool acceptsTrade;
@override@JsonKey() final  bool financingAvailable;
@override@JsonKey() final  bool bankFinancing;
@override@JsonKey() final  bool inHouseFinancing;
@override@JsonKey() final  bool negotiable;
@override@JsonKey() final  bool cashOnly;
// Listing Type & Status
@override@JsonKey() final  bool auctionsOnly;
@override@JsonKey() final  bool directSaleOnly;
@override@JsonKey() final  bool liveAuctionsOnly;
@override@JsonKey() final  bool upcomingAuctionsOnly;
@override@JsonKey() final  bool endingSoonOnly;
@override@JsonKey() final  bool hasBuyNowPrice;
@override@JsonKey() final  bool belowReservePrice;
@override@JsonKey() final  bool noBidsYet;
// Special Filters
@override@JsonKey() final  bool featuredOnly;
@override@JsonKey() final  bool verifiedSeller;
@override@JsonKey() final  bool dealerOnly;
@override@JsonKey() final  bool privateSellerOnly;
@override final  int? recentlyAddedDays;
@override final  int? recentlyUpdatedDays;
@override@JsonKey() final  bool priceReduced;
@override@JsonKey() final  bool newListing;
@override final  int? minViewCount;
// Media Filters
@override final  int? minPhotoCount;
@override@JsonKey() final  bool hasVideo;
@override@JsonKey() final  bool has360View;
@override@JsonKey() final  bool hasInteriorPhotos;
@override@JsonKey() final  bool hasEnginePhotos;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchFilters&&(identical(other.keyword, keyword) || other.keyword == keyword)&&const DeepCollectionEquality().equals(other._brands, _brands)&&(identical(other.yearMin, yearMin) || other.yearMin == yearMin)&&(identical(other.yearMax, yearMax) || other.yearMax == yearMax)&&(identical(other.priceMin, priceMin) || other.priceMin == priceMin)&&(identical(other.priceMax, priceMax) || other.priceMax == priceMax)&&const DeepCollectionEquality().equals(other._bodyType, _bodyType)&&const DeepCollectionEquality().equals(other._engineSizes, _engineSizes)&&const DeepCollectionEquality().equals(other._engineTypes, _engineTypes)&&const DeepCollectionEquality().equals(other._cylinders, _cylinders)&&(identical(other.horsepowerMin, horsepowerMin) || other.horsepowerMin == horsepowerMin)&&(identical(other.horsepowerMax, horsepowerMax) || other.horsepowerMax == horsepowerMax)&&(identical(other.torqueMin, torqueMin) || other.torqueMin == torqueMin)&&(identical(other.torqueMax, torqueMax) || other.torqueMax == torqueMax)&&const DeepCollectionEquality().equals(other._transmission, _transmission)&&const DeepCollectionEquality().equals(other._transmissionSpeeds, _transmissionSpeeds)&&const DeepCollectionEquality().equals(other._driveTypes, _driveTypes)&&const DeepCollectionEquality().equals(other._fuelType, _fuelType)&&(identical(other.fuelConsumptionMax, fuelConsumptionMax) || other.fuelConsumptionMax == fuelConsumptionMax)&&(identical(other.electricRangeMin, electricRangeMin) || other.electricRangeMin == electricRangeMin)&&const DeepCollectionEquality().equals(other._seats, _seats)&&const DeepCollectionEquality().equals(other._doors, _doors)&&(identical(other.curbWeightMin, curbWeightMin) || other.curbWeightMin == curbWeightMin)&&(identical(other.curbWeightMax, curbWeightMax) || other.curbWeightMax == curbWeightMax)&&(identical(other.grossWeightMin, grossWeightMin) || other.grossWeightMin == grossWeightMin)&&(identical(other.grossWeightMax, grossWeightMax) || other.grossWeightMax == grossWeightMax)&&(identical(other.cargoCapacityMin, cargoCapacityMin) || other.cargoCapacityMin == cargoCapacityMin)&&(identical(other.towingCapacityMin, towingCapacityMin) || other.towingCapacityMin == towingCapacityMin)&&(identical(other.groundClearanceMin, groundClearanceMin) || other.groundClearanceMin == groundClearanceMin)&&(identical(other.lengthMin, lengthMin) || other.lengthMin == lengthMin)&&(identical(other.lengthMax, lengthMax) || other.lengthMax == lengthMax)&&(identical(other.widthMin, widthMin) || other.widthMin == widthMin)&&(identical(other.widthMax, widthMax) || other.widthMax == widthMax)&&(identical(other.heightMin, heightMin) || other.heightMin == heightMin)&&(identical(other.heightMax, heightMax) || other.heightMax == heightMax)&&(identical(other.wheelbaseMin, wheelbaseMin) || other.wheelbaseMin == wheelbaseMin)&&(identical(other.wheelbaseMax, wheelbaseMax) || other.wheelbaseMax == wheelbaseMax)&&const DeepCollectionEquality().equals(other._colors, _colors)&&const DeepCollectionEquality().equals(other._rimSizes, _rimSizes)&&const DeepCollectionEquality().equals(other._paintTypes, _paintTypes)&&const DeepCollectionEquality().equals(other._rimTypes, _rimTypes)&&const DeepCollectionEquality().equals(other._tireConditions, _tireConditions)&&(identical(other.mileageMin, mileageMin) || other.mileageMin == mileageMin)&&(identical(other.mileageMax, mileageMax) || other.mileageMax == mileageMax)&&(identical(other.ownersMax, ownersMax) || other.ownersMax == ownersMax)&&(identical(other.accidentFree, accidentFree) || other.accidentFree == accidentFree)&&(identical(other.floodFree, floodFree) || other.floodFree == floodFree)&&(identical(other.withWarranty, withWarranty) || other.withWarranty == withWarranty)&&(identical(other.completeServiceHistory, completeServiceHistory) || other.completeServiceHistory == completeServiceHistory)&&const DeepCollectionEquality().equals(other._conditions, _conditions)&&const DeepCollectionEquality().equals(other._registrationStatuses, _registrationStatuses)&&(identical(other.emissionTestValid, emissionTestValid) || other.emissionTestValid == emissionTestValid)&&(identical(other.comprehensiveInsurance, comprehensiveInsurance) || other.comprehensiveInsurance == comprehensiveInsurance)&&const DeepCollectionEquality().equals(other._features, _features)&&(identical(other.minAirbags, minAirbags) || other.minAirbags == minAirbags)&&(identical(other.hasABS, hasABS) || other.hasABS == hasABS)&&(identical(other.hasTractionControl, hasTractionControl) || other.hasTractionControl == hasTractionControl)&&(identical(other.hasStabilityControl, hasStabilityControl) || other.hasStabilityControl == hasStabilityControl)&&(identical(other.hasCameras, hasCameras) || other.hasCameras == hasCameras)&&(identical(other.hasRearCamera, hasRearCamera) || other.hasRearCamera == hasRearCamera)&&(identical(other.has360Camera, has360Camera) || other.has360Camera == has360Camera)&&(identical(other.hasBlindSpot, hasBlindSpot) || other.hasBlindSpot == hasBlindSpot)&&(identical(other.hasLaneDepartureWarning, hasLaneDepartureWarning) || other.hasLaneDepartureWarning == hasLaneDepartureWarning)&&(identical(other.hasLaneAssist, hasLaneAssist) || other.hasLaneAssist == hasLaneAssist)&&(identical(other.hasAdaptiveCruise, hasAdaptiveCruise) || other.hasAdaptiveCruise == hasAdaptiveCruise)&&(identical(other.hasForwardCollisionWarning, hasForwardCollisionWarning) || other.hasForwardCollisionWarning == hasForwardCollisionWarning)&&(identical(other.hasAutomaticEmergencyBraking, hasAutomaticEmergencyBraking) || other.hasAutomaticEmergencyBraking == hasAutomaticEmergencyBraking)&&(identical(other.hasHillStartAssist, hasHillStartAssist) || other.hasHillStartAssist == hasHillStartAssist)&&(identical(other.hasHillDescentControl, hasHillDescentControl) || other.hasHillDescentControl == hasHillDescentControl)&&(identical(other.hasParkingSensors, hasParkingSensors) || other.hasParkingSensors == hasParkingSensors)&&(identical(other.hasFrontParkingSensors, hasFrontParkingSensors) || other.hasFrontParkingSensors == hasFrontParkingSensors)&&(identical(other.hasRearParkingSensors, hasRearParkingSensors) || other.hasRearParkingSensors == hasRearParkingSensors)&&(identical(other.hasClimateControl, hasClimateControl) || other.hasClimateControl == hasClimateControl)&&(identical(other.hasDualClimateControl, hasDualClimateControl) || other.hasDualClimateControl == hasDualClimateControl)&&(identical(other.hasSunroof, hasSunroof) || other.hasSunroof == hasSunroof)&&(identical(other.hasPanoramicSunroof, hasPanoramicSunroof) || other.hasPanoramicSunroof == hasPanoramicSunroof)&&(identical(other.hasLeatherSeats, hasLeatherSeats) || other.hasLeatherSeats == hasLeatherSeats)&&(identical(other.hasPowerSeats, hasPowerSeats) || other.hasPowerSeats == hasPowerSeats)&&(identical(other.hasHeatedSeats, hasHeatedSeats) || other.hasHeatedSeats == hasHeatedSeats)&&(identical(other.hasVentilatedSeats, hasVentilatedSeats) || other.hasVentilatedSeats == hasVentilatedSeats)&&(identical(other.hasMemorySeats, hasMemorySeats) || other.hasMemorySeats == hasMemorySeats)&&(identical(other.hasKeylessEntry, hasKeylessEntry) || other.hasKeylessEntry == hasKeylessEntry)&&(identical(other.hasPushStart, hasPushStart) || other.hasPushStart == hasPushStart)&&(identical(other.hasPowerWindows, hasPowerWindows) || other.hasPowerWindows == hasPowerWindows)&&(identical(other.hasPowerMirrors, hasPowerMirrors) || other.hasPowerMirrors == hasPowerMirrors)&&(identical(other.hasAutoFoldingMirrors, hasAutoFoldingMirrors) || other.hasAutoFoldingMirrors == hasAutoFoldingMirrors)&&(identical(other.hasPowerTailgate, hasPowerTailgate) || other.hasPowerTailgate == hasPowerTailgate)&&(identical(other.hasCruiseControl, hasCruiseControl) || other.hasCruiseControl == hasCruiseControl)&&(identical(other.minInfotainmentSize, minInfotainmentSize) || other.minInfotainmentSize == minInfotainmentSize)&&(identical(other.hasTouchscreen, hasTouchscreen) || other.hasTouchscreen == hasTouchscreen)&&(identical(other.hasCarPlay, hasCarPlay) || other.hasCarPlay == hasCarPlay)&&(identical(other.hasAndroidAuto, hasAndroidAuto) || other.hasAndroidAuto == hasAndroidAuto)&&(identical(other.hasNavigation, hasNavigation) || other.hasNavigation == hasNavigation)&&(identical(other.hasBluetooth, hasBluetooth) || other.hasBluetooth == hasBluetooth)&&(identical(other.hasWirelessCharging, hasWirelessCharging) || other.hasWirelessCharging == hasWirelessCharging)&&(identical(other.hasPremiumAudio, hasPremiumAudio) || other.hasPremiumAudio == hasPremiumAudio)&&(identical(other.minSpeakerCount, minSpeakerCount) || other.minSpeakerCount == minSpeakerCount)&&(identical(other.hasHeadUpDisplay, hasHeadUpDisplay) || other.hasHeadUpDisplay == hasHeadUpDisplay)&&(identical(other.hasDigitalCluster, hasDigitalCluster) || other.hasDigitalCluster == hasDigitalCluster)&&(identical(other.hasWifiHotspot, hasWifiHotspot) || other.hasWifiHotspot == hasWifiHotspot)&&(identical(other.minUSBPorts, minUSBPorts) || other.minUSBPorts == minUSBPorts)&&(identical(other.region, region) || other.region == region)&&(identical(other.province, province) || other.province == province)&&(identical(other.city, city) || other.city == city)&&(identical(other.distanceRadius, distanceRadius) || other.distanceRadius == distanceRadius)&&(identical(other.testDriveAvailable, testDriveAvailable) || other.testDriveAvailable == testDriveAvailable)&&(identical(other.deliveryAvailable, deliveryAvailable) || other.deliveryAvailable == deliveryAvailable)&&(identical(other.homeDelivery, homeDelivery) || other.homeDelivery == homeDelivery)&&(identical(other.dealershipPickup, dealershipPickup) || other.dealershipPickup == dealershipPickup)&&(identical(other.acceptsTrade, acceptsTrade) || other.acceptsTrade == acceptsTrade)&&(identical(other.financingAvailable, financingAvailable) || other.financingAvailable == financingAvailable)&&(identical(other.bankFinancing, bankFinancing) || other.bankFinancing == bankFinancing)&&(identical(other.inHouseFinancing, inHouseFinancing) || other.inHouseFinancing == inHouseFinancing)&&(identical(other.negotiable, negotiable) || other.negotiable == negotiable)&&(identical(other.cashOnly, cashOnly) || other.cashOnly == cashOnly)&&(identical(other.auctionsOnly, auctionsOnly) || other.auctionsOnly == auctionsOnly)&&(identical(other.directSaleOnly, directSaleOnly) || other.directSaleOnly == directSaleOnly)&&(identical(other.liveAuctionsOnly, liveAuctionsOnly) || other.liveAuctionsOnly == liveAuctionsOnly)&&(identical(other.upcomingAuctionsOnly, upcomingAuctionsOnly) || other.upcomingAuctionsOnly == upcomingAuctionsOnly)&&(identical(other.endingSoonOnly, endingSoonOnly) || other.endingSoonOnly == endingSoonOnly)&&(identical(other.hasBuyNowPrice, hasBuyNowPrice) || other.hasBuyNowPrice == hasBuyNowPrice)&&(identical(other.belowReservePrice, belowReservePrice) || other.belowReservePrice == belowReservePrice)&&(identical(other.noBidsYet, noBidsYet) || other.noBidsYet == noBidsYet)&&(identical(other.featuredOnly, featuredOnly) || other.featuredOnly == featuredOnly)&&(identical(other.verifiedSeller, verifiedSeller) || other.verifiedSeller == verifiedSeller)&&(identical(other.dealerOnly, dealerOnly) || other.dealerOnly == dealerOnly)&&(identical(other.privateSellerOnly, privateSellerOnly) || other.privateSellerOnly == privateSellerOnly)&&(identical(other.recentlyAddedDays, recentlyAddedDays) || other.recentlyAddedDays == recentlyAddedDays)&&(identical(other.recentlyUpdatedDays, recentlyUpdatedDays) || other.recentlyUpdatedDays == recentlyUpdatedDays)&&(identical(other.priceReduced, priceReduced) || other.priceReduced == priceReduced)&&(identical(other.newListing, newListing) || other.newListing == newListing)&&(identical(other.minViewCount, minViewCount) || other.minViewCount == minViewCount)&&(identical(other.minPhotoCount, minPhotoCount) || other.minPhotoCount == minPhotoCount)&&(identical(other.hasVideo, hasVideo) || other.hasVideo == hasVideo)&&(identical(other.has360View, has360View) || other.has360View == has360View)&&(identical(other.hasInteriorPhotos, hasInteriorPhotos) || other.hasInteriorPhotos == hasInteriorPhotos)&&(identical(other.hasEnginePhotos, hasEnginePhotos) || other.hasEnginePhotos == hasEnginePhotos)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,keyword,const DeepCollectionEquality().hash(_brands),yearMin,yearMax,priceMin,priceMax,const DeepCollectionEquality().hash(_bodyType),const DeepCollectionEquality().hash(_engineSizes),const DeepCollectionEquality().hash(_engineTypes),const DeepCollectionEquality().hash(_cylinders),horsepowerMin,horsepowerMax,torqueMin,torqueMax,const DeepCollectionEquality().hash(_transmission),const DeepCollectionEquality().hash(_transmissionSpeeds),const DeepCollectionEquality().hash(_driveTypes),const DeepCollectionEquality().hash(_fuelType),fuelConsumptionMax,electricRangeMin,const DeepCollectionEquality().hash(_seats),const DeepCollectionEquality().hash(_doors),curbWeightMin,curbWeightMax,grossWeightMin,grossWeightMax,cargoCapacityMin,towingCapacityMin,groundClearanceMin,lengthMin,lengthMax,widthMin,widthMax,heightMin,heightMax,wheelbaseMin,wheelbaseMax,const DeepCollectionEquality().hash(_colors),const DeepCollectionEquality().hash(_rimSizes),const DeepCollectionEquality().hash(_paintTypes),const DeepCollectionEquality().hash(_rimTypes),const DeepCollectionEquality().hash(_tireConditions),mileageMin,mileageMax,ownersMax,accidentFree,floodFree,withWarranty,completeServiceHistory,const DeepCollectionEquality().hash(_conditions),const DeepCollectionEquality().hash(_registrationStatuses),emissionTestValid,comprehensiveInsurance,const DeepCollectionEquality().hash(_features),minAirbags,hasABS,hasTractionControl,hasStabilityControl,hasCameras,hasRearCamera,has360Camera,hasBlindSpot,hasLaneDepartureWarning,hasLaneAssist,hasAdaptiveCruise,hasForwardCollisionWarning,hasAutomaticEmergencyBraking,hasHillStartAssist,hasHillDescentControl,hasParkingSensors,hasFrontParkingSensors,hasRearParkingSensors,hasClimateControl,hasDualClimateControl,hasSunroof,hasPanoramicSunroof,hasLeatherSeats,hasPowerSeats,hasHeatedSeats,hasVentilatedSeats,hasMemorySeats,hasKeylessEntry,hasPushStart,hasPowerWindows,hasPowerMirrors,hasAutoFoldingMirrors,hasPowerTailgate,hasCruiseControl,minInfotainmentSize,hasTouchscreen,hasCarPlay,hasAndroidAuto,hasNavigation,hasBluetooth,hasWirelessCharging,hasPremiumAudio,minSpeakerCount,hasHeadUpDisplay,hasDigitalCluster,hasWifiHotspot,minUSBPorts,region,province,city,distanceRadius,testDriveAvailable,deliveryAvailable,homeDelivery,dealershipPickup,acceptsTrade,financingAvailable,bankFinancing,inHouseFinancing,negotiable,cashOnly,auctionsOnly,directSaleOnly,liveAuctionsOnly,upcomingAuctionsOnly,endingSoonOnly,hasBuyNowPrice,belowReservePrice,noBidsYet,featuredOnly,verifiedSeller,dealerOnly,privateSellerOnly,recentlyAddedDays,recentlyUpdatedDays,priceReduced,newListing,minViewCount,minPhotoCount,hasVideo,has360View,hasInteriorPhotos,hasEnginePhotos,sortBy]);

@override
String toString() {
  return 'SearchFilters(keyword: $keyword, brands: $brands, yearMin: $yearMin, yearMax: $yearMax, priceMin: $priceMin, priceMax: $priceMax, bodyType: $bodyType, engineSizes: $engineSizes, engineTypes: $engineTypes, cylinders: $cylinders, horsepowerMin: $horsepowerMin, horsepowerMax: $horsepowerMax, torqueMin: $torqueMin, torqueMax: $torqueMax, transmission: $transmission, transmissionSpeeds: $transmissionSpeeds, driveTypes: $driveTypes, fuelType: $fuelType, fuelConsumptionMax: $fuelConsumptionMax, electricRangeMin: $electricRangeMin, seats: $seats, doors: $doors, curbWeightMin: $curbWeightMin, curbWeightMax: $curbWeightMax, grossWeightMin: $grossWeightMin, grossWeightMax: $grossWeightMax, cargoCapacityMin: $cargoCapacityMin, towingCapacityMin: $towingCapacityMin, groundClearanceMin: $groundClearanceMin, lengthMin: $lengthMin, lengthMax: $lengthMax, widthMin: $widthMin, widthMax: $widthMax, heightMin: $heightMin, heightMax: $heightMax, wheelbaseMin: $wheelbaseMin, wheelbaseMax: $wheelbaseMax, colors: $colors, rimSizes: $rimSizes, paintTypes: $paintTypes, rimTypes: $rimTypes, tireConditions: $tireConditions, mileageMin: $mileageMin, mileageMax: $mileageMax, ownersMax: $ownersMax, accidentFree: $accidentFree, floodFree: $floodFree, withWarranty: $withWarranty, completeServiceHistory: $completeServiceHistory, conditions: $conditions, registrationStatuses: $registrationStatuses, emissionTestValid: $emissionTestValid, comprehensiveInsurance: $comprehensiveInsurance, features: $features, minAirbags: $minAirbags, hasABS: $hasABS, hasTractionControl: $hasTractionControl, hasStabilityControl: $hasStabilityControl, hasCameras: $hasCameras, hasRearCamera: $hasRearCamera, has360Camera: $has360Camera, hasBlindSpot: $hasBlindSpot, hasLaneDepartureWarning: $hasLaneDepartureWarning, hasLaneAssist: $hasLaneAssist, hasAdaptiveCruise: $hasAdaptiveCruise, hasForwardCollisionWarning: $hasForwardCollisionWarning, hasAutomaticEmergencyBraking: $hasAutomaticEmergencyBraking, hasHillStartAssist: $hasHillStartAssist, hasHillDescentControl: $hasHillDescentControl, hasParkingSensors: $hasParkingSensors, hasFrontParkingSensors: $hasFrontParkingSensors, hasRearParkingSensors: $hasRearParkingSensors, hasClimateControl: $hasClimateControl, hasDualClimateControl: $hasDualClimateControl, hasSunroof: $hasSunroof, hasPanoramicSunroof: $hasPanoramicSunroof, hasLeatherSeats: $hasLeatherSeats, hasPowerSeats: $hasPowerSeats, hasHeatedSeats: $hasHeatedSeats, hasVentilatedSeats: $hasVentilatedSeats, hasMemorySeats: $hasMemorySeats, hasKeylessEntry: $hasKeylessEntry, hasPushStart: $hasPushStart, hasPowerWindows: $hasPowerWindows, hasPowerMirrors: $hasPowerMirrors, hasAutoFoldingMirrors: $hasAutoFoldingMirrors, hasPowerTailgate: $hasPowerTailgate, hasCruiseControl: $hasCruiseControl, minInfotainmentSize: $minInfotainmentSize, hasTouchscreen: $hasTouchscreen, hasCarPlay: $hasCarPlay, hasAndroidAuto: $hasAndroidAuto, hasNavigation: $hasNavigation, hasBluetooth: $hasBluetooth, hasWirelessCharging: $hasWirelessCharging, hasPremiumAudio: $hasPremiumAudio, minSpeakerCount: $minSpeakerCount, hasHeadUpDisplay: $hasHeadUpDisplay, hasDigitalCluster: $hasDigitalCluster, hasWifiHotspot: $hasWifiHotspot, minUSBPorts: $minUSBPorts, region: $region, province: $province, city: $city, distanceRadius: $distanceRadius, testDriveAvailable: $testDriveAvailable, deliveryAvailable: $deliveryAvailable, homeDelivery: $homeDelivery, dealershipPickup: $dealershipPickup, acceptsTrade: $acceptsTrade, financingAvailable: $financingAvailable, bankFinancing: $bankFinancing, inHouseFinancing: $inHouseFinancing, negotiable: $negotiable, cashOnly: $cashOnly, auctionsOnly: $auctionsOnly, directSaleOnly: $directSaleOnly, liveAuctionsOnly: $liveAuctionsOnly, upcomingAuctionsOnly: $upcomingAuctionsOnly, endingSoonOnly: $endingSoonOnly, hasBuyNowPrice: $hasBuyNowPrice, belowReservePrice: $belowReservePrice, noBidsYet: $noBidsYet, featuredOnly: $featuredOnly, verifiedSeller: $verifiedSeller, dealerOnly: $dealerOnly, privateSellerOnly: $privateSellerOnly, recentlyAddedDays: $recentlyAddedDays, recentlyUpdatedDays: $recentlyUpdatedDays, priceReduced: $priceReduced, newListing: $newListing, minViewCount: $minViewCount, minPhotoCount: $minPhotoCount, hasVideo: $hasVideo, has360View: $has360View, hasInteriorPhotos: $hasInteriorPhotos, hasEnginePhotos: $hasEnginePhotos, sortBy: $sortBy)';
}


}

/// @nodoc
abstract mixin class _$SearchFiltersCopyWith<$Res> implements $SearchFiltersCopyWith<$Res> {
  factory _$SearchFiltersCopyWith(_SearchFilters value, $Res Function(_SearchFilters) _then) = __$SearchFiltersCopyWithImpl;
@override @useResult
$Res call({
 String? keyword, List<String> brands, int? yearMin, int? yearMax, double? priceMin, double? priceMax, List<BodyType> bodyType, List<String> engineSizes, List<EngineType> engineTypes, List<int> cylinders, int? horsepowerMin, int? horsepowerMax, int? torqueMin, int? torqueMax, List<TransmissionType> transmission, List<int> transmissionSpeeds, List<DriveType> driveTypes, List<FuelType> fuelType, double? fuelConsumptionMax, int? electricRangeMin, List<int> seats, List<int> doors, int? curbWeightMin, int? curbWeightMax, int? grossWeightMin, int? grossWeightMax, int? cargoCapacityMin, int? towingCapacityMin, int? groundClearanceMin, int? lengthMin, int? lengthMax, int? widthMin, int? widthMax, int? heightMin, int? heightMax, int? wheelbaseMin, int? wheelbaseMax, List<String> colors, List<int> rimSizes, List<PaintType> paintTypes, List<RimType> rimTypes, List<TireCondition> tireConditions, int? mileageMin, int? mileageMax, int? ownersMax, bool accidentFree, bool floodFree, bool withWarranty, bool completeServiceHistory, List<CarCondition> conditions, List<RegistrationStatus> registrationStatuses, bool emissionTestValid, bool comprehensiveInsurance, List<String> features, int? minAirbags, bool hasABS, bool hasTractionControl, bool hasStabilityControl, bool hasCameras, bool hasRearCamera, bool has360Camera, bool hasBlindSpot, bool hasLaneDepartureWarning, bool hasLaneAssist, bool hasAdaptiveCruise, bool hasForwardCollisionWarning, bool hasAutomaticEmergencyBraking, bool hasHillStartAssist, bool hasHillDescentControl, bool hasParkingSensors, bool hasFrontParkingSensors, bool hasRearParkingSensors, bool hasClimateControl, bool hasDualClimateControl, bool hasSunroof, bool hasPanoramicSunroof, bool hasLeatherSeats, bool hasPowerSeats, bool hasHeatedSeats, bool hasVentilatedSeats, bool hasMemorySeats, bool hasKeylessEntry, bool hasPushStart, bool hasPowerWindows, bool hasPowerMirrors, bool hasAutoFoldingMirrors, bool hasPowerTailgate, bool hasCruiseControl, int? minInfotainmentSize, bool hasTouchscreen, bool hasCarPlay, bool hasAndroidAuto, bool hasNavigation, bool hasBluetooth, bool hasWirelessCharging, bool hasPremiumAudio, int? minSpeakerCount, bool hasHeadUpDisplay, bool hasDigitalCluster, bool hasWifiHotspot, int? minUSBPorts, String? region, String? province, String? city, int? distanceRadius, bool testDriveAvailable, bool deliveryAvailable, bool homeDelivery, bool dealershipPickup, bool acceptsTrade, bool financingAvailable, bool bankFinancing, bool inHouseFinancing, bool negotiable, bool cashOnly, bool auctionsOnly, bool directSaleOnly, bool liveAuctionsOnly, bool upcomingAuctionsOnly, bool endingSoonOnly, bool hasBuyNowPrice, bool belowReservePrice, bool noBidsYet, bool featuredOnly, bool verifiedSeller, bool dealerOnly, bool privateSellerOnly, int? recentlyAddedDays, int? recentlyUpdatedDays, bool priceReduced, bool newListing, int? minViewCount, int? minPhotoCount, bool hasVideo, bool has360View, bool hasInteriorPhotos, bool hasEnginePhotos, SortBy sortBy
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
@override @pragma('vm:prefer-inline') $Res call({Object? keyword = freezed,Object? brands = null,Object? yearMin = freezed,Object? yearMax = freezed,Object? priceMin = freezed,Object? priceMax = freezed,Object? bodyType = null,Object? engineSizes = null,Object? engineTypes = null,Object? cylinders = null,Object? horsepowerMin = freezed,Object? horsepowerMax = freezed,Object? torqueMin = freezed,Object? torqueMax = freezed,Object? transmission = null,Object? transmissionSpeeds = null,Object? driveTypes = null,Object? fuelType = null,Object? fuelConsumptionMax = freezed,Object? electricRangeMin = freezed,Object? seats = null,Object? doors = null,Object? curbWeightMin = freezed,Object? curbWeightMax = freezed,Object? grossWeightMin = freezed,Object? grossWeightMax = freezed,Object? cargoCapacityMin = freezed,Object? towingCapacityMin = freezed,Object? groundClearanceMin = freezed,Object? lengthMin = freezed,Object? lengthMax = freezed,Object? widthMin = freezed,Object? widthMax = freezed,Object? heightMin = freezed,Object? heightMax = freezed,Object? wheelbaseMin = freezed,Object? wheelbaseMax = freezed,Object? colors = null,Object? rimSizes = null,Object? paintTypes = null,Object? rimTypes = null,Object? tireConditions = null,Object? mileageMin = freezed,Object? mileageMax = freezed,Object? ownersMax = freezed,Object? accidentFree = null,Object? floodFree = null,Object? withWarranty = null,Object? completeServiceHistory = null,Object? conditions = null,Object? registrationStatuses = null,Object? emissionTestValid = null,Object? comprehensiveInsurance = null,Object? features = null,Object? minAirbags = freezed,Object? hasABS = null,Object? hasTractionControl = null,Object? hasStabilityControl = null,Object? hasCameras = null,Object? hasRearCamera = null,Object? has360Camera = null,Object? hasBlindSpot = null,Object? hasLaneDepartureWarning = null,Object? hasLaneAssist = null,Object? hasAdaptiveCruise = null,Object? hasForwardCollisionWarning = null,Object? hasAutomaticEmergencyBraking = null,Object? hasHillStartAssist = null,Object? hasHillDescentControl = null,Object? hasParkingSensors = null,Object? hasFrontParkingSensors = null,Object? hasRearParkingSensors = null,Object? hasClimateControl = null,Object? hasDualClimateControl = null,Object? hasSunroof = null,Object? hasPanoramicSunroof = null,Object? hasLeatherSeats = null,Object? hasPowerSeats = null,Object? hasHeatedSeats = null,Object? hasVentilatedSeats = null,Object? hasMemorySeats = null,Object? hasKeylessEntry = null,Object? hasPushStart = null,Object? hasPowerWindows = null,Object? hasPowerMirrors = null,Object? hasAutoFoldingMirrors = null,Object? hasPowerTailgate = null,Object? hasCruiseControl = null,Object? minInfotainmentSize = freezed,Object? hasTouchscreen = null,Object? hasCarPlay = null,Object? hasAndroidAuto = null,Object? hasNavigation = null,Object? hasBluetooth = null,Object? hasWirelessCharging = null,Object? hasPremiumAudio = null,Object? minSpeakerCount = freezed,Object? hasHeadUpDisplay = null,Object? hasDigitalCluster = null,Object? hasWifiHotspot = null,Object? minUSBPorts = freezed,Object? region = freezed,Object? province = freezed,Object? city = freezed,Object? distanceRadius = freezed,Object? testDriveAvailable = null,Object? deliveryAvailable = null,Object? homeDelivery = null,Object? dealershipPickup = null,Object? acceptsTrade = null,Object? financingAvailable = null,Object? bankFinancing = null,Object? inHouseFinancing = null,Object? negotiable = null,Object? cashOnly = null,Object? auctionsOnly = null,Object? directSaleOnly = null,Object? liveAuctionsOnly = null,Object? upcomingAuctionsOnly = null,Object? endingSoonOnly = null,Object? hasBuyNowPrice = null,Object? belowReservePrice = null,Object? noBidsYet = null,Object? featuredOnly = null,Object? verifiedSeller = null,Object? dealerOnly = null,Object? privateSellerOnly = null,Object? recentlyAddedDays = freezed,Object? recentlyUpdatedDays = freezed,Object? priceReduced = null,Object? newListing = null,Object? minViewCount = freezed,Object? minPhotoCount = freezed,Object? hasVideo = null,Object? has360View = null,Object? hasInteriorPhotos = null,Object? hasEnginePhotos = null,Object? sortBy = null,}) {
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
as int?,grossWeightMin: freezed == grossWeightMin ? _self.grossWeightMin : grossWeightMin // ignore: cast_nullable_to_non_nullable
as int?,grossWeightMax: freezed == grossWeightMax ? _self.grossWeightMax : grossWeightMax // ignore: cast_nullable_to_non_nullable
as int?,cargoCapacityMin: freezed == cargoCapacityMin ? _self.cargoCapacityMin : cargoCapacityMin // ignore: cast_nullable_to_non_nullable
as int?,towingCapacityMin: freezed == towingCapacityMin ? _self.towingCapacityMin : towingCapacityMin // ignore: cast_nullable_to_non_nullable
as int?,groundClearanceMin: freezed == groundClearanceMin ? _self.groundClearanceMin : groundClearanceMin // ignore: cast_nullable_to_non_nullable
as int?,lengthMin: freezed == lengthMin ? _self.lengthMin : lengthMin // ignore: cast_nullable_to_non_nullable
as int?,lengthMax: freezed == lengthMax ? _self.lengthMax : lengthMax // ignore: cast_nullable_to_non_nullable
as int?,widthMin: freezed == widthMin ? _self.widthMin : widthMin // ignore: cast_nullable_to_non_nullable
as int?,widthMax: freezed == widthMax ? _self.widthMax : widthMax // ignore: cast_nullable_to_non_nullable
as int?,heightMin: freezed == heightMin ? _self.heightMin : heightMin // ignore: cast_nullable_to_non_nullable
as int?,heightMax: freezed == heightMax ? _self.heightMax : heightMax // ignore: cast_nullable_to_non_nullable
as int?,wheelbaseMin: freezed == wheelbaseMin ? _self.wheelbaseMin : wheelbaseMin // ignore: cast_nullable_to_non_nullable
as int?,wheelbaseMax: freezed == wheelbaseMax ? _self.wheelbaseMax : wheelbaseMax // ignore: cast_nullable_to_non_nullable
as int?,colors: null == colors ? _self._colors : colors // ignore: cast_nullable_to_non_nullable
as List<String>,rimSizes: null == rimSizes ? _self._rimSizes : rimSizes // ignore: cast_nullable_to_non_nullable
as List<int>,paintTypes: null == paintTypes ? _self._paintTypes : paintTypes // ignore: cast_nullable_to_non_nullable
as List<PaintType>,rimTypes: null == rimTypes ? _self._rimTypes : rimTypes // ignore: cast_nullable_to_non_nullable
as List<RimType>,tireConditions: null == tireConditions ? _self._tireConditions : tireConditions // ignore: cast_nullable_to_non_nullable
as List<TireCondition>,mileageMin: freezed == mileageMin ? _self.mileageMin : mileageMin // ignore: cast_nullable_to_non_nullable
as int?,mileageMax: freezed == mileageMax ? _self.mileageMax : mileageMax // ignore: cast_nullable_to_non_nullable
as int?,ownersMax: freezed == ownersMax ? _self.ownersMax : ownersMax // ignore: cast_nullable_to_non_nullable
as int?,accidentFree: null == accidentFree ? _self.accidentFree : accidentFree // ignore: cast_nullable_to_non_nullable
as bool,floodFree: null == floodFree ? _self.floodFree : floodFree // ignore: cast_nullable_to_non_nullable
as bool,withWarranty: null == withWarranty ? _self.withWarranty : withWarranty // ignore: cast_nullable_to_non_nullable
as bool,completeServiceHistory: null == completeServiceHistory ? _self.completeServiceHistory : completeServiceHistory // ignore: cast_nullable_to_non_nullable
as bool,conditions: null == conditions ? _self._conditions : conditions // ignore: cast_nullable_to_non_nullable
as List<CarCondition>,registrationStatuses: null == registrationStatuses ? _self._registrationStatuses : registrationStatuses // ignore: cast_nullable_to_non_nullable
as List<RegistrationStatus>,emissionTestValid: null == emissionTestValid ? _self.emissionTestValid : emissionTestValid // ignore: cast_nullable_to_non_nullable
as bool,comprehensiveInsurance: null == comprehensiveInsurance ? _self.comprehensiveInsurance : comprehensiveInsurance // ignore: cast_nullable_to_non_nullable
as bool,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as List<String>,minAirbags: freezed == minAirbags ? _self.minAirbags : minAirbags // ignore: cast_nullable_to_non_nullable
as int?,hasABS: null == hasABS ? _self.hasABS : hasABS // ignore: cast_nullable_to_non_nullable
as bool,hasTractionControl: null == hasTractionControl ? _self.hasTractionControl : hasTractionControl // ignore: cast_nullable_to_non_nullable
as bool,hasStabilityControl: null == hasStabilityControl ? _self.hasStabilityControl : hasStabilityControl // ignore: cast_nullable_to_non_nullable
as bool,hasCameras: null == hasCameras ? _self.hasCameras : hasCameras // ignore: cast_nullable_to_non_nullable
as bool,hasRearCamera: null == hasRearCamera ? _self.hasRearCamera : hasRearCamera // ignore: cast_nullable_to_non_nullable
as bool,has360Camera: null == has360Camera ? _self.has360Camera : has360Camera // ignore: cast_nullable_to_non_nullable
as bool,hasBlindSpot: null == hasBlindSpot ? _self.hasBlindSpot : hasBlindSpot // ignore: cast_nullable_to_non_nullable
as bool,hasLaneDepartureWarning: null == hasLaneDepartureWarning ? _self.hasLaneDepartureWarning : hasLaneDepartureWarning // ignore: cast_nullable_to_non_nullable
as bool,hasLaneAssist: null == hasLaneAssist ? _self.hasLaneAssist : hasLaneAssist // ignore: cast_nullable_to_non_nullable
as bool,hasAdaptiveCruise: null == hasAdaptiveCruise ? _self.hasAdaptiveCruise : hasAdaptiveCruise // ignore: cast_nullable_to_non_nullable
as bool,hasForwardCollisionWarning: null == hasForwardCollisionWarning ? _self.hasForwardCollisionWarning : hasForwardCollisionWarning // ignore: cast_nullable_to_non_nullable
as bool,hasAutomaticEmergencyBraking: null == hasAutomaticEmergencyBraking ? _self.hasAutomaticEmergencyBraking : hasAutomaticEmergencyBraking // ignore: cast_nullable_to_non_nullable
as bool,hasHillStartAssist: null == hasHillStartAssist ? _self.hasHillStartAssist : hasHillStartAssist // ignore: cast_nullable_to_non_nullable
as bool,hasHillDescentControl: null == hasHillDescentControl ? _self.hasHillDescentControl : hasHillDescentControl // ignore: cast_nullable_to_non_nullable
as bool,hasParkingSensors: null == hasParkingSensors ? _self.hasParkingSensors : hasParkingSensors // ignore: cast_nullable_to_non_nullable
as bool,hasFrontParkingSensors: null == hasFrontParkingSensors ? _self.hasFrontParkingSensors : hasFrontParkingSensors // ignore: cast_nullable_to_non_nullable
as bool,hasRearParkingSensors: null == hasRearParkingSensors ? _self.hasRearParkingSensors : hasRearParkingSensors // ignore: cast_nullable_to_non_nullable
as bool,hasClimateControl: null == hasClimateControl ? _self.hasClimateControl : hasClimateControl // ignore: cast_nullable_to_non_nullable
as bool,hasDualClimateControl: null == hasDualClimateControl ? _self.hasDualClimateControl : hasDualClimateControl // ignore: cast_nullable_to_non_nullable
as bool,hasSunroof: null == hasSunroof ? _self.hasSunroof : hasSunroof // ignore: cast_nullable_to_non_nullable
as bool,hasPanoramicSunroof: null == hasPanoramicSunroof ? _self.hasPanoramicSunroof : hasPanoramicSunroof // ignore: cast_nullable_to_non_nullable
as bool,hasLeatherSeats: null == hasLeatherSeats ? _self.hasLeatherSeats : hasLeatherSeats // ignore: cast_nullable_to_non_nullable
as bool,hasPowerSeats: null == hasPowerSeats ? _self.hasPowerSeats : hasPowerSeats // ignore: cast_nullable_to_non_nullable
as bool,hasHeatedSeats: null == hasHeatedSeats ? _self.hasHeatedSeats : hasHeatedSeats // ignore: cast_nullable_to_non_nullable
as bool,hasVentilatedSeats: null == hasVentilatedSeats ? _self.hasVentilatedSeats : hasVentilatedSeats // ignore: cast_nullable_to_non_nullable
as bool,hasMemorySeats: null == hasMemorySeats ? _self.hasMemorySeats : hasMemorySeats // ignore: cast_nullable_to_non_nullable
as bool,hasKeylessEntry: null == hasKeylessEntry ? _self.hasKeylessEntry : hasKeylessEntry // ignore: cast_nullable_to_non_nullable
as bool,hasPushStart: null == hasPushStart ? _self.hasPushStart : hasPushStart // ignore: cast_nullable_to_non_nullable
as bool,hasPowerWindows: null == hasPowerWindows ? _self.hasPowerWindows : hasPowerWindows // ignore: cast_nullable_to_non_nullable
as bool,hasPowerMirrors: null == hasPowerMirrors ? _self.hasPowerMirrors : hasPowerMirrors // ignore: cast_nullable_to_non_nullable
as bool,hasAutoFoldingMirrors: null == hasAutoFoldingMirrors ? _self.hasAutoFoldingMirrors : hasAutoFoldingMirrors // ignore: cast_nullable_to_non_nullable
as bool,hasPowerTailgate: null == hasPowerTailgate ? _self.hasPowerTailgate : hasPowerTailgate // ignore: cast_nullable_to_non_nullable
as bool,hasCruiseControl: null == hasCruiseControl ? _self.hasCruiseControl : hasCruiseControl // ignore: cast_nullable_to_non_nullable
as bool,minInfotainmentSize: freezed == minInfotainmentSize ? _self.minInfotainmentSize : minInfotainmentSize // ignore: cast_nullable_to_non_nullable
as int?,hasTouchscreen: null == hasTouchscreen ? _self.hasTouchscreen : hasTouchscreen // ignore: cast_nullable_to_non_nullable
as bool,hasCarPlay: null == hasCarPlay ? _self.hasCarPlay : hasCarPlay // ignore: cast_nullable_to_non_nullable
as bool,hasAndroidAuto: null == hasAndroidAuto ? _self.hasAndroidAuto : hasAndroidAuto // ignore: cast_nullable_to_non_nullable
as bool,hasNavigation: null == hasNavigation ? _self.hasNavigation : hasNavigation // ignore: cast_nullable_to_non_nullable
as bool,hasBluetooth: null == hasBluetooth ? _self.hasBluetooth : hasBluetooth // ignore: cast_nullable_to_non_nullable
as bool,hasWirelessCharging: null == hasWirelessCharging ? _self.hasWirelessCharging : hasWirelessCharging // ignore: cast_nullable_to_non_nullable
as bool,hasPremiumAudio: null == hasPremiumAudio ? _self.hasPremiumAudio : hasPremiumAudio // ignore: cast_nullable_to_non_nullable
as bool,minSpeakerCount: freezed == minSpeakerCount ? _self.minSpeakerCount : minSpeakerCount // ignore: cast_nullable_to_non_nullable
as int?,hasHeadUpDisplay: null == hasHeadUpDisplay ? _self.hasHeadUpDisplay : hasHeadUpDisplay // ignore: cast_nullable_to_non_nullable
as bool,hasDigitalCluster: null == hasDigitalCluster ? _self.hasDigitalCluster : hasDigitalCluster // ignore: cast_nullable_to_non_nullable
as bool,hasWifiHotspot: null == hasWifiHotspot ? _self.hasWifiHotspot : hasWifiHotspot // ignore: cast_nullable_to_non_nullable
as bool,minUSBPorts: freezed == minUSBPorts ? _self.minUSBPorts : minUSBPorts // ignore: cast_nullable_to_non_nullable
as int?,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,province: freezed == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,distanceRadius: freezed == distanceRadius ? _self.distanceRadius : distanceRadius // ignore: cast_nullable_to_non_nullable
as int?,testDriveAvailable: null == testDriveAvailable ? _self.testDriveAvailable : testDriveAvailable // ignore: cast_nullable_to_non_nullable
as bool,deliveryAvailable: null == deliveryAvailable ? _self.deliveryAvailable : deliveryAvailable // ignore: cast_nullable_to_non_nullable
as bool,homeDelivery: null == homeDelivery ? _self.homeDelivery : homeDelivery // ignore: cast_nullable_to_non_nullable
as bool,dealershipPickup: null == dealershipPickup ? _self.dealershipPickup : dealershipPickup // ignore: cast_nullable_to_non_nullable
as bool,acceptsTrade: null == acceptsTrade ? _self.acceptsTrade : acceptsTrade // ignore: cast_nullable_to_non_nullable
as bool,financingAvailable: null == financingAvailable ? _self.financingAvailable : financingAvailable // ignore: cast_nullable_to_non_nullable
as bool,bankFinancing: null == bankFinancing ? _self.bankFinancing : bankFinancing // ignore: cast_nullable_to_non_nullable
as bool,inHouseFinancing: null == inHouseFinancing ? _self.inHouseFinancing : inHouseFinancing // ignore: cast_nullable_to_non_nullable
as bool,negotiable: null == negotiable ? _self.negotiable : negotiable // ignore: cast_nullable_to_non_nullable
as bool,cashOnly: null == cashOnly ? _self.cashOnly : cashOnly // ignore: cast_nullable_to_non_nullable
as bool,auctionsOnly: null == auctionsOnly ? _self.auctionsOnly : auctionsOnly // ignore: cast_nullable_to_non_nullable
as bool,directSaleOnly: null == directSaleOnly ? _self.directSaleOnly : directSaleOnly // ignore: cast_nullable_to_non_nullable
as bool,liveAuctionsOnly: null == liveAuctionsOnly ? _self.liveAuctionsOnly : liveAuctionsOnly // ignore: cast_nullable_to_non_nullable
as bool,upcomingAuctionsOnly: null == upcomingAuctionsOnly ? _self.upcomingAuctionsOnly : upcomingAuctionsOnly // ignore: cast_nullable_to_non_nullable
as bool,endingSoonOnly: null == endingSoonOnly ? _self.endingSoonOnly : endingSoonOnly // ignore: cast_nullable_to_non_nullable
as bool,hasBuyNowPrice: null == hasBuyNowPrice ? _self.hasBuyNowPrice : hasBuyNowPrice // ignore: cast_nullable_to_non_nullable
as bool,belowReservePrice: null == belowReservePrice ? _self.belowReservePrice : belowReservePrice // ignore: cast_nullable_to_non_nullable
as bool,noBidsYet: null == noBidsYet ? _self.noBidsYet : noBidsYet // ignore: cast_nullable_to_non_nullable
as bool,featuredOnly: null == featuredOnly ? _self.featuredOnly : featuredOnly // ignore: cast_nullable_to_non_nullable
as bool,verifiedSeller: null == verifiedSeller ? _self.verifiedSeller : verifiedSeller // ignore: cast_nullable_to_non_nullable
as bool,dealerOnly: null == dealerOnly ? _self.dealerOnly : dealerOnly // ignore: cast_nullable_to_non_nullable
as bool,privateSellerOnly: null == privateSellerOnly ? _self.privateSellerOnly : privateSellerOnly // ignore: cast_nullable_to_non_nullable
as bool,recentlyAddedDays: freezed == recentlyAddedDays ? _self.recentlyAddedDays : recentlyAddedDays // ignore: cast_nullable_to_non_nullable
as int?,recentlyUpdatedDays: freezed == recentlyUpdatedDays ? _self.recentlyUpdatedDays : recentlyUpdatedDays // ignore: cast_nullable_to_non_nullable
as int?,priceReduced: null == priceReduced ? _self.priceReduced : priceReduced // ignore: cast_nullable_to_non_nullable
as bool,newListing: null == newListing ? _self.newListing : newListing // ignore: cast_nullable_to_non_nullable
as bool,minViewCount: freezed == minViewCount ? _self.minViewCount : minViewCount // ignore: cast_nullable_to_non_nullable
as int?,minPhotoCount: freezed == minPhotoCount ? _self.minPhotoCount : minPhotoCount // ignore: cast_nullable_to_non_nullable
as int?,hasVideo: null == hasVideo ? _self.hasVideo : hasVideo // ignore: cast_nullable_to_non_nullable
as bool,has360View: null == has360View ? _self.has360View : has360View // ignore: cast_nullable_to_non_nullable
as bool,hasInteriorPhotos: null == hasInteriorPhotos ? _self.hasInteriorPhotos : hasInteriorPhotos // ignore: cast_nullable_to_non_nullable
as bool,hasEnginePhotos: null == hasEnginePhotos ? _self.hasEnginePhotos : hasEnginePhotos // ignore: cast_nullable_to_non_nullable
as bool,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as SortBy,
  ));
}


}

// dart format on
