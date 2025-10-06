import 'package:freezed_annotation/freezed_annotation.dart';

part 'car_model.freezed.dart';
part 'car_model.g.dart';

enum TransmissionType {
  @JsonValue('automatic')
  automatic,
  @JsonValue('manual')
  manual,
  @JsonValue('cvt')
  cvt,
  @JsonValue('dct')
  dct,
}

enum FuelType {
  @JsonValue('gasoline')
  gasoline,
  @JsonValue('diesel')
  diesel,
  @JsonValue('electric')
  electric,
  @JsonValue('hybrid')
  hybrid,
}

enum BodyType {
  @JsonValue('sedan')
  sedan,
  @JsonValue('suv')
  suv,
  @JsonValue('hatchback')
  hatchback,
  @JsonValue('pickup')
  pickup,
  @JsonValue('van')
  van,
  @JsonValue('coupe')
  coupe,
  @JsonValue('mpv')
  mpv,
}

enum CarCondition {
  @JsonValue('brand_new')
  brandNew,
  @JsonValue('almost_new')
  almostNew,
  @JsonValue('used')
  used,
  @JsonValue('for_parts')
  forParts,
}

enum ListingStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('pending_review')
  pendingReview,
  @JsonValue('active')
  active,
  @JsonValue('sold')
  sold,
  @JsonValue('cancelled')
  cancelled,
}

@freezed
abstract class CarLocation with _$CarLocation {
  const factory CarLocation({
    required String city,
    required String province,
  }) = _CarLocation;

  factory CarLocation.fromJson(Map<String, dynamic> json) =>
      _$CarLocationFromJson(json);
}

@freezed
abstract class CarModel with _$CarModel {
  const factory CarModel({
    required String id,
    required String sellerId,
    required String sellerName,
    // Basic Info
    required String brand,
    required String model,
    required String variant,
    required int year,
    required int mileage,
    // Technical Details
    required TransmissionType transmission,
    required FuelType fuelType,
    required BodyType bodyType,
    required String color,
    required String engineSize,
    required int seats,
    required int doors,
    // Documents
    required String plateNumber,
    required String orcrNumber,
    required CarLocation location,
    required int numberOfOwners,
    required bool serviceHistoryComplete,
    required bool hasAccidentHistory,
    // Condition & Description
    required CarCondition condition,
    required String description,
    String? issues,
    required List<String> images,
    @Default([]) List<String> features,
    // Status
    required ListingStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int viewCount,
  }) = _CarModel;

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);
}

