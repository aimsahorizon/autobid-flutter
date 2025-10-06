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
    int? cargoCapacityMin,
    int? groundClearanceMin,

    // Exterior
    @Default([]) List<String> colors,
    @Default([]) List<int> rimSizes,
    @Default([]) List<PaintType> paintTypes,

    // Condition
    int? mileageMax,
    int? ownersMax,
    @Default(false) bool accidentFree,
    @Default(false) bool floodFree,
    @Default(false) bool withWarranty,
    @Default(false) bool completeServiceHistory,

    // Features (select any from comprehensive list)
    @Default([]) List<String> features,

    // Safety
    int? minAirbags,
    @Default(false) bool hasABS,
    @Default(false) bool hasCameras,
    @Default(false) bool hasBlindSpot,
    @Default(false) bool hasLaneAssist,
    @Default(false) bool hasAdaptiveCruise,

    // Comfort & Technology
    @Default(false) bool hasClimateControl,
    @Default(false) bool hasSunroof,
    @Default(false) bool hasLeatherSeats,
    @Default(false) bool hasPowerSeats,
    int? minInfotainmentSize,
    @Default(false) bool hasCarPlay,
    @Default(false) bool hasAndroidAuto,
    @Default(false) bool hasNavigation,
    @Default(false) bool hasWirelessCharging,
    @Default(false) bool hasPremiumAudio,

    // Location & Availability
    String? city,
    String? province,
    @Default(false) bool testDriveAvailable,
    @Default(false) bool deliveryAvailable,

    // Other
    @Default(false) bool acceptsTrade,
    @Default(false) bool financingAvailable,
    @Default(false) bool negotiable,
    @Default(false) bool auctionsOnly,

    // Sort
    @Default(SortBy.newest) SortBy sortBy,
  }) = _SearchFilters;

  factory SearchFilters.fromJson(Map<String, dynamic> json) =>
      _$SearchFiltersFromJson(json);

  // Helper to check if filters are empty
  bool get isEmpty {
    return keyword == null &&
        brands.isEmpty &&
        yearMin == null &&
        yearMax == null &&
        priceMin == null &&
        priceMax == null &&
        bodyType.isEmpty &&
        engineSizes.isEmpty &&
        engineTypes.isEmpty &&
        cylinders.isEmpty &&
        horsepowerMin == null &&
        horsepowerMax == null &&
        torqueMin == null &&
        torqueMax == null &&
        transmission.isEmpty &&
        transmissionSpeeds.isEmpty &&
        driveTypes.isEmpty &&
        fuelType.isEmpty &&
        fuelConsumptionMax == null &&
        electricRangeMin == null &&
        seats.isEmpty &&
        doors.isEmpty &&
        curbWeightMin == null &&
        curbWeightMax == null &&
        cargoCapacityMin == null &&
        groundClearanceMin == null &&
        colors.isEmpty &&
        rimSizes.isEmpty &&
        paintTypes.isEmpty &&
        mileageMax == null &&
        ownersMax == null &&
        !accidentFree &&
        !floodFree &&
        !withWarranty &&
        !completeServiceHistory &&
        features.isEmpty &&
        minAirbags == null &&
        !hasABS &&
        !hasCameras &&
        !hasBlindSpot &&
        !hasLaneAssist &&
        !hasAdaptiveCruise &&
        !hasClimateControl &&
        !hasSunroof &&
        !hasLeatherSeats &&
        !hasPowerSeats &&
        minInfotainmentSize == null &&
        !hasCarPlay &&
        !hasAndroidAuto &&
        !hasNavigation &&
        !hasWirelessCharging &&
        !hasPremiumAudio &&
        city == null &&
        province == null &&
        !testDriveAvailable &&
        !deliveryAvailable &&
        !acceptsTrade &&
        !financingAvailable &&
        !negotiable &&
        !auctionsOnly;
  }

  // Count active filters
  int get activeFilterCount {
    int count = 0;
    if (keyword != null && keyword!.isNotEmpty) count++;
    if (brands.isNotEmpty) count++;
    if (yearMin != null || yearMax != null) count++;
    if (priceMin != null || priceMax != null) count++;
    if (bodyType.isNotEmpty) count++;
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
    if (seats.isNotEmpty) count++;
    if (doors.isNotEmpty) count++;
    if (curbWeightMin != null || curbWeightMax != null) count++;
    if (cargoCapacityMin != null) count++;
    if (groundClearanceMin != null) count++;
    if (colors.isNotEmpty) count++;
    if (rimSizes.isNotEmpty) count++;
    if (paintTypes.isNotEmpty) count++;
    if (mileageMax != null) count++;
    if (ownersMax != null) count++;
    if (accidentFree) count++;
    if (floodFree) count++;
    if (withWarranty) count++;
    if (completeServiceHistory) count++;
    if (features.isNotEmpty) count++;
    if (minAirbags != null) count++;
    if (hasABS) count++;
    if (hasCameras) count++;
    if (hasBlindSpot) count++;
    if (hasLaneAssist) count++;
    if (hasAdaptiveCruise) count++;
    if (hasClimateControl) count++;
    if (hasSunroof) count++;
    if (hasLeatherSeats) count++;
    if (hasPowerSeats) count++;
    if (minInfotainmentSize != null) count++;
    if (hasCarPlay) count++;
    if (hasAndroidAuto) count++;
    if (hasNavigation) count++;
    if (hasWirelessCharging) count++;
    if (hasPremiumAudio) count++;
    if (city != null || province != null) count++;
    if (testDriveAvailable) count++;
    if (deliveryAvailable) count++;
    if (acceptsTrade) count++;
    if (financingAvailable) count++;
    if (negotiable) count++;
    if (auctionsOnly) count++;
    return count;
  }
}
