import '../../models/car_model.dart';
import '../../models/search_filters.dart';
import 'mock_car_listings.dart';

class MockCarService {
  // In-memory storage
  final List<CarModel> _listings = [];

  MockCarService() {
    // Auto-populate with sample data
    _initializeSampleData();
  }

  void _initializeSampleData() {
    _listings.addAll(MockCarListings.generateListings());
  }

  // ========== CRUD Operations ==========

  Future<CarModel> createListing(CarModel carModel) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    final listing = carModel.copyWith(
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _listings.add(listing);

    // Auto-approve after 2 seconds only if status is pendingReview
    if (listing.status == ListingStatus.pendingReview) {
      Future.delayed(const Duration(seconds: 2), () {
        final index = _listings.indexWhere((l) => l.id == listing.id);
        if (index != -1) {
          _listings[index] = _listings[index].copyWith(
            status: ListingStatus.active,
            updatedAt: DateTime.now(),
          );
        }
      });
    }

    return listing;
  }

  Future<CarModel> updateListing(String carId, CarModel carModel) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final index = _listings.indexWhere((l) => l.id == carId);
    if (index == -1) {
      throw Exception('Listing not found');
    }

    final updated = carModel.copyWith(updatedAt: DateTime.now());
    _listings[index] = updated;

    return updated;
  }

  Future<void> deleteListing(String carId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final index = _listings.indexWhere((l) => l.id == carId);
    if (index == -1) {
      throw Exception('Listing not found');
    }

    _listings.removeAt(index);
  }

  Future<List<CarModel>> getMyListings(String userId,
      {ListingStatus? status}) async {
    await Future.delayed(const Duration(milliseconds: 800));

    var filtered = _listings.where((l) => l.sellerId == userId).toList();

    if (status != null) {
      filtered = filtered.where((l) => l.status == status).toList();
    }

    // Sort by createdAt descending
    filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return filtered;
  }

  Future<CarModel?> getCarById(String carId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      return _listings.firstWhere((l) => l.id == carId);
    } catch (e) {
      return null;
    }
  }

  Future<List<CarModel>> getAllActiveCars() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return _listings
        .where((l) => l.status == ListingStatus.active)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  // ========== Search & Filter ==========

  Future<List<CarModel>> searchCars(SearchFilters filters) async {
    await Future.delayed(const Duration(milliseconds: 600));

    var results =
        _listings.where((l) => l.status == ListingStatus.active).toList();

    // === BASIC FILTERS ===
    if (filters.keyword != null && filters.keyword!.isNotEmpty) {
      final keyword = filters.keyword!.toLowerCase();
      results = results.where((car) {
        return car.brand.toLowerCase().contains(keyword) ||
            car.model.toLowerCase().contains(keyword) ||
            car.variant.toLowerCase().contains(keyword) ||
            car.description.toLowerCase().contains(keyword);
      }).toList();
    }

    if (filters.brands.isNotEmpty) {
      results = results.where((car) => filters.brands.contains(car.brand)).toList();
    }

    if (filters.yearMin != null) {
      results = results.where((car) => car.year >= filters.yearMin!).toList();
    }
    if (filters.yearMax != null) {
      results = results.where((car) => car.year <= filters.yearMax!).toList();
    }

    if (filters.priceMin != null || filters.priceMax != null) {
      // Note: Price would come from auction/listing data, placeholder for now
    }

    if (filters.bodyType.isNotEmpty) {
      results = results.where((car) => filters.bodyType.contains(car.bodyType)).toList();
    }

    // === MECHANICAL FILTERS ===
    if (filters.engineSizes.isNotEmpty) {
      results = results.where((car) => filters.engineSizes.contains(car.engineSize)).toList();
    }

    if (filters.engineTypes.isNotEmpty) {
      results = results.where((car) => filters.engineTypes.contains(car.engineType)).toList();
    }

    if (filters.cylinders.isNotEmpty) {
      results = results.where((car) => filters.cylinders.contains(car.cylinders)).toList();
    }

    if (filters.horsepowerMin != null) {
      results = results.where((car) => car.horsepower >= filters.horsepowerMin!).toList();
    }
    if (filters.horsepowerMax != null) {
      results = results.where((car) => car.horsepower <= filters.horsepowerMax!).toList();
    }

    if (filters.torqueMin != null) {
      results = results.where((car) => car.torque >= filters.torqueMin!).toList();
    }
    if (filters.torqueMax != null) {
      results = results.where((car) => car.torque <= filters.torqueMax!).toList();
    }

    if (filters.transmission.isNotEmpty) {
      results = results.where((car) => filters.transmission.contains(car.transmission)).toList();
    }

    if (filters.transmissionSpeeds.isNotEmpty) {
      results = results.where((car) => filters.transmissionSpeeds.contains(car.transmissionSpeeds)).toList();
    }

    if (filters.driveTypes.isNotEmpty) {
      results = results.where((car) => filters.driveTypes.contains(car.driveType)).toList();
    }

    if (filters.fuelType.isNotEmpty) {
      results = results.where((car) => filters.fuelType.contains(car.fuelType)).toList();
    }

    if (filters.fuelConsumptionMax != null) {
      results = results.where((car) => car.fuelConsumption <= filters.fuelConsumptionMax!).toList();
    }

    if (filters.electricRangeMin != null && filters.electricRangeMin! > 0) {
      results = results.where((car) => car.electricRange != null && car.electricRange! >= filters.electricRangeMin!).toList();
    }

    // === DIMENSIONS & CAPACITY FILTERS ===
    if (filters.seats.isNotEmpty) {
      results = results.where((car) => filters.seats.contains(car.seats)).toList();
    }

    if (filters.doors.isNotEmpty) {
      results = results.where((car) => filters.doors.contains(car.doors)).toList();
    }

    if (filters.curbWeightMin != null) {
      results = results.where((car) => car.curbWeight >= filters.curbWeightMin!).toList();
    }
    if (filters.curbWeightMax != null) {
      results = results.where((car) => car.curbWeight <= filters.curbWeightMax!).toList();
    }

    if (filters.grossWeightMin != null) {
      results = results.where((car) => car.grossWeight >= filters.grossWeightMin!).toList();
    }
    if (filters.grossWeightMax != null) {
      results = results.where((car) => car.grossWeight <= filters.grossWeightMax!).toList();
    }

    if (filters.cargoCapacityMin != null) {
      results = results.where((car) => car.cargoCapacity >= filters.cargoCapacityMin!).toList();
    }
    if (filters.cargoCapacityMax != null) {
      results = results.where((car) => car.cargoCapacity <= filters.cargoCapacityMax!).toList();
    }

    if (filters.groundClearanceMin != null) {
      results = results.where((car) => car.groundClearance! >= filters.groundClearanceMin!).toList();
    }
    if (filters.groundClearanceMax != null) {
      results = results.where((car) => car.groundClearance! <= filters.groundClearanceMax!).toList();
    }

    if (filters.lengthMin != null) {
      results = results.where((car) => car.length >= filters.lengthMin!).toList();
    }
    if (filters.lengthMax != null) {
      results = results.where((car) => car.length <= filters.lengthMax!).toList();
    }

    if (filters.widthMin != null) {
      results = results.where((car) => car.width >= filters.widthMin!).toList();
    }
    if (filters.widthMax != null) {
      results = results.where((car) => car.width <= filters.widthMax!).toList();
    }

    if (filters.heightMin != null) {
      results = results.where((car) => car.height >= filters.heightMin!).toList();
    }
    if (filters.heightMax != null) {
      results = results.where((car) => car.height <= filters.heightMax!).toList();
    }

    if (filters.wheelbaseMin != null) {
      results = results.where((car) => car.wheelbase >= filters.wheelbaseMin!).toList();
    }
    if (filters.wheelbaseMax != null) {
      results = results.where((car) => car.wheelbase <= filters.wheelbaseMax!).toList();
    }

    // === EXTERIOR FILTERS ===
    if (filters.colors.isNotEmpty) {
      results = results.where((car) => filters.colors.contains(car.color)).toList();
    }

    if (filters.paintTypes.isNotEmpty) {
      results = results.where((car) => filters.paintTypes.contains(car.paintType)).toList();
    }

    if (filters.rimSizes.isNotEmpty) {
      results = results.where((car) => filters.rimSizes.contains(car.rimSize)).toList();
    }

    if (filters.rimTypes.isNotEmpty) {
      results = results.where((car) => filters.rimTypes.contains(car.rimType)).toList();
    }

    if (filters.tireConditions.isNotEmpty) {
      results = results.where((car) => filters.tireConditions.contains(car.tireCondition)).toList();
    }

    // === CONDITION & HISTORY FILTERS ===
    if (filters.conditions.isNotEmpty) {
      results = results.where((car) => filters.conditions.contains(car.condition)).toList();
    }

    if (filters.mileageMin != null) {
      results = results.where((car) => car.mileage >= filters.mileageMin!).toList();
    }
    if (filters.mileageMax != null) {
      results = results.where((car) => car.mileage <= filters.mileageMax!).toList();
    }

    if (filters.numberOfOwnersMax != null) {
      results = results.where((car) => car.numberOfOwners <= filters.numberOfOwnersMax!).toList();
    }

    if (filters.hasAccidentHistory != null) {
      results = results.where((car) => car.hasAccidentHistory == filters.hasAccidentHistory).toList();
    }

    if (filters.floodDamage != null) {
      results = results.where((car) => car.floodDamage == filters.floodDamage).toList();
    }

    if (filters.serviceHistoryComplete != null) {
      results = results.where((car) => car.serviceHistoryComplete == filters.serviceHistoryComplete).toList();
    }

    // === DOCUMENTATION FILTERS ===
    if (filters.registrationStatuses.isNotEmpty) {
      results = results.where((car) => filters.registrationStatuses.contains(car.registrationStatus)).toList();
    }

    if (filters.emissionTestValid != null) {
      results = results.where((car) => car.emissionTestValid == filters.emissionTestValid).toList();
    }

    if (filters.comprehensiveInsurance != null) {
      results = results.where((car) => car.comprehensiveInsurance == filters.comprehensiveInsurance).toList();
    }

    // === LOCATION FILTERS ===
    if (filters.cities.isNotEmpty) {
      results = results.where((car) => filters.cities.contains(car.location.city)).toList();
    }

    if (filters.province!.isNotEmpty) {
      results = results.where((car) => filters.province!.contains(car.location.province)).toList();
    }

    // === FEATURES & OPTIONS FILTERS ===
    if (filters.availableForTestDrive != null) {
      results = results.where((car) => car.availableForTestDrive == filters.availableForTestDrive).toList();
    }

    if (filters.deliveryAvailable != null) {
      results = results.where((car) => car.deliveryAvailable == filters.deliveryAvailable).toList();
    }

    if (filters.acceptsTrade != null) {
      results = results.where((car) => car.acceptsTrade == filters.acceptsTrade).toList();
    }

    if (filters.financingAvailable != null) {
      results = results.where((car) => car.financingAvailable == filters.financingAvailable).toList();
    }

    if (filters.priceNegotiable != null) {
      results = results.where((car) => car.priceNegotiable == filters.priceNegotiable).toList();
    }

    // === LISTING FILTERS ===
    if (filters.statuses.isNotEmpty) {
      results = results.where((car) => filters.statuses.contains(car.status)).toList();
    }

    // Sort results
    if (filters.sortBy != null) {
      switch (filters.sortBy) {
        case 'newest':
          results.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          break;
        case 'oldest':
          results.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          break;
        case 'mileage_low':
          results.sort((a, b) => a.mileage.compareTo(b.mileage));
          break;
        case 'mileage_high':
          results.sort((a, b) => b.mileage.compareTo(a.mileage));
          break;
        case 'year_new':
          results.sort((a, b) => b.year.compareTo(a.year));
          break;
        case 'year_old':
          results.sort((a, b) => a.year.compareTo(b.year));
          break;
        default:
          results.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
    }

    return results;
  }

  // ========== Statistics ==========

  Future<Map<String, int>> getBrandCounts() async {
    await Future.delayed(const Duration(milliseconds: 300));

    final counts = <String, int>{};
    for (var car in _listings) {
      counts[car.brand] = (counts[car.brand] ?? 0) + 1;
    }
    return counts;
  }

  Future<void> incrementViewCount(String carId) async {
    final index = _listings.indexWhere((l) => l.id == carId);
    if (index != -1) {
      _listings[index] = _listings[index].copyWith(
        viewCount: _listings[index].viewCount + 1,
      );
    }
  }
}
