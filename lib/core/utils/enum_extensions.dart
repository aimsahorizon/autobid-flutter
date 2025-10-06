import '../../data/models/car_model.dart';

extension TransmissionTypeExtension on TransmissionType {
  String get displayName {
    switch (this) {
      case TransmissionType.automatic:
        return 'Automatic';
      case TransmissionType.manual:
        return 'Manual';
      case TransmissionType.cvt:
        return 'CVT';
      case TransmissionType.dct:
        return 'DCT';
    }
  }
}

extension FuelTypeExtension on FuelType {
  String get displayName {
    switch (this) {
      case FuelType.gasoline:
        return 'Gasoline';
      case FuelType.diesel:
        return 'Diesel';
      case FuelType.electric:
        return 'Electric';
      case FuelType.hybrid:
        return 'Hybrid';
    }
  }
}

extension BodyTypeExtension on BodyType {
  String get displayName {
    switch (this) {
      case BodyType.sedan:
        return 'Sedan';
      case BodyType.suv:
        return 'SUV';
      case BodyType.hatchback:
        return 'Hatchback';
      case BodyType.pickup:
        return 'Pickup';
      case BodyType.van:
        return 'Van';
      case BodyType.coupe:
        return 'Coupe';
      case BodyType.mpv:
        return 'MPV';
    }
  }
}

extension CarConditionExtension on CarCondition {
  String get displayName {
    switch (this) {
      case CarCondition.brandNew:
        return 'Brand New';
      case CarCondition.almostNew:
        return 'Almost New';
      case CarCondition.used:
        return 'Used';
      case CarCondition.forParts:
        return 'For Parts';
    }
  }

  String get description {
    switch (this) {
      case CarCondition.brandNew:
        return 'Never been registered, comes with manufacturer warranty';
      case CarCondition.almostNew:
        return 'Less than 1 year old with minimal mileage';
      case CarCondition.used:
        return 'Previously owned vehicle in good condition';
      case CarCondition.forParts:
        return 'Not roadworthy, suitable for parts or restoration';
    }
  }
}

extension ListingStatusExtension on ListingStatus {
  String get displayName {
    switch (this) {
      case ListingStatus.draft:
        return 'Draft';
      case ListingStatus.pendingReview:
        return 'Pending Review';
      case ListingStatus.active:
        return 'Active';
      case ListingStatus.sold:
        return 'Sold';
      case ListingStatus.cancelled:
        return 'Cancelled';
    }
  }
}
