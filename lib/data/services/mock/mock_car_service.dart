import '../../models/car_model.dart';
import '../../models/search_filters.dart';

class MockCarService {
  // In-memory storage
  final List<CarModel> _listings = [];

  MockCarService() {
    // Auto-populate with sample data
    _initializeSampleData();
  }

  void _initializeSampleData() {
    _listings.addAll(_generateSampleListings());
  }

  // Map brand names to actual car images in assets/images
  String _getBrandImage(String brand) {
    final brandImageMap = {
      'Toyota': 'assets/images/toyota.jpg',
      'Honda': 'assets/images/honda.jpg',
      'Ford': 'assets/images/ford-mustang.jpg',
      'Mazda': 'assets/images/bmw.jpg',
      'Mitsubishi': 'assets/images/chevrolet.jpg',
      'Suzuki': 'assets/images/honda.jpg',
      'Nissan': 'assets/images/toyota.jpg',
      'MG': 'assets/images/mercedez.jpg',
      'Geely': 'assets/images/chevrolet.jpg',
      'Isuzu': 'assets/images/ford-mustang.jpg',
      'Hyundai': 'assets/images/toyota.jpg',
      'Kia': 'assets/images/chevrolet.jpg',
      'Chevrolet': 'assets/images/chevrolet.jpg',
      'Subaru': 'assets/images/toyota.jpg',
    };

    return brandImageMap[brand] ?? 'assets/images/toyota.jpg';
  }

  List<CarModel> _generateSampleListings() {
    final now = DateTime.now();

    return [
      // 1. ACTIVE listing - Toyota Vios
      CarModel(
        id: 'car-active-1',
        sellerId: 'mock-user-id',
        sellerName: 'John Doe',
        brand: 'Toyota',
        model: 'Vios',
        variant: 'E 1.3 MT',
        year: 2022,
        engineSize: '1.3L',
        engineType: EngineType.inline,
        cylinders: 4,
        horsepower: 98,
        torque: 123,
        transmission: TransmissionType.manual,
        transmissionSpeeds: 5,
        driveType: DriveType.fwd,
        fuelType: FuelType.gasoline,
        fuelConsumption: 18.5,
        bodyType: BodyType.sedan,
        doors: 4,
        seats: 5,
        curbWeight: 1090,
        grossWeight: 1495,
        cargoCapacity: 506,
        groundClearance: 133,
        length: 4425,
        width: 1730,
        height: 1475,
        wheelbase: 2550,
        color: 'White',
        paintType: PaintType.solid,
        rimSize: 15,
        rimType: RimType.alloy,
        tireCondition: TireCondition.good,
        condition: CarCondition.used,
        mileage: 35000,
        numberOfOwners: 1,
        hasAccidentHistory: false,
        floodDamage: false,
        serviceHistoryComplete: true,
        warrantyRemaining: false,
        plateNumber: 'ABC1234',
        orcrNumber: 'ORCR1001',
        registrationStatus: RegistrationStatus.current,
        emissionTestValid: true,
        comprehensiveInsurance: true,
        location: const CarLocation(city: 'Manila', province: 'Metro Manila'),
        availableForTestDrive: true,
        deliveryAvailable: true,
        acceptsTrade: false,
        financingAvailable: true,
        priceNegotiable: true,
        description: 'Well-maintained Toyota Vios 2022. First owner, casa-maintained.',
        images: [_getBrandImage('Toyota')],
        categorizedImages: {
          'exterior': List.generate(15, (_) => _getBrandImage('Toyota')),
          'interior': List.generate(12, (_) => _getBrandImage('Toyota')),
          'engine': List.generate(6, (_) => _getBrandImage('Toyota')),
          'details': List.generate(13, (_) => _getBrandImage('Toyota')),
        },
        features: ['ABS', 'Dual Airbags', 'Power Windows', 'Bluetooth'],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 5)),
        updatedAt: now.subtract(const Duration(days: 5)),
      ),

      // 2. ACTIVE listing - Honda CR-V
      CarModel(
        id: 'car-active-2',
        sellerId: 'mock-user-id',
        sellerName: 'John Doe',
        brand: 'Honda',
        model: 'CR-V',
        variant: 'S CVT',
        year: 2021,
        engineSize: '2.0L',
        engineType: EngineType.inline,
        cylinders: 4,
        horsepower: 154,
        torque: 189,
        transmission: TransmissionType.cvt,
        transmissionSpeeds: 0,
        driveType: DriveType.fwd,
        fuelType: FuelType.gasoline,
        fuelConsumption: 13.2,
        bodyType: BodyType.suv,
        doors: 5,
        seats: 7,
        curbWeight: 1665,
        grossWeight: 2135,
        cargoCapacity: 522,
        groundClearance: 198,
        length: 4600,
        width: 1855,
        height: 1679,
        wheelbase: 2660,
        color: 'Silver',
        paintType: PaintType.metallic,
        rimSize: 18,
        rimType: RimType.alloy,
        tireCondition: TireCondition.good,
        condition: CarCondition.almostNew,
        mileage: 18000,
        numberOfOwners: 1,
        hasAccidentHistory: false,
        floodDamage: false,
        serviceHistoryComplete: true,
        warrantyRemaining: true,
        plateNumber: 'XYZ5678',
        orcrNumber: 'ORCR1002',
        registrationStatus: RegistrationStatus.current,
        emissionTestValid: true,
        comprehensiveInsurance: true,
        location: const CarLocation(city: 'Quezon City', province: 'Metro Manila'),
        availableForTestDrive: true,
        deliveryAvailable: false,
        acceptsTrade: true,
        financingAvailable: false,
        priceNegotiable: true,
        description: 'Almost new Honda CR-V with excellent features.',
        images: [_getBrandImage('Honda')],
        categorizedImages: {
          'exterior': List.generate(15, (_) => _getBrandImage('Honda')),
          'interior': List.generate(12, (_) => _getBrandImage('Honda')),
          'engine': List.generate(6, (_) => _getBrandImage('Honda')),
          'details': List.generate(13, (_) => _getBrandImage('Honda')),
        },
        features: ['6 Airbags', 'Lane Watch', 'Cruise Control', 'Apple CarPlay'],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 3)),
        updatedAt: now.subtract(const Duration(days: 3)),
      ),

      // 3. PENDING listing - Ford Ranger
      CarModel(
        id: 'car-pending-1',
        sellerId: 'mock-user-id',
        sellerName: 'John Doe',
        brand: 'Ford',
        model: 'Ranger',
        variant: 'Raptor 2.0L Bi-Turbo',
        year: 2023,
        engineSize: '2.0L',
        engineType: EngineType.inline,
        cylinders: 4,
        horsepower: 213,
        torque: 500,
        transmission: TransmissionType.automatic,
        transmissionSpeeds: 10,
        driveType: DriveType.fourWd,
        fuelType: FuelType.diesel,
        fuelConsumption: 9.8,
        bodyType: BodyType.pickup,
        doors: 4,
        seats: 5,
        curbWeight: 2220,
        grossWeight: 3180,
        cargoCapacity: 1200,
        groundClearance: 283,
        length: 5362,
        width: 2180,
        height: 1884,
        wheelbase: 3220,
        color: 'Blue',
        paintType: PaintType.metallic,
        rimSize: 17,
        rimType: RimType.alloy,
        tireCondition: TireCondition.newTires,
        condition: CarCondition.almostNew,
        mileage: 8500,
        numberOfOwners: 1,
        hasAccidentHistory: false,
        floodDamage: false,
        serviceHistoryComplete: true,
        warrantyRemaining: true,
        plateNumber: 'DEF9012',
        orcrNumber: 'ORCR1003',
        registrationStatus: RegistrationStatus.current,
        emissionTestValid: true,
        comprehensiveInsurance: true,
        location: const CarLocation(city: 'Makati', province: 'Metro Manila'),
        availableForTestDrive: false,
        deliveryAvailable: true,
        acceptsTrade: false,
        financingAvailable: true,
        priceNegotiable: false,
        description: 'Almost brand new Ford Ranger Raptor. Top of the line.',
        images: [_getBrandImage('Ford')],
        categorizedImages: {
          'exterior': List.generate(15, (_) => _getBrandImage('Ford')),
          'interior': List.generate(12, (_) => _getBrandImage('Ford')),
          'engine': List.generate(6, (_) => _getBrandImage('Ford')),
          'details': List.generate(13, (_) => _getBrandImage('Ford')),
        },
        features: ['Terrain Management', 'B&O Sound', 'Apple CarPlay'],
        status: ListingStatus.pendingReview,
        createdAt: now.subtract(const Duration(hours: 6)),
        updatedAt: now.subtract(const Duration(hours: 6)),
      ),

      // 4. DRAFT listing - Mazda CX-5
      CarModel(
        id: 'car-draft-1',
        sellerId: 'mock-user-id',
        sellerName: 'John Doe',
        brand: 'Mazda',
        model: 'CX-5',
        variant: 'AWD Sport',
        year: 2022,
        engineSize: '2.5L',
        engineType: EngineType.inline,
        cylinders: 4,
        horsepower: 190,
        torque: 252,
        transmission: TransmissionType.automatic,
        transmissionSpeeds: 6,
        driveType: DriveType.awd,
        fuelType: FuelType.gasoline,
        fuelConsumption: 13.0,
        bodyType: BodyType.crossover,
        doors: 5,
        seats: 5,
        curbWeight: 1620,
        grossWeight: 2070,
        cargoCapacity: 442,
        groundClearance: 210,
        length: 4575,
        width: 1842,
        height: 1685,
        wheelbase: 2700,
        color: 'Red',
        paintType: PaintType.metallic,
        rimSize: 19,
        rimType: RimType.alloy,
        tireCondition: TireCondition.good,
        condition: CarCondition.almostNew,
        mileage: 12000,
        numberOfOwners: 1,
        hasAccidentHistory: false,
        floodDamage: false,
        serviceHistoryComplete: true,
        warrantyRemaining: true,
        plateNumber: 'GHI3456',
        orcrNumber: 'ORCR1004',
        registrationStatus: RegistrationStatus.current,
        emissionTestValid: true,
        comprehensiveInsurance: true,
        location: const CarLocation(city: 'Pasig', province: 'Metro Manila'),
        availableForTestDrive: true,
        deliveryAvailable: true,
        acceptsTrade: true,
        financingAvailable: true,
        priceNegotiable: true,
        description: 'Premium Mazda CX-5 AWD. Excellent condition.',
        images: [_getBrandImage('Mazda')],
        categorizedImages: {
          'exterior': List.generate(15, (_) => _getBrandImage('Mazda')),
          'interior': List.generate(12, (_) => _getBrandImage('Mazda')),
          'engine': List.generate(6, (_) => _getBrandImage('Mazda')),
          'details': List.generate(13, (_) => _getBrandImage('Mazda')),
        },
        features: ['Blind Spot Monitor', 'Adaptive Cruise Control', 'Bose Sound'],
        status: ListingStatus.draft,
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now.subtract(const Duration(days: 1)),
      ),

      // 5. SOLD listing - Mitsubishi Montero
      CarModel(
        id: 'car-sold-1',
        sellerId: 'mock-user-id',
        sellerName: 'John Doe',
        brand: 'Mitsubishi',
        model: 'Montero Sport',
        variant: 'GLS 4x2 AT',
        year: 2020,
        engineSize: '2.4L',
        engineType: EngineType.inline,
        cylinders: 4,
        horsepower: 181,
        torque: 430,
        transmission: TransmissionType.automatic,
        transmissionSpeeds: 8,
        driveType: DriveType.rwd,
        fuelType: FuelType.diesel,
        fuelConsumption: 12.8,
        bodyType: BodyType.suv,
        doors: 5,
        seats: 7,
        curbWeight: 2150,
        grossWeight: 2850,
        cargoCapacity: 1580,
        groundClearance: 218,
        length: 4785,
        width: 1815,
        height: 1835,
        wheelbase: 2800,
        color: 'Black',
        paintType: PaintType.solid,
        rimSize: 18,
        rimType: RimType.alloy,
        tireCondition: TireCondition.fair,
        condition: CarCondition.used,
        mileage: 62000,
        numberOfOwners: 2,
        hasAccidentHistory: false,
        floodDamage: false,
        serviceHistoryComplete: true,
        warrantyRemaining: false,
        plateNumber: 'JKL7890',
        orcrNumber: 'ORCR1005',
        registrationStatus: RegistrationStatus.current,
        emissionTestValid: true,
        comprehensiveInsurance: false,
        location: const CarLocation(city: 'Caloocan', province: 'Metro Manila'),
        availableForTestDrive: false,
        deliveryAvailable: false,
        acceptsTrade: false,
        financingAvailable: false,
        priceNegotiable: false,
        description: 'Reliable Mitsubishi Montero Sport for families.',
        images: [_getBrandImage('Mitsubishi')],
        categorizedImages: {
          'exterior': List.generate(15, (_) => _getBrandImage('Mitsubishi')),
          'interior': List.generate(12, (_) => _getBrandImage('Mitsubishi')),
          'engine': List.generate(6, (_) => _getBrandImage('Mitsubishi')),
          'details': List.generate(13, (_) => _getBrandImage('Mitsubishi')),
        },
        features: ['7 Airbags', 'Hill Start Assist', 'Leather Seats'],
        status: ListingStatus.sold,
        createdAt: now.subtract(const Duration(days: 30)),
        updatedAt: now.subtract(const Duration(days: 15)),
      ),

      // 6. CANCELLED listing - Suzuki Swift
      CarModel(
        id: 'car-cancelled-1',
        sellerId: 'mock-user-id',
        sellerName: 'John Doe',
        brand: 'Suzuki',
        model: 'Swift',
        variant: 'GLX CVT',
        year: 2022,
        engineSize: '1.2L',
        engineType: EngineType.inline,
        cylinders: 4,
        horsepower: 82,
        torque: 113,
        transmission: TransmissionType.cvt,
        transmissionSpeeds: 0,
        driveType: DriveType.fwd,
        fuelType: FuelType.gasoline,
        fuelConsumption: 19.2,
        bodyType: BodyType.hatchback,
        doors: 5,
        seats: 5,
        curbWeight: 875,
        grossWeight: 1300,
        cargoCapacity: 265,
        groundClearance: 145,
        length: 3840,
        width: 1735,
        height: 1495,
        wheelbase: 2450,
        color: 'Red',
        paintType: PaintType.metallic,
        rimSize: 16,
        rimType: RimType.alloy,
        tireCondition: TireCondition.good,
        condition: CarCondition.almostNew,
        mileage: 12000,
        numberOfOwners: 1,
        hasAccidentHistory: false,
        floodDamage: false,
        serviceHistoryComplete: true,
        warrantyRemaining: true,
        plateNumber: 'MNO2345',
        orcrNumber: 'ORCR1006',
        registrationStatus: RegistrationStatus.current,
        emissionTestValid: true,
        comprehensiveInsurance: true,
        location: const CarLocation(city: 'Mandaluyong', province: 'Metro Manila'),
        availableForTestDrive: false,
        deliveryAvailable: false,
        acceptsTrade: false,
        financingAvailable: false,
        priceNegotiable: false,
        description: 'Compact and fuel-efficient Suzuki Swift.',
        images: [_getBrandImage('Suzuki')],
        categorizedImages: {
          'exterior': List.generate(15, (_) => _getBrandImage('Suzuki')),
          'interior': List.generate(12, (_) => _getBrandImage('Suzuki')),
          'engine': List.generate(6, (_) => _getBrandImage('Suzuki')),
          'details': List.generate(13, (_) => _getBrandImage('Suzuki')),
        },
        features: ['ABS', 'Dual Airbags', 'Touchscreen', 'Apple CarPlay'],
        status: ListingStatus.cancelled,
        createdAt: now.subtract(const Duration(days: 20)),
        updatedAt: now.subtract(const Duration(days: 18)),
      ),
    ];
  }

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

    if (filters.towingCapacityMin != null && filters.towingCapacityMin! > 0) {
      results = results.where((car) => car.towingCapacity != null && car.towingCapacity! >= filters.towingCapacityMin!).toList();
    }

    if (filters.groundClearanceMin != null && filters.groundClearanceMin! > 0) {
      results = results.where((car) => car.groundClearance != null && car.groundClearance! >= filters.groundClearanceMin!).toList();
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

    if (filters.rimSizes.isNotEmpty) {
      results = results.where((car) => filters.rimSizes.contains(car.rimSize)).toList();
    }

    if (filters.paintTypes.isNotEmpty) {
      results = results.where((car) => filters.paintTypes.contains(car.paintType)).toList();
    }

    if (filters.rimTypes.isNotEmpty) {
      results = results.where((car) => filters.rimTypes.contains(car.rimType)).toList();
    }

    if (filters.tireConditions.isNotEmpty) {
      results = results.where((car) => filters.tireConditions.contains(car.tireCondition)).toList();
    }

    // === CONDITION & HISTORY FILTERS ===
    if (filters.mileageMin != null) {
      results = results.where((car) => car.mileage >= filters.mileageMin!).toList();
    }
    if (filters.mileageMax != null) {
      results = results.where((car) => car.mileage <= filters.mileageMax!).toList();
    }

    if (filters.ownersMax != null) {
      results = results.where((car) => car.numberOfOwners <= filters.ownersMax!).toList();
    }

    if (filters.accidentFree) {
      results = results.where((car) => !car.hasAccidentHistory).toList();
    }

    if (filters.floodFree) {
      results = results.where((car) => !car.floodDamage).toList();
    }

    if (filters.withWarranty) {
      results = results.where((car) => car.warrantyRemaining).toList();
    }

    if (filters.completeServiceHistory) {
      results = results.where((car) => car.serviceHistoryComplete).toList();
    }

    if (filters.conditions.isNotEmpty) {
      results = results.where((car) => filters.conditions.contains(car.condition)).toList();
    }

    if (filters.registrationStatuses.isNotEmpty) {
      results = results.where((car) => filters.registrationStatuses.contains(car.registrationStatus)).toList();
    }

    if (filters.emissionTestValid) {
      results = results.where((car) => car.emissionTestValid).toList();
    }

    if (filters.comprehensiveInsurance) {
      results = results.where((car) => car.comprehensiveInsurance).toList();
    }

    // === FEATURES FILTERS ===
    if (filters.features.isNotEmpty) {
      results = results.where((car) {
        return filters.features.every((feature) => car.features.contains(feature));
      }).toList();
    }

    // === LOCATION & AVAILABILITY FILTERS ===
    if (filters.region != null) {
      // Region filtering would require region-to-province mapping
    }

    if (filters.province != null) {
      results = results.where((car) => car.location.province == filters.province).toList();
    }

    if (filters.city != null) {
      results = results.where((car) => car.location.city == filters.city).toList();
    }

    if (filters.testDriveAvailable) {
      results = results.where((car) => car.availableForTestDrive).toList();
    }

    if (filters.deliveryAvailable) {
      results = results.where((car) => car.deliveryAvailable).toList();
    }

    // === SELLER PREFERENCES FILTERS ===
    if (filters.acceptsTrade) {
      results = results.where((car) => car.acceptsTrade).toList();
    }

    if (filters.financingAvailable) {
      results = results.where((car) => car.financingAvailable).toList();
    }

    if (filters.negotiable) {
      results = results.where((car) => car.priceNegotiable).toList();
    }

    // === SPECIAL FILTERS ===
    if (filters.recentlyAddedDays != null) {
      final cutoffDate = DateTime.now().subtract(Duration(days: filters.recentlyAddedDays!));
      results = results.where((car) => car.createdAt.isAfter(cutoffDate)).toList();
    }

    if (filters.recentlyUpdatedDays != null) {
      final cutoffDate = DateTime.now().subtract(Duration(days: filters.recentlyUpdatedDays!));
      results = results.where((car) => car.updatedAt.isAfter(cutoffDate)).toList();
    }

    if (filters.minViewCount != null) {
      results = results.where((car) => car.viewCount >= filters.minViewCount!).toList();
    }

    // === MEDIA FILTERS ===
    if (filters.minPhotoCount != null) {
      results = results.where((car) => car.images.length >= filters.minPhotoCount!).toList();
    }

    // Apply sorting
    switch (filters.sortBy) {
      case SortBy.priceAsc:
        // Note: We don't have price in the model, so we'll sort by year as a proxy
        results.sort((a, b) => a.year.compareTo(b.year));
        break;
      case SortBy.priceDesc:
        results.sort((a, b) => b.year.compareTo(a.year));
        break;
      case SortBy.yearNewest:
        results.sort((a, b) => b.year.compareTo(a.year));
        break;
      case SortBy.yearOldest:
        results.sort((a, b) => a.year.compareTo(b.year));
        break;
      case SortBy.mileageLowest:
        results.sort((a, b) => a.mileage.compareTo(b.mileage));
        break;
      case SortBy.mileageHighest:
        results.sort((a, b) => b.mileage.compareTo(a.mileage));
        break;
      case SortBy.horsepowerHighest:
        results.sort((a, b) => b.horsepower.compareTo(a.horsepower));
        break;
      case SortBy.horsepowerLowest:
        results.sort((a, b) => a.horsepower.compareTo(b.horsepower));
        break;
      case SortBy.fuelEconomyBest:
        results.sort((a, b) => b.fuelConsumption.compareTo(a.fuelConsumption));
        break;
      case SortBy.fuelEconomyWorst:
        results.sort((a, b) => a.fuelConsumption.compareTo(b.fuelConsumption));
        break;
      case SortBy.newest:
        results.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case SortBy.mostViewed:
        results.sort((a, b) => b.viewCount.compareTo(a.viewCount));
        break;
      case SortBy.endingSoon:
        // N/A for car listings (only for auctions)
        results.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
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

  // COMMENTED OUT: Old car generation with outdated CarModel structure
  // Using MockAuctionService comprehensive cars instead
  /*
  List<CarModel> _generateSampleListings() {
    final now = DateTime.now();

    return [
      // 1. Toyota Vios
      CarModel(
        id: 'car-ph-001',
        sellerId: 'seller-001',
        sellerName: 'Juan dela Cruz',
        brand: 'Toyota',
        model: 'Vios',
        variant: '1.3 E AT',
        year: 2022,
        mileage: 25000,
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
        description: 'Well-maintained Toyota Vios 2022. First owner, casa-maintained with complete service records. Perfect for daily commute. No accident history, all original parts. Fresh in and out.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Vios+Front',
          'https://via.placeholder.com/800x600.png?text=Vios+Side',
          'https://via.placeholder.com/800x600.png?text=Vios+Interior',
          'https://via.placeholder.com/800x600.png?text=Vios+Dashboard',
          'https://via.placeholder.com/800x600.png?text=Vios+Engine',
        ],
        features: const [
          'Air Conditioning',
          'Power Steering',
          'ABS',
          'Airbags',
          'Power Windows',
          'Touchscreen Infotainment',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 3)),
        updatedAt: now.subtract(const Duration(days: 3)),
        viewCount: 142,
      ),

      // 2. Honda Civic
      CarModel(
        id: 'car-ph-002',
        sellerId: 'seller-002',
        sellerName: 'Maria Santos',
        brand: 'Honda',
        model: 'Civic',
        variant: '1.8 RS Turbo CVT',
        year: 2020,
        mileage: 42000,
        transmission: TransmissionType.cvt,
        fuelType: FuelType.gasoline,
        bodyType: BodyType.sedan,
        color: 'Black',
        engineSize: '1.8L Turbo',
        seats: 5,
        doors: 4,
        plateNumber: 'XYZ-5678',
        orcrNumber: 'OR87654321',
        location: const CarLocation(city: 'Makati', province: 'Metro Manila'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Sporty Honda Civic RS Turbo in excellent condition. Lady-owned, garage-kept. All maintenance done at Honda Casa. Turbocharged engine with great fuel economy.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Civic+Front',
          'https://via.placeholder.com/800x600.png?text=Civic+Side',
          'https://via.placeholder.com/800x600.png?text=Civic+Interior',
          'https://via.placeholder.com/800x600.png?text=Civic+Dashboard',
          'https://via.placeholder.com/800x600.png?text=Civic+Rear',
        ],
        features: const [
          'LED Headlights',
          'Touchscreen Infotainment',
          'Apple CarPlay',
          'Android Auto',
          'Reverse Camera',
          'Cruise Control',
          'Paddle Shifters',
          'Leather Seats',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 5)),
        updatedAt: now.subtract(const Duration(days: 5)),
        viewCount: 218,
      ),

      // 3. Mitsubishi Montero Sport
      CarModel(
        id: 'car-ph-003',
        sellerId: 'seller-003',
        sellerName: 'Pedro Reyes',
        brand: 'Mitsubishi',
        model: 'Montero Sport',
        variant: 'GLS 4x2 AT',
        year: 2019,
        mileage: 65000,
        transmission: TransmissionType.automatic,
        fuelType: FuelType.diesel,
        bodyType: BodyType.suv,
        color: 'Silver',
        engineSize: '2.4L Diesel',
        seats: 7,
        doors: 4,
        plateNumber: 'DEF-9012',
        orcrNumber: 'OR13579246',
        location: const CarLocation(city: 'Pasig', province: 'Metro Manila'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Reliable Montero Sport perfect for families. Spacious 7-seater with excellent diesel fuel economy. All original, complete papers, ready for long drives.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Montero+Front',
          'https://via.placeholder.com/800x600.png?text=Montero+Side',
          'https://via.placeholder.com/800x600.png?text=Montero+Interior',
          'https://via.placeholder.com/800x600.png?text=Montero+3rd+Row',
          'https://via.placeholder.com/800x600.png?text=Montero+Cargo',
        ],
        features: const [
          'Automatic Climate Control',
          'Touchscreen Infotainment',
          'Reverse Camera',
          'Parking Sensors',
          'Leather Seats',
          'Push Start Button',
          'Keyless Entry',
          '7 Seats',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 7)),
        updatedAt: now.subtract(const Duration(days: 7)),
        viewCount: 186,
      ),

      // 4. Ford Ranger
      CarModel(
        id: 'car-ph-004',
        sellerId: 'seller-004',
        sellerName: 'Jose Garcia',
        brand: 'Ford',
        model: 'Ranger',
        variant: 'Wildtrak 4x4 AT',
        year: 2021,
        mileage: 38000,
        transmission: TransmissionType.automatic,
        fuelType: FuelType.diesel,
        bodyType: BodyType.pickup,
        color: 'Blue',
        engineSize: '2.0L Bi-Turbo',
        seats: 5,
        doors: 4,
        plateNumber: 'GHI-3456',
        orcrNumber: 'OR24681357',
        location: const CarLocation(city: 'Cebu City', province: 'Cebu'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Powerful Ford Ranger Wildtrak 4x4 with bi-turbo engine. Excellent for both city driving and off-road adventures. Well-maintained, all service records available.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Ranger+Front',
          'https://via.placeholder.com/800x600.png?text=Ranger+Side',
          'https://via.placeholder.com/800x600.png?text=Ranger+Interior',
          'https://via.placeholder.com/800x600.png?text=Ranger+Bed',
          'https://via.placeholder.com/800x600.png?text=Ranger+4x4',
        ],
        features: const [
          '4-Wheel Drive (4WD)',
          'Leather Seats',
          'Touchscreen Infotainment',
          'Reverse Camera',
          '360-degree Camera',
          'Adaptive Cruise Control',
          'Lane Departure Warning',
          'Roof Rails',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now.subtract(const Duration(days: 2)),
        viewCount: 294,
      ),

      // 5. Nissan Navara
      CarModel(
        id: 'car-ph-005',
        sellerId: 'seller-005',
        sellerName: 'Ana Mendoza',
        brand: 'Nissan',
        model: 'Navara',
        variant: 'EL Calibre 4x2 AT',
        year: 2020,
        mileage: 51000,
        transmission: TransmissionType.automatic,
        fuelType: FuelType.diesel,
        bodyType: BodyType.pickup,
        color: 'White',
        engineSize: '2.5L Diesel',
        seats: 5,
        doors: 4,
        plateNumber: 'JKL-7890',
        orcrNumber: 'OR98765432',
        location: const CarLocation(city: 'Davao City', province: 'Davao del Sur'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Nissan Navara EL Calibre in pristine condition. Great for business and family use. Fuel-efficient diesel engine, spacious cabin, reliable performance.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Navara+Front',
          'https://via.placeholder.com/800x600.png?text=Navara+Side',
          'https://via.placeholder.com/800x600.png?text=Navara+Interior',
          'https://via.placeholder.com/800x600.png?text=Navara+Bed',
          'https://via.placeholder.com/800x600.png?text=Navara+Engine',
        ],
        features: const [
          'Touchscreen Infotainment',
          'Reverse Camera',
          'Parking Sensors',
          'Automatic Climate Control',
          'Push Start Button',
          'Alloy Wheels',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 4)),
        updatedAt: now.subtract(const Duration(days: 4)),
        viewCount: 157,
      ),

      // 6. Mazda 3
      CarModel(
        id: 'car-ph-006',
        sellerId: 'seller-006',
        sellerName: 'Carlos Tan',
        brand: 'Mazda',
        model: 'Mazda3',
        variant: '2.0 Skyactiv R AT',
        year: 2023,
        mileage: 12000,
        transmission: TransmissionType.automatic,
        fuelType: FuelType.gasoline,
        bodyType: BodyType.sedan,
        color: 'Red',
        engineSize: '2.0L Skyactiv',
        seats: 5,
        doors: 4,
        plateNumber: 'MNO-2345',
        orcrNumber: 'OR11223344',
        location: const CarLocation(city: 'Taguig', province: 'Metro Manila'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.almostNew,
        description: 'Almost brand new Mazda3 with premium features. Kodo design, excellent handling, Skyactiv technology for great fuel economy. Still under warranty.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Mazda3+Front',
          'https://via.placeholder.com/800x600.png?text=Mazda3+Side',
          'https://via.placeholder.com/800x600.png?text=Mazda3+Interior',
          'https://via.placeholder.com/800x600.png?text=Mazda3+Dashboard',
          'https://via.placeholder.com/800x600.png?text=Mazda3+Rear',
        ],
        features: const [
          'LED Headlights',
          'Leather Seats',
          'Heads-Up Display',
          'Bose Sound System',
          'Apple CarPlay',
          'Android Auto',
          'Adaptive Cruise Control',
          'Blind Spot Monitoring',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(days: 1)),
        viewCount: 329,
      ),

      // 7. Hyundai Accent
      CarModel(
        id: 'car-ph-007',
        sellerId: 'seller-007',
        sellerName: 'Lisa Wong',
        brand: 'Hyundai',
        model: 'Accent',
        variant: '1.4 GL MT',
        year: 2018,
        mileage: 72000,
        transmission: TransmissionType.manual,
        fuelType: FuelType.gasoline,
        bodyType: BodyType.sedan,
        color: 'Silver',
        engineSize: '1.4L',
        seats: 5,
        doors: 4,
        plateNumber: 'PQR-6789',
        orcrNumber: 'OR55667788',
        location: const CarLocation(city: 'Manila', province: 'Metro Manila'),
        numberOfOwners: 2,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Reliable Hyundai Accent manual transmission. Great fuel economy, easy to maintain. Perfect first car or daily driver. Clean papers, no issues.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Accent+Front',
          'https://via.placeholder.com/800x600.png?text=Accent+Side',
          'https://via.placeholder.com/800x600.png?text=Accent+Interior',
          'https://via.placeholder.com/800x600.png?text=Accent+Dashboard',
          'https://via.placeholder.com/800x600.png?text=Accent+Engine',
        ],
        features: const [
          'Air Conditioning',
          'Power Steering',
          'Power Windows',
          'ABS',
          'Airbags',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 8)),
        updatedAt: now.subtract(const Duration(days: 8)),
        viewCount: 98,
      ),

      // 8. Toyota Fortuner
      CarModel(
        id: 'car-ph-008',
        sellerId: 'seller-008',
        sellerName: 'Robert Chen',
        brand: 'Toyota',
        model: 'Fortuner',
        variant: '2.4 G 4x2 AT',
        year: 2021,
        mileage: 35000,
        transmission: TransmissionType.automatic,
        fuelType: FuelType.diesel,
        bodyType: BodyType.suv,
        color: 'Gray',
        engineSize: '2.4L Diesel',
        seats: 7,
        doors: 4,
        plateNumber: 'STU-0123',
        orcrNumber: 'OR99887766',
        location: const CarLocation(city: 'Caloocan', province: 'Metro Manila'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Premium Toyota Fortuner, perfect family SUV. Spacious, comfortable, and reliable. All service records from Toyota casa. Excellent condition inside and out.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Fortuner+Front',
          'https://via.placeholder.com/800x600.png?text=Fortuner+Side',
          'https://via.placeholder.com/800x600.png?text=Fortuner+Interior',
          'https://via.placeholder.com/800x600.png?text=Fortuner+3rd+Row',
          'https://via.placeholder.com/800x600.png?text=Fortuner+Cargo',
        ],
        features: const [
          'Leather Seats',
          'Touchscreen Infotainment',
          'Reverse Camera',
          'Parking Sensors',
          'Automatic Climate Control',
          'Push Start Button',
          'Keyless Entry',
          '7 Seats',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 6)),
        updatedAt: now.subtract(const Duration(days: 6)),
        viewCount: 267,
      ),

      // 9. Kia Sportage
      CarModel(
        id: 'car-ph-009',
        sellerId: 'seller-009',
        sellerName: 'Michelle Lopez',
        brand: 'Kia',
        model: 'Sportage',
        variant: '2.0 EX AT',
        year: 2019,
        mileage: 48000,
        transmission: TransmissionType.automatic,
        fuelType: FuelType.gasoline,
        bodyType: BodyType.suv,
        color: 'White',
        engineSize: '2.0L',
        seats: 5,
        doors: 4,
        plateNumber: 'VWX-4567',
        orcrNumber: 'OR33221144',
        location: const CarLocation(city: 'Pasay', province: 'Metro Manila'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Stylish Kia Sportage with modern features. Well-maintained, garage-kept. Perfect combination of comfort and performance. All factory features intact.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Sportage+Front',
          'https://via.placeholder.com/800x600.png?text=Sportage+Side',
          'https://via.placeholder.com/800x600.png?text=Sportage+Interior',
          'https://via.placeholder.com/800x600.png?text=Sportage+Dashboard',
          'https://via.placeholder.com/800x600.png?text=Sportage+Cargo',
        ],
        features: const [
          'Panoramic Sunroof',
          'Leather Seats',
          'Touchscreen Infotainment',
          'Reverse Camera',
          'Blind Spot Monitoring',
          'Lane Departure Warning',
          'Automatic Climate Control',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 9)),
        updatedAt: now.subtract(const Duration(days: 9)),
        viewCount: 175,
      ),

      // 10. Honda CR-V
      CarModel(
        id: 'car-ph-010',
        sellerId: 'seller-010',
        sellerName: 'David Lim',
        brand: 'Honda',
        model: 'CR-V',
        variant: '2.0 S CVT',
        year: 2022,
        mileage: 28000,
        transmission: TransmissionType.cvt,
        fuelType: FuelType.gasoline,
        bodyType: BodyType.suv,
        color: 'Black',
        engineSize: '2.0L',
        seats: 5,
        doors: 4,
        plateNumber: 'YZA-8901',
        orcrNumber: 'OR77665544',
        location: const CarLocation(city: 'Parañaque', province: 'Metro Manila'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Honda CR-V in excellent condition. Spacious, fuel-efficient, and loaded with safety features. Perfect for families. Casa-maintained with complete records.',
        images: [
          'https://via.placeholder.com/800x600.png?text=CRV+Front',
          'https://via.placeholder.com/800x600.png?text=CRV+Side',
          'https://via.placeholder.com/800x600.png?text=CRV+Interior',
          'https://via.placeholder.com/800x600.png?text=CRV+Dashboard',
          'https://via.placeholder.com/800x600.png?text=CRV+Cargo',
        ],
        features: const [
          'Honda Sensing',
          'Adaptive Cruise Control',
          'Lane Keeping Assist',
          'Automatic Emergency Braking',
          'Touchscreen Infotainment',
          'Apple CarPlay',
          'Android Auto',
          'Panoramic Sunroof',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 3)),
        updatedAt: now.subtract(const Duration(days: 3)),
        viewCount: 312,
      ),

      // 11. Suzuki Swift
      CarModel(
        id: 'car-ph-011',
        sellerId: 'seller-011',
        sellerName: 'Jenny Cruz',
        brand: 'Suzuki',
        model: 'Swift',
        variant: '1.2 GL MT',
        year: 2017,
        mileage: 82000,
        transmission: TransmissionType.manual,
        fuelType: FuelType.gasoline,
        bodyType: BodyType.hatchback,
        color: 'Yellow',
        engineSize: '1.2L',
        seats: 5,
        doors: 4,
        plateNumber: 'BCD-2345',
        orcrNumber: 'OR11335577',
        location: const CarLocation(city: 'Las Piñas', province: 'Metro Manila'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Fun and economical Suzuki Swift. Great for city driving, easy to park. Manual transmission for driving enthusiasts. Well-maintained, no major issues.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Swift+Front',
          'https://via.placeholder.com/800x600.png?text=Swift+Side',
          'https://via.placeholder.com/800x600.png?text=Swift+Interior',
          'https://via.placeholder.com/800x600.png?text=Swift+Dashboard',
          'https://via.placeholder.com/800x600.png?text=Swift+Rear',
        ],
        features: const [
          'Air Conditioning',
          'Power Steering',
          'ABS',
          'Airbags',
          'Power Windows',
          'Alloy Wheels',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 10)),
        updatedAt: now.subtract(const Duration(days: 10)),
        viewCount: 124,
      ),

      // 12. Toyota Corolla Altis
      CarModel(
        id: 'car-ph-012',
        sellerId: 'seller-012',
        sellerName: 'Mark Johnson',
        brand: 'Toyota',
        model: 'Corolla Altis',
        variant: '1.6 V AT',
        year: 2020,
        mileage: 38000,
        transmission: TransmissionType.automatic,
        fuelType: FuelType.gasoline,
        bodyType: BodyType.sedan,
        color: 'Pearl White',
        engineSize: '1.6L',
        seats: 5,
        doors: 4,
        plateNumber: 'EFG-6789',
        orcrNumber: 'OR22446688',
        location: const CarLocation(city: 'Muntinlupa', province: 'Metro Manila'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Premium Toyota Corolla Altis with excellent features. Comfortable, reliable, and fuel-efficient. Perfect executive sedan. All maintenance records available.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Altis+Front',
          'https://via.placeholder.com/800x600.png?text=Altis+Side',
          'https://via.placeholder.com/800x600.png?text=Altis+Interior',
          'https://via.placeholder.com/800x600.png?text=Altis+Dashboard',
          'https://via.placeholder.com/800x600.png?text=Altis+Engine',
        ],
        features: const [
          'Leather Seats',
          'Touchscreen Infotainment',
          'Reverse Camera',
          'Automatic Climate Control',
          'Push Start Button',
          'Keyless Entry',
          'LED Headlights',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 5)),
        updatedAt: now.subtract(const Duration(days: 5)),
        viewCount: 203,
      ),

      // 13. Mitsubishi Xpander
      CarModel(
        id: 'car-ph-013',
        sellerId: 'seller-013',
        sellerName: 'Sarah Kim',
        brand: 'Mitsubishi',
        model: 'Xpander',
        variant: 'GLS Sport AT',
        year: 2023,
        mileage: 8000,
        transmission: TransmissionType.automatic,
        fuelType: FuelType.gasoline,
        bodyType: BodyType.mpv,
        color: 'Red',
        engineSize: '1.5L',
        seats: 7,
        doors: 4,
        plateNumber: 'HIJ-0123',
        orcrNumber: 'OR88776655',
        location: const CarLocation(city: 'Mandaluyong', province: 'Metro Manila'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.almostNew,
        description: 'Almost new Mitsubishi Xpander, perfect family MPV. Spacious 7-seater with modern design. Still under warranty. Barely used, like brand new condition.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Xpander+Front',
          'https://via.placeholder.com/800x600.png?text=Xpander+Side',
          'https://via.placeholder.com/800x600.png?text=Xpander+Interior',
          'https://via.placeholder.com/800x600.png?text=Xpander+3rd+Row',
          'https://via.placeholder.com/800x600.png?text=Xpander+Cargo',
        ],
        features: const [
          'Touchscreen Infotainment',
          'Apple CarPlay',
          'Android Auto',
          'Reverse Camera',
          'Parking Sensors',
          'Automatic Climate Control',
          '7 Seats',
          'Alloy Wheels',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(hours: 18)),
        updatedAt: now.subtract(const Duration(hours: 18)),
        viewCount: 389,
      ),

      // 14. Isuzu D-Max
      CarModel(
        id: 'car-ph-014',
        sellerId: 'seller-014',
        sellerName: 'Antonio Reyes',
        brand: 'Isuzu',
        model: 'D-Max',
        variant: 'LS 4x4 AT',
        year: 2020,
        mileage: 55000,
        transmission: TransmissionType.automatic,
        fuelType: FuelType.diesel,
        bodyType: BodyType.pickup,
        color: 'Silver',
        engineSize: '3.0L Diesel',
        seats: 5,
        doors: 4,
        plateNumber: 'KLM-4567',
        orcrNumber: 'OR44332211',
        location: const CarLocation(city: 'Antipolo', province: 'Rizal'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Tough and reliable Isuzu D-Max 4x4. Perfect for both work and adventure. Powerful diesel engine, excellent towing capacity. Well-maintained by single owner.',
        images: [
          'https://via.placeholder.com/800x600.png?text=DMax+Front',
          'https://via.placeholder.com/800x600.png?text=DMax+Side',
          'https://via.placeholder.com/800x600.png?text=DMax+Interior',
          'https://via.placeholder.com/800x600.png?text=DMax+Bed',
          'https://via.placeholder.com/800x600.png?text=DMax+4x4',
        ],
        features: const [
          '4-Wheel Drive (4WD)',
          'Touchscreen Infotainment',
          'Reverse Camera',
          'Parking Sensors',
          'Leather Seats',
          'Automatic Climate Control',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 7)),
        updatedAt: now.subtract(const Duration(days: 7)),
        viewCount: 195,
      ),

      // 15. Mazda CX-5
      CarModel(
        id: 'car-ph-015',
        sellerId: 'seller-015',
        sellerName: 'Christine Tan',
        brand: 'Mazda',
        model: 'CX-5',
        variant: '2.5 AWD Sport AT',
        year: 2022,
        mileage: 22000,
        transmission: TransmissionType.automatic,
        fuelType: FuelType.gasoline,
        bodyType: BodyType.suv,
        color: 'Blue',
        engineSize: '2.5L Skyactiv',
        seats: 5,
        doors: 4,
        plateNumber: 'NOP-8901',
        orcrNumber: 'OR66554433',
        location: const CarLocation(city: 'Baguio', province: 'Benguet'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Premium Mazda CX-5 AWD with excellent handling and features. Perfect for Baguio roads. Kodo design, comfortable interior, advanced safety features.',
        images: [
          'https://via.placeholder.com/800x600.png?text=CX5+Front',
          'https://via.placeholder.com/800x600.png?text=CX5+Side',
          'https://via.placeholder.com/800x600.png?text=CX5+Interior',
          'https://via.placeholder.com/800x600.png?text=CX5+Dashboard',
          'https://via.placeholder.com/800x600.png?text=CX5+Cargo',
        ],
        features: const [
          'All-Wheel Drive (AWD)',
          'Leather Seats',
          'Bose Sound System',
          'Heads-Up Display',
          'Adaptive Cruise Control',
          'Blind Spot Monitoring',
          'Lane Departure Warning',
          'Automatic Emergency Braking',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 4)),
        updatedAt: now.subtract(const Duration(days: 4)),
        viewCount: 241,
      ),

      // 16. Chevrolet Trailblazer
      CarModel(
        id: 'car-ph-016',
        sellerId: 'seller-016',
        sellerName: 'Raymond Diaz',
        brand: 'Chevrolet',
        model: 'Trailblazer',
        variant: 'LTX 4x2 AT',
        year: 2018,
        mileage: 78000,
        transmission: TransmissionType.automatic,
        fuelType: FuelType.diesel,
        bodyType: BodyType.suv,
        color: 'Black',
        engineSize: '2.8L Diesel',
        seats: 7,
        doors: 4,
        plateNumber: 'QRS-2345',
        orcrNumber: 'OR99881122',
        location: const CarLocation(city: 'Bacoor', province: 'Cavite'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Chevrolet Trailblazer with powerful diesel engine. Spacious 7-seater SUV perfect for families. All maintenance done at authorized service center.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Trailblazer+Front',
          'https://via.placeholder.com/800x600.png?text=Trailblazer+Side',
          'https://via.placeholder.com/800x600.png?text=Trailblazer+Interior',
          'https://via.placeholder.com/800x600.png?text=Trailblazer+3rd+Row',
          'https://via.placeholder.com/800x600.png?text=Trailblazer+Cargo',
        ],
        features: const [
          'Leather Seats',
          'Touchscreen Infotainment',
          'Reverse Camera',
          'Parking Sensors',
          'Automatic Climate Control',
          '7 Seats',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 11)),
        updatedAt: now.subtract(const Duration(days: 11)),
        viewCount: 142,
      ),

      // 17. Subaru Forester
      CarModel(
        id: 'car-ph-017',
        sellerId: 'seller-017',
        sellerName: 'Jessica Park',
        brand: 'Subaru',
        model: 'Forester',
        variant: '2.0i-L CVT',
        year: 2021,
        mileage: 32000,
        transmission: TransmissionType.cvt,
        fuelType: FuelType.gasoline,
        bodyType: BodyType.suv,
        color: 'Green',
        engineSize: '2.0L',
        seats: 5,
        doors: 4,
        plateNumber: 'TUV-6789',
        orcrNumber: 'OR33445566',
        location: const CarLocation(city: 'Calamba', province: 'Laguna'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Subaru Forester with legendary AWD system. Perfect for all weather conditions. Excellent safety ratings, spacious interior, boxer engine reliability.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Forester+Front',
          'https://via.placeholder.com/800x600.png?text=Forester+Side',
          'https://via.placeholder.com/800x600.png?text=Forester+Interior',
          'https://via.placeholder.com/800x600.png?text=Forester+Dashboard',
          'https://via.placeholder.com/800x600.png?text=Forester+Cargo',
        ],
        features: const [
          'Symmetrical All-Wheel Drive (AWD)',
          'EyeSight Driver Assist',
          'Adaptive Cruise Control',
          'Lane Keep Assist',
          'Pre-Collision Braking',
          'Touchscreen Infotainment',
          'Apple CarPlay',
          'Android Auto',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 6)),
        updatedAt: now.subtract(const Duration(days: 6)),
        viewCount: 218,
      ),

      // 18. Honda City
      CarModel(
        id: 'car-ph-018',
        sellerId: 'seller-018',
        sellerName: 'Michael Santos',
        brand: 'Honda',
        model: 'City',
        variant: 'VX CVT',
        year: 2021,
        mileage: 31000,
        transmission: TransmissionType.cvt,
        fuelType: FuelType.gasoline,
        bodyType: BodyType.sedan,
        color: 'Gray',
        engineSize: '1.5L',
        seats: 5,
        doors: 4,
        plateNumber: 'WXY-0123',
        orcrNumber: 'OR77889900',
        location: const CarLocation(city: 'Malolos', province: 'Bulacan'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Honda City VX top variant with all features. Excellent fuel economy, spacious interior, advanced safety. Perfect daily driver for work and family.',
        images: [
          'https://via.placeholder.com/800x600.png?text=City+Front',
          'https://via.placeholder.com/800x600.png?text=City+Side',
          'https://via.placeholder.com/800x600.png?text=City+Interior',
          'https://via.placeholder.com/800x600.png?text=City+Dashboard',
          'https://via.placeholder.com/800x600.png?text=City+Trunk',
        ],
        features: const [
          'Honda Sensing',
          'Adaptive Cruise Control',
          'Lane Keep Assist',
          'Touchscreen Infotainment',
          'Apple CarPlay',
          'Android Auto',
          'Reverse Camera',
          'LED Headlights',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 8)),
        updatedAt: now.subtract(const Duration(days: 8)),
        viewCount: 176,
      ),

      // 19. Toyota Hilux
      CarModel(
        id: 'car-ph-019',
        sellerId: 'seller-019',
        sellerName: 'Emmanuel Cruz',
        brand: 'Toyota',
        model: 'Hilux',
        variant: 'G 4x4 AT',
        year: 2020,
        mileage: 62000,
        transmission: TransmissionType.automatic,
        fuelType: FuelType.diesel,
        bodyType: BodyType.pickup,
        color: 'White',
        engineSize: '2.4L Diesel',
        seats: 5,
        doors: 4,
        plateNumber: 'ZAB-4567',
        orcrNumber: 'OR11223355',
        location: const CarLocation(city: 'Angeles City', province: 'Pampanga'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Legendary Toyota Hilux 4x4. Indestructible reliability, perfect for work and adventure. Well-maintained, all service records available. Ready for any terrain.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Hilux+Front',
          'https://via.placeholder.com/800x600.png?text=Hilux+Side',
          'https://via.placeholder.com/800x600.png?text=Hilux+Interior',
          'https://via.placeholder.com/800x600.png?text=Hilux+Bed',
          'https://via.placeholder.com/800x600.png?text=Hilux+4x4',
        ],
        features: const [
          '4-Wheel Drive (4WD)',
          'Touchscreen Infotainment',
          'Reverse Camera',
          'Automatic Climate Control',
          'Push Start Button',
          'Leather Seats',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 9)),
        updatedAt: now.subtract(const Duration(days: 9)),
        viewCount: 223,
      ),

      // 20. Nissan Terra
      CarModel(
        id: 'car-ph-020',
        sellerId: 'seller-020',
        sellerName: 'Catherine Lee',
        brand: 'Nissan',
        model: 'Terra',
        variant: 'VL 4x2 AT',
        year: 2022,
        mileage: 18000,
        transmission: TransmissionType.automatic,
        fuelType: FuelType.diesel,
        bodyType: BodyType.suv,
        color: 'Black',
        engineSize: '2.5L Diesel',
        seats: 7,
        doors: 4,
        plateNumber: 'CDE-8901',
        orcrNumber: 'OR44556677',
        location: const CarLocation(city: 'Batangas City', province: 'Batangas'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Nissan Terra VL top variant with premium features. Spacious 7-seater SUV perfect for families. Low mileage, excellent condition, still under warranty.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Terra+Front',
          'https://via.placeholder.com/800x600.png?text=Terra+Side',
          'https://via.placeholder.com/800x600.png?text=Terra+Interior',
          'https://via.placeholder.com/800x600.png?text=Terra+3rd+Row',
          'https://via.placeholder.com/800x600.png?text=Terra+Dashboard',
        ],
        features: const [
          'Nissan Intelligent Mobility',
          'Leather Seats',
          'Touchscreen Infotainment',
          'Around View Monitor',
          'Blind Spot Warning',
          'Automatic Climate Control',
          '7 Seats',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now.subtract(const Duration(days: 2)),
        viewCount: 298,
      ),

      // 21. MG ZS
      CarModel(
        id: 'car-ph-021',
        sellerId: 'seller-021',
        sellerName: 'Andrew Ng',
        brand: 'MG',
        model: 'ZS',
        variant: 'Style AT',
        year: 2021,
        mileage: 35000,
        transmission: TransmissionType.automatic,
        fuelType: FuelType.gasoline,
        bodyType: BodyType.suv,
        color: 'Red',
        engineSize: '1.5L Turbo',
        seats: 5,
        doors: 4,
        plateNumber: 'FGH-2345',
        orcrNumber: 'OR88990011',
        location: const CarLocation(city: 'Iloilo City', province: 'Iloilo'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'MG ZS with turbocharged engine and modern features. Excellent value for money. Comfortable ride, good fuel economy, well-equipped interior.',
        images: [
          'https://via.placeholder.com/800x600.png?text=ZS+Front',
          'https://via.placeholder.com/800x600.png?text=ZS+Side',
          'https://via.placeholder.com/800x600.png?text=ZS+Interior',
          'https://via.placeholder.com/800x600.png?text=ZS+Dashboard',
          'https://via.placeholder.com/800x600.png?text=ZS+Cargo',
        ],
        features: const [
          'Panoramic Sunroof',
          'Touchscreen Infotainment',
          'Apple CarPlay',
          'Android Auto',
          'Reverse Camera',
          'Automatic Climate Control',
          'Leather Seats',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 12)),
        updatedAt: now.subtract(const Duration(days: 12)),
        viewCount: 156,
      ),

      // 22. Toyota Wigo
      CarModel(
        id: 'car-ph-022',
        sellerId: 'seller-022',
        sellerName: 'Diana Martinez',
        brand: 'Toyota',
        model: 'Wigo',
        variant: '1.0 G AT',
        year: 2019,
        mileage: 46000,
        transmission: TransmissionType.automatic,
        fuelType: FuelType.gasoline,
        bodyType: BodyType.hatchback,
        color: 'White',
        engineSize: '1.0L',
        seats: 5,
        doors: 4,
        plateNumber: 'IJK-6789',
        orcrNumber: 'OR22334455',
        location: const CarLocation(city: 'Cagayan de Oro', province: 'Misamis Oriental'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Compact and economical Toyota Wigo. Perfect for city driving and easy to park. Excellent fuel economy, reliable Toyota quality. Well-maintained by lady owner.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Wigo+Front',
          'https://via.placeholder.com/800x600.png?text=Wigo+Side',
          'https://via.placeholder.com/800x600.png?text=Wigo+Interior',
          'https://via.placeholder.com/800x600.png?text=Wigo+Dashboard',
          'https://via.placeholder.com/800x600.png?text=Wigo+Hatch',
        ],
        features: const [
          'Air Conditioning',
          'Power Steering',
          'Power Windows',
          'Touchscreen Infotainment',
          'Reverse Camera',
          'ABS',
          'Airbags',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 13)),
        updatedAt: now.subtract(const Duration(days: 13)),
        viewCount: 118,
      ),

      // 23. Ford Everest
      CarModel(
        id: 'car-ph-023',
        sellerId: 'seller-023',
        sellerName: 'Vincent Gomez',
        brand: 'Ford',
        model: 'Everest',
        variant: 'Titanium 4x2 AT',
        year: 2021,
        mileage: 41000,
        transmission: TransmissionType.automatic,
        fuelType: FuelType.diesel,
        bodyType: BodyType.suv,
        color: 'Gray',
        engineSize: '2.0L Bi-Turbo',
        seats: 7,
        doors: 4,
        plateNumber: 'LMN-0123',
        orcrNumber: 'OR66778899',
        location: const CarLocation(city: 'Bacolod', province: 'Negros Occidental'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Ford Everest Titanium with premium features. Powerful bi-turbo engine, spacious 7-seater SUV. Perfect for long drives and family trips. Excellent condition.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Everest+Front',
          'https://via.placeholder.com/800x600.png?text=Everest+Side',
          'https://via.placeholder.com/800x600.png?text=Everest+Interior',
          'https://via.placeholder.com/800x600.png?text=Everest+3rd+Row',
          'https://via.placeholder.com/800x600.png?text=Everest+Cargo',
        ],
        features: const [
          'Leather Seats',
          'SYNC 3 Infotainment',
          'Apple CarPlay',
          'Android Auto',
          'Adaptive Cruise Control',
          'Lane Keeping Aid',
          'Blind Spot Monitoring',
          '7 Seats',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 14)),
        updatedAt: now.subtract(const Duration(days: 14)),
        viewCount: 209,
      ),

      // 24. Hyundai Tucson
      CarModel(
        id: 'car-ph-024',
        sellerId: 'seller-024',
        sellerName: 'Rachel Kim',
        brand: 'Hyundai',
        model: 'Tucson',
        variant: '2.0 GL AT',
        year: 2020,
        mileage: 39000,
        transmission: TransmissionType.automatic,
        fuelType: FuelType.diesel,
        bodyType: BodyType.suv,
        color: 'White',
        engineSize: '2.0L Diesel',
        seats: 5,
        doors: 4,
        plateNumber: 'OPQ-4567',
        orcrNumber: 'OR55443322',
        location: const CarLocation(city: 'General Santos', province: 'South Cotabato'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Hyundai Tucson diesel variant with excellent fuel economy. Modern design, comfortable interior, reliable performance. All service records from Hyundai dealer.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Tucson+Front',
          'https://via.placeholder.com/800x600.png?text=Tucson+Side',
          'https://via.placeholder.com/800x600.png?text=Tucson+Interior',
          'https://via.placeholder.com/800x600.png?text=Tucson+Dashboard',
          'https://via.placeholder.com/800x600.png?text=Tucson+Cargo',
        ],
        features: const [
          'Touchscreen Infotainment',
          'Reverse Camera',
          'Parking Sensors',
          'Automatic Climate Control',
          'Push Start Button',
          'Keyless Entry',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 15)),
        updatedAt: now.subtract(const Duration(days: 15)),
        viewCount: 167,
      ),

      // 25. Mitsubishi Mirage
      CarModel(
        id: 'car-ph-025',
        sellerId: 'seller-025',
        sellerName: 'Kevin Tan',
        brand: 'Mitsubishi',
        model: 'Mirage',
        variant: 'GLS CVT',
        year: 2020,
        mileage: 37000,
        transmission: TransmissionType.cvt,
        fuelType: FuelType.gasoline,
        bodyType: BodyType.hatchback,
        color: 'Blue',
        engineSize: '1.2L',
        seats: 5,
        doors: 4,
        plateNumber: 'RST-8901',
        orcrNumber: 'OR99887766',
        location: const CarLocation(city: 'Zamboanga City', province: 'Zamboanga del Sur'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Fuel-efficient Mitsubishi Mirage. Perfect city car with excellent fuel economy. Low maintenance costs, reliable performance. Great first car option.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Mirage+Front',
          'https://via.placeholder.com/800x600.png?text=Mirage+Side',
          'https://via.placeholder.com/800x600.png?text=Mirage+Interior',
          'https://via.placeholder.com/800x600.png?text=Mirage+Dashboard',
          'https://via.placeholder.com/800x600.png?text=Mirage+Hatch',
        ],
        features: const [
          'Touchscreen Infotainment',
          'Apple CarPlay',
          'Android Auto',
          'Reverse Camera',
          'Automatic Climate Control',
          'Push Start Button',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 16)),
        updatedAt: now.subtract(const Duration(days: 16)),
        viewCount: 132,
      ),

      // 26. Toyota RAV4
      CarModel(
        id: 'car-ph-026',
        sellerId: 'seller-026',
        sellerName: 'Patricia Reyes',
        brand: 'Toyota',
        model: 'RAV4',
        variant: '2.5 LTD Hybrid',
        year: 2023,
        mileage: 5000,
        transmission: TransmissionType.cvt,
        fuelType: FuelType.hybrid,
        bodyType: BodyType.suv,
        color: 'Silver',
        engineSize: '2.5L Hybrid',
        seats: 5,
        doors: 4,
        plateNumber: 'UVW-2345',
        orcrNumber: 'OR11224433',
        location: const CarLocation(city: 'Tagaytay', province: 'Cavite'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.almostNew,
        description: 'Almost brand new Toyota RAV4 Hybrid. Excellent fuel economy with hybrid technology. Top variant with all safety features. Still under full warranty.',
        images: [
          'https://via.placeholder.com/800x600.png?text=RAV4+Front',
          'https://via.placeholder.com/800x600.png?text=RAV4+Side',
          'https://via.placeholder.com/800x600.png?text=RAV4+Interior',
          'https://via.placeholder.com/800x600.png?text=RAV4+Dashboard',
          'https://via.placeholder.com/800x600.png?text=RAV4+Cargo',
        ],
        features: const [
          'Toyota Safety Sense',
          'Adaptive Cruise Control',
          'Lane Departure Alert',
          'Pre-Collision System',
          'Leather Seats',
          'Panoramic Sunroof',
          'JBL Premium Sound',
          'Wireless Charging',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(hours: 12)),
        updatedAt: now.subtract(const Duration(hours: 12)),
        viewCount: 427,
      ),

      // 27. Suzuki Ertiga
      CarModel(
        id: 'car-ph-027',
        sellerId: 'seller-027',
        sellerName: 'Benjamin Cruz',
        brand: 'Suzuki',
        model: 'Ertiga',
        variant: 'GLX AT',
        year: 2021,
        mileage: 29000,
        transmission: TransmissionType.automatic,
        fuelType: FuelType.gasoline,
        bodyType: BodyType.mpv,
        color: 'Gray',
        engineSize: '1.5L',
        seats: 7,
        doors: 4,
        plateNumber: 'XYZ-6789',
        orcrNumber: 'OR33556677',
        location: const CarLocation(city: 'Santa Rosa', province: 'Laguna'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.used,
        description: 'Suzuki Ertiga 7-seater MPV perfect for families. Fuel-efficient, easy to drive, spacious interior. Excellent condition, all maintenance records available.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Ertiga+Front',
          'https://via.placeholder.com/800x600.png?text=Ertiga+Side',
          'https://via.placeholder.com/800x600.png?text=Ertiga+Interior',
          'https://via.placeholder.com/800x600.png?text=Ertiga+3rd+Row',
          'https://via.placeholder.com/800x600.png?text=Ertiga+Cargo',
        ],
        features: const [
          'Touchscreen Infotainment',
          'Apple CarPlay',
          'Android Auto',
          'Reverse Camera',
          'Automatic Climate Control',
          '7 Seats',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 17)),
        updatedAt: now.subtract(const Duration(days: 17)),
        viewCount: 145,
      ),

      // 28. Kia Seltos
      CarModel(
        id: 'car-ph-028',
        sellerId: 'seller-028',
        sellerName: 'Stephanie Wong',
        brand: 'Kia',
        model: 'Seltos',
        variant: '1.4 GT-Line Turbo DCT',
        year: 2022,
        mileage: 16000,
        transmission: TransmissionType.dct,
        fuelType: FuelType.gasoline,
        bodyType: BodyType.suv,
        color: 'Orange',
        engineSize: '1.4L Turbo',
        seats: 5,
        doors: 4,
        plateNumber: 'ABC-0123',
        orcrNumber: 'OR77665544',
        location: const CarLocation(city: 'San Fernando', province: 'Pampanga'),
        numberOfOwners: 1,
        serviceHistoryComplete: true,
        hasAccidentHistory: false,
        condition: CarCondition.almostNew,
        description: 'Kia Seltos GT-Line with sporty design and turbocharged engine. Modern features, excellent safety. Low mileage, almost new condition. Still under warranty.',
        images: [
          'https://via.placeholder.com/800x600.png?text=Seltos+Front',
          'https://via.placeholder.com/800x600.png?text=Seltos+Side',
          'https://via.placeholder.com/800x600.png?text=Seltos+Interior',
          'https://via.placeholder.com/800x600.png?text=Seltos+Dashboard',
          'https://via.placeholder.com/800x600.png?text=Seltos+Cargo',
        ],
        features: const [
          'Panoramic Sunroof',
          'Leather Seats',
          'Bose Sound System',
          'Touchscreen Infotainment',
          'Blind Spot Detection',
          'Rear Cross Traffic Alert',
          'LED Headlights',
          '10.25 inch Display',
        ],
        status: ListingStatus.active,
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(days: 1)),
        viewCount: 365,
      ),
    ];
  }
  */
}
