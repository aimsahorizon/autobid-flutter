import 'package:freezed_annotation/freezed_annotation.dart';
import 'car_model.dart';

part 'search_filters.freezed.dart';
part 'search_filters.g.dart';

enum SortBy {
  @JsonValue('price_asc')
  priceAsc,
  @JsonValue('price_desc')
  priceDesc,
  @JsonValue('year_newest')
  yearNewest,
  @JsonValue('year_oldest')
  yearOldest,
  @JsonValue('mileage_lowest')
  mileageLowest,
  @JsonValue('mileage_highest')
  mileageHighest,
  @JsonValue('horsepower_highest')
  horsepowerHighest,
  @JsonValue('horsepower_lowest')
  horsepowerLowest,
  @JsonValue('fuel_economy_best')
  fuelEconomyBest,
  @JsonValue('fuel_economy_worst')
  fuelEconomyWorst,
  @JsonValue('newest')
  newest,
  @JsonValue('most_viewed')
  mostViewed,
  @JsonValue('ending_soon')
  endingSoon,
}

@freezed
abstract class SearchFilters with _$SearchFilters {
  const SearchFilters._();

  const factory SearchFilters({
    // Basic
    String? keyword,
    @Default([]) List<String> brands,
    int? yearMin,
    int? yearMax,
    double? priceMin,
    double? priceMax,
    @Default([]) List<BodyType> bodyType,

    // Mechanical
    @Default([]) List<String> engineSizes,
    @Default([]) List<EngineType> engineTypes,
    @Default([]) List<int> cylinders,
    int? horsepowerMin,
    int? horsepowerMax,
    int? torqueMin,
    int? torqueMax,
    @Default([]) List<TransmissionType> transmission,
    @Default([]) List<int> transmissionSpeeds,
    @Default([]) List<DriveType> driveTypes,
    @Default([]) List<FuelType> fuelType,
    double? fuelConsumptionMax,
    int? electricRangeMin,

    // Dimensions & Capacity
    @Default([]) List<int> seats,
    @Default([]) List<int> doors,
    int? curbWeightMin,
    int? curbWeightMax,
    int? grossWeightMin,
    int? grossWeightMax,
    int? cargoCapacityMin,
    int? towingCapacityMin,
    int? groundClearanceMin,
    int? lengthMin,
    int? lengthMax,
    int? widthMin,
    int? widthMax,
    int? heightMin,
    int? heightMax,
    int? wheelbaseMin,
    int? wheelbaseMax,

    // Exterior
    @Default([]) List<String> colors,
    @Default([]) List<int> rimSizes,
    @Default([]) List<PaintType> paintTypes,
    @Default([]) List<RimType> rimTypes,
    @Default([]) List<TireCondition> tireConditions,

    // Condition & History
    int? mileageMin,
    int? mileageMax,
    int? ownersMax,
    @Default(false) bool accidentFree,
    @Default(false) bool floodFree,
    @Default(false) bool withWarranty,
    @Default(false) bool completeServiceHistory,
    @Default([]) List<CarCondition> conditions,
    @Default([]) List<RegistrationStatus> registrationStatuses,
    @Default(false) bool emissionTestValid,
    @Default(false) bool comprehensiveInsurance,

    // Features (select any from comprehensive list)
    @Default([]) List<String> features,

    // Safety Features
    int? minAirbags,
    @Default(false) bool hasABS,
    @Default(false) bool hasTractionControl,
    @Default(false) bool hasStabilityControl,
    @Default(false) bool hasCameras,
    @Default(false) bool hasRearCamera,
    @Default(false) bool has360Camera,
    @Default(false) bool hasBlindSpot,
    @Default(false) bool hasLaneDepartureWarning,
    @Default(false) bool hasLaneAssist,
    @Default(false) bool hasAdaptiveCruise,
    @Default(false) bool hasForwardCollisionWarning,
    @Default(false) bool hasAutomaticEmergencyBraking,
    @Default(false) bool hasHillStartAssist,
    @Default(false) bool hasHillDescentControl,
    @Default(false) bool hasParkingSensors,
    @Default(false) bool hasFrontParkingSensors,
    @Default(false) bool hasRearParkingSensors,

    // Comfort & Convenience
    @Default(false) bool hasClimateControl,
    @Default(false) bool hasDualClimateControl,
    @Default(false) bool hasSunroof,
    @Default(false) bool hasPanoramicSunroof,
    @Default(false) bool hasLeatherSeats,
    @Default(false) bool hasPowerSeats,
    @Default(false) bool hasHeatedSeats,
    @Default(false) bool hasVentilatedSeats,
    @Default(false) bool hasMemorySeats,
    @Default(false) bool hasKeylessEntry,
    @Default(false) bool hasPushStart,
    @Default(false) bool hasPowerWindows,
    @Default(false) bool hasPowerMirrors,
    @Default(false) bool hasAutoFoldingMirrors,
    @Default(false) bool hasPowerTailgate,
    @Default(false) bool hasCruiseControl,

    // Technology & Infotainment
    int? minInfotainmentSize,
    @Default(false) bool hasTouchscreen,
    @Default(false) bool hasCarPlay,
    @Default(false) bool hasAndroidAuto,
    @Default(false) bool hasNavigation,
    @Default(false) bool hasBluetooth,
    @Default(false) bool hasWirelessCharging,
    @Default(false) bool hasPremiumAudio,
    int? minSpeakerCount,
    @Default(false) bool hasHeadUpDisplay,
    @Default(false) bool hasDigitalCluster,
    @Default(false) bool hasWifiHotspot,
    int? minUSBPorts,

    // Location & Availability
    String? region,
    String? province,
    String? city,
    int? distanceRadius,
    @Default(false) bool testDriveAvailable,
    @Default(false) bool deliveryAvailable,
    @Default(false) bool homeDelivery,
    @Default(false) bool dealershipPickup,

    // Seller Preferences
    @Default(false) bool acceptsTrade,
    @Default(false) bool financingAvailable,
    @Default(false) bool bankFinancing,
    @Default(false) bool inHouseFinancing,
    @Default(false) bool negotiable,
    @Default(false) bool cashOnly,

    // Listing Type & Status
    @Default(false) bool auctionsOnly,
    @Default(false) bool directSaleOnly,
    @Default(false) bool liveAuctionsOnly,
    @Default(false) bool upcomingAuctionsOnly,
    @Default(false) bool endingSoonOnly,
    @Default(false) bool hasBuyNowPrice,
    @Default(false) bool belowReservePrice,
    @Default(false) bool noBidsYet,

    // Special Filters
    @Default(false) bool featuredOnly,
    @Default(false) bool verifiedSeller,
    @Default(false) bool dealerOnly,
    @Default(false) bool privateSellerOnly,
    int? recentlyAddedDays,
    int? recentlyUpdatedDays,
    @Default(false) bool priceReduced,
    @Default(false) bool newListing,
    int? minViewCount,

    // Media Filters
    int? minPhotoCount,
    @Default(false) bool hasVideo,
    @Default(false) bool has360View,
    @Default(false) bool hasInteriorPhotos,
    @Default(false) bool hasEnginePhotos,

    // Sort
    @Default(SortBy.newest) SortBy sortBy,
  }) = _SearchFilters;

  factory SearchFilters.fromJson(Map<String, dynamic> json) =>
      _$SearchFiltersFromJson(json);

  // Helper to check if filters are empty
  bool get isEmpty {
    return activeFilterCount == 0;
  }

  // Count active filters
  int get activeFilterCount {
    int count = 0;
    // Basic
    if (keyword != null && keyword!.isNotEmpty) count++;
    if (brands.isNotEmpty) count++;
    if (yearMin != null || yearMax != null) count++;
    if (priceMin != null || priceMax != null) count++;
    if (bodyType.isNotEmpty) count++;
    // Mechanical
    if (engineSizes.isNotEmpty) count++;
    if (engineTypes.isNotEmpty) count++;
    if (cylinders.isNotEmpty) count++;
    if (horsepowerMin != null || horsepowerMax != null) count++;
    if (torqueMin != null || torqueMax != null) count++;
    if (transmission.isNotEmpty) count++;
    if (transmissionSpeeds.isNotEmpty) count++;
    if (driveTypes.isNotEmpty) count++;
    if (fuelType.isNotEmpty) count++;
    if (fuelConsumptionMax != null) count++;
    if (electricRangeMin != null) count++;
    // Dimensions
    if (seats.isNotEmpty) count++;
    if (doors.isNotEmpty) count++;
    if (curbWeightMin != null || curbWeightMax != null) count++;
    if (grossWeightMin != null || grossWeightMax != null) count++;
    if (cargoCapacityMin != null) count++;
    if (towingCapacityMin != null) count++;
    if (groundClearanceMin != null) count++;
    if (lengthMin != null || lengthMax != null) count++;
    if (widthMin != null || widthMax != null) count++;
    if (heightMin != null || heightMax != null) count++;
    if (wheelbaseMin != null || wheelbaseMax != null) count++;
    // Exterior
    if (colors.isNotEmpty) count++;
    if (rimSizes.isNotEmpty) count++;
    if (paintTypes.isNotEmpty) count++;
    if (rimTypes.isNotEmpty) count++;
    if (tireConditions.isNotEmpty) count++;
    // Condition
    if (mileageMin != null || mileageMax != null) count++;
    if (ownersMax != null) count++;
    if (accidentFree) count++;
    if (floodFree) count++;
    if (withWarranty) count++;
    if (completeServiceHistory) count++;
    if (conditions.isNotEmpty) count++;
    if (registrationStatuses.isNotEmpty) count++;
    if (emissionTestValid) count++;
    if (comprehensiveInsurance) count++;
    // Features
    if (features.isNotEmpty) count++;
    // Safety
    if (minAirbags != null) count++;
    if (hasABS) count++;
    if (hasTractionControl) count++;
    if (hasStabilityControl) count++;
    if (hasCameras) count++;
    if (hasRearCamera) count++;
    if (has360Camera) count++;
    if (hasBlindSpot) count++;
    if (hasLaneDepartureWarning) count++;
    if (hasLaneAssist) count++;
    if (hasAdaptiveCruise) count++;
    if (hasForwardCollisionWarning) count++;
    if (hasAutomaticEmergencyBraking) count++;
    if (hasHillStartAssist) count++;
    if (hasHillDescentControl) count++;
    if (hasParkingSensors) count++;
    if (hasFrontParkingSensors) count++;
    if (hasRearParkingSensors) count++;
    // Comfort
    if (hasClimateControl) count++;
    if (hasDualClimateControl) count++;
    if (hasSunroof) count++;
    if (hasPanoramicSunroof) count++;
    if (hasLeatherSeats) count++;
    if (hasPowerSeats) count++;
    if (hasHeatedSeats) count++;
    if (hasVentilatedSeats) count++;
    if (hasMemorySeats) count++;
    if (hasKeylessEntry) count++;
    if (hasPushStart) count++;
    if (hasPowerWindows) count++;
    if (hasPowerMirrors) count++;
    if (hasAutoFoldingMirrors) count++;
    if (hasPowerTailgate) count++;
    if (hasCruiseControl) count++;
    // Technology
    if (minInfotainmentSize != null) count++;
    if (hasTouchscreen) count++;
    if (hasCarPlay) count++;
    if (hasAndroidAuto) count++;
    if (hasNavigation) count++;
    if (hasBluetooth) count++;
    if (hasWirelessCharging) count++;
    if (hasPremiumAudio) count++;
    if (minSpeakerCount != null) count++;
    if (hasHeadUpDisplay) count++;
    if (hasDigitalCluster) count++;
    if (hasWifiHotspot) count++;
    if (minUSBPorts != null) count++;
    // Location
    if (region != null) count++;
    if (province != null) count++;
    if (city != null) count++;
    if (distanceRadius != null) count++;
    if (testDriveAvailable) count++;
    if (deliveryAvailable) count++;
    if (homeDelivery) count++;
    if (dealershipPickup) count++;
    // Seller
    if (acceptsTrade) count++;
    if (financingAvailable) count++;
    if (bankFinancing) count++;
    if (inHouseFinancing) count++;
    if (negotiable) count++;
    if (cashOnly) count++;
    // Listing Type
    if (auctionsOnly) count++;
    if (directSaleOnly) count++;
    if (liveAuctionsOnly) count++;
    if (upcomingAuctionsOnly) count++;
    if (endingSoonOnly) count++;
    if (hasBuyNowPrice) count++;
    if (belowReservePrice) count++;
    if (noBidsYet) count++;
    // Special
    if (featuredOnly) count++;
    if (verifiedSeller) count++;
    if (dealerOnly) count++;
    if (privateSellerOnly) count++;
    if (recentlyAddedDays != null) count++;
    if (recentlyUpdatedDays != null) count++;
    if (priceReduced) count++;
    if (newListing) count++;
    if (minViewCount != null) count++;
    // Media
    if (minPhotoCount != null) count++;
    if (hasVideo) count++;
    if (has360View) count++;
    if (hasInteriorPhotos) count++;
    if (hasEnginePhotos) count++;
    return count;
  }

  get groundClearanceMax => null;

  get cargoCapacityMax => null;

  get numberOfOwnersMax => null;

  get hasAccidentHistory => null;

  get floodDamage => null;

  get serviceHistoryComplete => null;

  get warrantyRemaining => null;

  get cities => null;

  get availableForTestDrive => null;

  get priceNegotiable => null;

  get statuses => null;
}
