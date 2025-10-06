import '../../models/car_model.dart';

class MockCarService {
  // In-memory storage
  final List<CarModel> _listings = [];

  Future<CarModel> createListing(CarModel carModel) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Auto-approve for demo (change status from draft to active after 2s)
    final listing = carModel.copyWith(
      status: ListingStatus.pendingReview,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _listings.add(listing);

    // Auto-approve after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      final index = _listings.indexWhere((l) => l.id == listing.id);
      if (index != -1) {
        _listings[index] = _listings[index].copyWith(
          status: ListingStatus.active,
          updatedAt: DateTime.now(),
        );
      }
    });

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

  Future<List<CarModel>> searchCars({
    String? brand,
    String? bodyType,
    int? minYear,
    int? maxYear,
    int? maxMileage,
    String? transmission,
    String? fuelType,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    var results = _listings.where((l) => l.status == ListingStatus.active).toList();

    if (brand != null && brand.isNotEmpty) {
      results = results.where((l) => l.brand.toLowerCase() == brand.toLowerCase()).toList();
    }

    if (bodyType != null && bodyType.isNotEmpty) {
      results = results.where((l) => l.bodyType.toString().contains(bodyType)).toList();
    }

    if (minYear != null) {
      results = results.where((l) => l.year >= minYear).toList();
    }

    if (maxYear != null) {
      results = results.where((l) => l.year <= maxYear).toList();
    }

    if (maxMileage != null) {
      results = results.where((l) => l.mileage <= maxMileage).toList();
    }

    return results;
  }

  Future<void> incrementViewCount(String carId) async {
    final index = _listings.indexWhere((l) => l.id == carId);
    if (index != -1) {
      _listings[index] = _listings[index].copyWith(
        viewCount: _listings[index].viewCount + 1,
      );
    }
  }

  // Helper method to add sample data for testing
  void addSampleListings() {
    final sampleListings = [
      CarModel(
        id: 'car-1',
        sellerId: 'mock-user-id',
        sellerName: 'John Doe',
        brand: 'Toyota',
        model: 'Vios',
        variant: '1.3 E',
        year: 2020,
        mileage: 35000,
        transmission: TransmissionType.automatic,
        fuelType: FuelType.gasoline,
        bodyType: BodyType.sedan,
        color: 'White',
        engineSize: '1.3L',
        seats: 5,
        doors: 4,
        plateNumber: 'ABC-1234',
        orcrNumber: 'OR12345678',
        location: const CarLocation(city: 'Quezon City', province: 'Metro Manila'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description:
            'Well-maintained Toyota Vios 1.3 E. First owner. All maintenance done at Casa. Complete service records. No accident history. Fresh in and out.',
        images: [
          'https://via.placeholder.com/400x300.png?text=Vios+Front',
          'https://via.placeholder.com/400x300.png?text=Vios+Rear',
          'https://via.placeholder.com/400x300.png?text=Vios+Side',
          'https://via.placeholder.com/400x300.png?text=Vios+Interior',
          'https://via.placeholder.com/400x300.png?text=Vios+Dashboard',
        ],
        features: [
          'Air Conditioning',
          'Power Steering',
          'ABS',
          'Airbags',
          'Power Windows',
        ],
        status: ListingStatus.active,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now().subtract(const Duration(days: 5)),
        viewCount: 45,
      ),
      CarModel(
        id: 'car-2',
        sellerId: 'mock-user-id',
        sellerName: 'John Doe',
        brand: 'Honda',
        model: 'City',
        variant: 'VX CVT',
        year: 2019,
        mileage: 48000,
        transmission: TransmissionType.cvt,
        fuelType: FuelType.gasoline,
        bodyType: BodyType.sedan,
        color: 'Silver',
        engineSize: '1.5L',
        seats: 5,
        doors: 4,
        plateNumber: 'XYZ-5678',
        orcrNumber: 'OR87654321',
        location: const CarLocation(city: 'Makati', province: 'Metro Manila'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description:
            'Honda City VX CVT 2019 model. Very good condition. Casa-maintained. All original parts. Perfect for daily commute.',
        images: [
          'https://via.placeholder.com/400x300.png?text=City+Front',
          'https://via.placeholder.com/400x300.png?text=City+Rear',
          'https://via.placeholder.com/400x300.png?text=City+Side',
          'https://via.placeholder.com/400x300.png?text=City+Interior',
          'https://via.placeholder.com/400x300.png?text=City+Engine',
        ],
        features: [
          'Air Conditioning',
          'Power Steering',
          'ABS',
          'Airbags',
          'Touchscreen Infotainment',
          'Reverse Camera',
        ],
        status: ListingStatus.active,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
        viewCount: 23,
      ),
    ];

    _listings.addAll(sampleListings);
  }
}
