import 'package:freezed_annotation/freezed_annotation.dart';
import 'car_image_category.dart';

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
  @JsonValue('amt')
  amt,
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
  @JsonValue('plug_in_hybrid')
  plugInHybrid,
  @JsonValue('hydrogen')
  hydrogen,
  @JsonValue('cng')
  cng,
  @JsonValue('lpg')
  lpg,
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
  @JsonValue('convertible')
  convertible,
  @JsonValue('wagon')
  wagon,
  @JsonValue('truck')
  truck,
  @JsonValue('minivan')
  minivan,
  @JsonValue('crossover')
  crossover,
}

enum CarCondition {
  @JsonValue('brand_new')
  brandNew,
  @JsonValue('almost_new')
  almostNew,
  @JsonValue('used')
  used,
  @JsonValue('certified')
  certified,
  @JsonValue('for_parts')
  forParts,
}

enum EngineType {
  @JsonValue('inline')
  inline,
  @JsonValue('v_type')
  vType,
  @JsonValue('boxer')
  boxer,
  @JsonValue('rotary')
  rotary,
  @JsonValue('electric')
  electric,
}

enum DriveType {
  @JsonValue('fwd')
  fwd,
  @JsonValue('rwd')
  rwd,
  @JsonValue('awd')
  awd,
  @JsonValue('4wd')
  fourWd,
}

enum PaintType {
  @JsonValue('solid')
  solid,
  @JsonValue('metallic')
  metallic,
  @JsonValue('pearlescent')
  pearlescent,
  @JsonValue('matte')
  matte,
}

enum RimType {
  @JsonValue('steel')
  steel,
  @JsonValue('alloy')
  alloy,
  @JsonValue('forged')
  forged,
}

enum TireCondition {
  @JsonValue('new')
  newTires,
  @JsonValue('good')
  good,
  @JsonValue('fair')
  fair,
  @JsonValue('needs_replacement')
  needsReplacement,
}

enum RegistrationStatus {
  @JsonValue('current')
  current,
  @JsonValue('expiring_soon')
  expiringSoon,
  @JsonValue('expired')
  expired,
  @JsonValue('for_renewal')
  forRenewal,
  @JsonValue('pending_renewal')
  pendingRenewal,
  @JsonValue('delinquent')
  delinquent,
  @JsonValue('under_alarm')
  underAlarm,
  @JsonValue('carnapped')
  carnapped,
  @JsonValue('other')
  other,
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

    // BASIC INFO
    required String brand,
    required String model,
    required String variant,
    required int year,

    // MECHANICAL
    required String engineSize,
    required EngineType engineType,
    required int cylinders,
    required int horsepower,
    required int torque,
    required TransmissionType transmission,
    required int transmissionSpeeds,
    required DriveType driveType,
    required FuelType fuelType,
    required double fuelConsumption,
    int? electricRange,
    double? batteryCapacity,
    String? chargingTime,

    // DIMENSIONS & CAPACITY
    required BodyType bodyType,
    required int doors,
    required int seats,
    required int curbWeight,
    required int grossWeight,
    required int cargoCapacity,
    int? towingCapacity,
    int? groundClearance,
    required int length,
    required int width,
    required int height,
    required int wheelbase,

    // EXTERIOR
    required String color,
    required PaintType paintType,
    required int rimSize,
    required RimType rimType,
    required TireCondition tireCondition,

    // CONDITION & HISTORY
    required CarCondition condition,
    required int mileage,
    required int numberOfOwners,
    required bool hasAccidentHistory,
    required bool floodDamage,
    @Default(false) bool fireDamage,
    @Default(false) bool frameDamage,
    @Default(false) bool isRepainted,
    @Default(false) bool hasModifications,
    @Default(true) bool originalParts,
    @Default(false) bool commercialUse,
    @Default(false) bool smokerVehicle,
    required bool serviceHistoryComplete,
    DateTime? registrationExpiry,

    // FEATURES & TECHNOLOGY
    @Default([]) List<String> features,

    // LOCATION & AVAILABILITY
    required CarLocation location,
    @Default(false) bool availableForTestDrive,
    @Default(false) bool deliveryAvailable,

    // DOCUMENTATION
    required String plateNumber,
    required String orcrNumber,
    required RegistrationStatus registrationStatus,
    String? registrationStatusOther,
    required bool emissionTestValid,
    required bool comprehensiveInsurance,

    // SELLER PREFERENCES
    @Default(false) bool acceptsTrade,
    @Default(false) bool financingAvailable,
    @Default(false) bool priceNegotiable,

    // DESCRIPTION
    required String description,
    String? issues,

    // MEDIA & STATUS
    required List<String> images,
    required Map<String, List<String>> categorizedImages,
    required ListingStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int viewCount,
  }) = _CarModel;

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);
}

extension CarModelExtensions on CarModel {
  CategorizedCarImages getCategorizedImages() {
    final Map<CarImageCategory, List<String>> parsedImages = {};

    categorizedImages.forEach((key, value) {
      try {
        final category = CarImageCategory.values.firstWhere(
          (c) => c.name == key,
        );
        parsedImages[category] = value;
      } catch (e) {
        // Skip invalid categories
      }
    });

    return CategorizedCarImages(images: parsedImages);
  }

  bool hasAllRequiredImages() {
    final categorized = getCategorizedImages();

    // Check if all categories have required minimum images
    return categorized.hasImagesForCategory(CarImageCategory.exterior) &&
           categorized.getImagesForCategory(CarImageCategory.exterior).length >= 15 &&
           categorized.hasImagesForCategory(CarImageCategory.interior) &&
           categorized.getImagesForCategory(CarImageCategory.interior).length >= 12 &&
           categorized.hasImagesForCategory(CarImageCategory.engine) &&
           categorized.getImagesForCategory(CarImageCategory.engine).length >= 6 &&
           categorized.hasImagesForCategory(CarImageCategory.details) &&
           categorized.getImagesForCategory(CarImageCategory.details).length >= 13;
  }
}

