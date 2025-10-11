import 'dart:async';
import 'dart:math';
import '../../models/auction_model.dart';
import '../../models/bid_model.dart';
import '../../models/auto_bid_config.dart';
import '../../models/car_model.dart';
import '../../../core/constants/bid_increments.dart';
import '../../../config/app_config.dart';
import '../../../domain/repositories/auction_repository.dart';
import '../../../domain/services/pricing_calculator.dart';

class MockAuctionService implements AuctionRepository {
  static final MockAuctionService _instance = MockAuctionService._internal();
  factory MockAuctionService() => _instance;
  MockAuctionService._internal();

  final List<Auction> _auctions = [];
  final List<Bid> _bids = [];
  final Map<String, AutoBidConfig> _autoBidConfigs = {};
  List<CarModel> _availableCars = [];
  Timer? _simulationTimer;
  Timer? _statusUpdateTimer;

  final _auctionStreamController = StreamController<List<Auction>>.broadcast();
  final _bidStreamController = StreamController<Map<String, List<Bid>>>.broadcast();

  @override
  Stream<List<Auction>> get auctionsStream => _auctionStreamController.stream;

  @override
  Stream<List<Bid>> get bidsStream =>
      _bidStreamController.stream.map((bidMap) => bidMap.values.expand((bids) => bids).toList());

  @override
  void initialize() {
    _generateMockAuctions();
    if (AppConfig.enableDemoData) {
      _generateMockUserBids();
    }
    _startSimulation();
    _startStatusUpdates();
  }

  @override
  void dispose() {
    _simulationTimer?.cancel();
    _statusUpdateTimer?.cancel();
    _auctionStreamController.close();
    _bidStreamController.close();
  }

  @override
  List<Auction> getAuctions() => List.from(_auctions);

  List<CarModel> _generateFallbackCars() {
    final now = DateTime.now();

    // Comprehensive realistic car data for PH market
    final carData = [
      // 1. Toyota Vios - Popular sedan
      {
        'brand': 'Toyota', 'model': 'Vios', 'variant': 'E 1.3 MT', 'year': 2022,
        'engineSize': '1.3L', 'engineType': EngineType.inline, 'cylinders': 4,
        'horsepower': 98, 'torque': 123, 'transmission': TransmissionType.manual, 'transmissionSpeeds': 5,
        'driveType': DriveType.fwd, 'fuelType': FuelType.gasoline, 'fuelConsumption': 18.5,
        'bodyType': BodyType.sedan, 'doors': 4, 'seats': 5,
        'curbWeight': 1090, 'grossWeight': 1495, 'cargoCapacity': 506, 'groundClearance': 133,
        'length': 4425, 'width': 1730, 'height': 1475, 'wheelbase': 2550,
        'color': 'White', 'paintType': PaintType.solid, 'rimSize': 15, 'rimType': RimType.alloy,
        'tireCondition': TireCondition.good, 'condition': CarCondition.used, 'mileage': 35000,
        'numberOfOwners': 1, 'hasAccidentHistory': false, 'floodDamage': false,
        'features': ['ABS', 'Dual Airbags', 'Power Windows', 'Central Locking', 'Bluetooth'],
      },
      // 2. Honda CR-V - Popular SUV
      {
        'brand': 'Honda', 'model': 'CR-V', 'variant': 'S CVT', 'year': 2021,
        'engineSize': '2.0L', 'engineType': EngineType.inline, 'cylinders': 4,
        'horsepower': 154, 'torque': 189, 'transmission': TransmissionType.cvt, 'transmissionSpeeds': 0,
        'driveType': DriveType.fwd, 'fuelType': FuelType.gasoline, 'fuelConsumption': 13.2,
        'bodyType': BodyType.suv, 'doors': 5, 'seats': 7,
        'curbWeight': 1665, 'grossWeight': 2135, 'cargoCapacity': 522, 'groundClearance': 198,
        'length': 4600, 'width': 1855, 'height': 1679, 'wheelbase': 2660,
        'color': 'Silver', 'paintType': PaintType.metallic, 'rimSize': 18, 'rimType': RimType.alloy,
        'tireCondition': TireCondition.good, 'condition': CarCondition.almostNew, 'mileage': 18000,
        'numberOfOwners': 1, 'hasAccidentHistory': false, 'floodDamage': false,
        'features': ['ABS', '6 Airbags', 'Lane Watch Camera', 'Cruise Control', 'Keyless Entry', 'Push Start', 'Touchscreen', 'Apple CarPlay', 'Android Auto', 'Rear Camera'],
      },
      // 3. Mitsubishi Montero Sport - Popular 7-seater SUV
      {
        'brand': 'Mitsubishi', 'model': 'Montero Sport', 'variant': 'GLS 4x2 AT', 'year': 2020,
        'engineSize': '2.4L', 'engineType': EngineType.inline, 'cylinders': 4,
        'horsepower': 181, 'torque': 430, 'transmission': TransmissionType.automatic, 'transmissionSpeeds': 8,
        'driveType': DriveType.rwd, 'fuelType': FuelType.diesel, 'fuelConsumption': 12.8,
        'bodyType': BodyType.suv, 'doors': 5, 'seats': 7,
        'curbWeight': 2150, 'grossWeight': 2850, 'cargoCapacity': 1580, 'groundClearance': 218,
        'length': 4785, 'width': 1815, 'height': 1835, 'wheelbase': 2800,
        'color': 'Black', 'paintType': PaintType.solid, 'rimSize': 18, 'rimType': RimType.alloy,
        'tireCondition': TireCondition.fair, 'condition': CarCondition.used, 'mileage': 62000,
        'numberOfOwners': 2, 'hasAccidentHistory': false, 'floodDamage': false,
        'features': ['ABS', '7 Airbags', 'Hill Start Assist', 'Parking Sensors', 'Leather Seats', 'Climate Control', 'Touchscreen', 'Bluetooth'],
      },
      // 4. Ford Ranger Raptor - Popular pickup
      {
        'brand': 'Ford', 'model': 'Ranger', 'variant': 'Raptor 2.0L Bi-Turbo 4x4 AT', 'year': 2023,
        'engineSize': '2.0L', 'engineType': EngineType.inline, 'cylinders': 4,
        'horsepower': 213, 'torque': 500, 'transmission': TransmissionType.automatic, 'transmissionSpeeds': 10,
        'driveType': DriveType.fourWd, 'fuelType': FuelType.diesel, 'fuelConsumption': 9.8,
        'bodyType': BodyType.pickup, 'doors': 4, 'seats': 5,
        'curbWeight': 2220, 'grossWeight': 3180, 'cargoCapacity': 1200, 'groundClearance': 283,
        'length': 5362, 'width': 2180, 'height': 1884, 'wheelbase': 3220,
        'color': 'Blue', 'paintType': PaintType.metallic, 'rimSize': 17, 'rimType': RimType.alloy,
        'tireCondition': TireCondition.newTires, 'condition': CarCondition.almostNew, 'mileage': 8500,
        'numberOfOwners': 1, 'hasAccidentHistory': false, 'floodDamage': false,
        'features': ['ABS', 'Multiple Airbags', 'Terrain Management System', 'Cruise Control', 'Leather Seats', 'SYNC 3 Touchscreen', 'Apple CarPlay', 'Android Auto', 'B&O Sound System'],
      },
      // 5. Mazda CX-5 - Premium crossover
      {
        'brand': 'Mazda', 'model': 'CX-5', 'variant': 'AWD Sport', 'year': 2022,
        'engineSize': '2.5L', 'engineType': EngineType.inline, 'cylinders': 4,
        'horsepower': 190, 'torque': 252, 'transmission': TransmissionType.automatic, 'transmissionSpeeds': 6,
        'driveType': DriveType.awd, 'fuelType': FuelType.gasoline, 'fuelConsumption': 13.0,
        'bodyType': BodyType.crossover, 'doors': 5, 'seats': 5,
        'curbWeight': 1620, 'grossWeight': 2070, 'cargoCapacity': 442, 'groundClearance': 210,
        'length': 4575, 'width': 1842, 'height': 1685, 'wheelbase': 2700,
        'color': 'Red', 'paintType': PaintType.metallic, 'rimSize': 19, 'rimType': RimType.alloy,
        'tireCondition': TireCondition.good, 'condition': CarCondition.almostNew, 'mileage': 12000,
        'numberOfOwners': 1, 'hasAccidentHistory': false, 'floodDamage': false,
        'features': ['ABS', '6 Airbags', 'Blind Spot Monitor', 'Rear Cross Traffic Alert', 'Adaptive Cruise Control', 'Lane Keep Assist', 'Leather Seats', 'Power Seats', 'Bose Sound System', '10.25-inch Touchscreen', 'Apple CarPlay', 'Android Auto', 'Head-Up Display'],
      },
      // 6. Toyota Wigo - Budget hatchback
  {
    'brand': 'Toyota', 'model': 'Wigo', 'variant': '1.0 G AT', 'year': 2023,
    'engineSize': '1.0L', 'engineType': EngineType.inline, 'cylinders': 3,
    'horsepower': 66, 'torque': 89, 'transmission': TransmissionType.automatic, 'transmissionSpeeds': 4,
    'driveType': DriveType.fwd, 'fuelType': FuelType.gasoline, 'fuelConsumption': 20.5,
    'bodyType': BodyType.hatchback, 'doors': 5, 'seats': 5,
    'curbWeight': 870, 'grossWeight': 1240, 'cargoCapacity': 260, 'groundClearance': 160,
    'length': 3760, 'width': 1665, 'height': 1515, 'wheelbase': 2455,
    'color': 'Yellow', 'paintType': PaintType.solid, 'rimSize': 14, 'rimType': RimType.steel,
    'tireCondition': TireCondition.newTires, 'condition': CarCondition.brandNew, 'mileage': 50,
    'numberOfOwners': 0, 'hasAccidentHistory': false, 'floodDamage': false,
    'features': ['Airbags', 'ABS', 'Bluetooth', 'Rear Camera'],
  },

  // 7. Suzuki Swift - Compact hatchback
  {
    'brand': 'Suzuki', 'model': 'Swift', 'variant': 'GLX CVT', 'year': 2022,
    'engineSize': '1.2L', 'engineType': EngineType.inline, 'cylinders': 4,
    'horsepower': 82, 'torque': 113, 'transmission': TransmissionType.cvt, 'transmissionSpeeds': 0,
    'driveType': DriveType.fwd, 'fuelType': FuelType.gasoline, 'fuelConsumption': 19.2,
    'bodyType': BodyType.hatchback, 'doors': 5, 'seats': 5,
    'curbWeight': 875, 'grossWeight': 1300, 'cargoCapacity': 265, 'groundClearance': 145,
    'length': 3840, 'width': 1735, 'height': 1495, 'wheelbase': 2450,
    'color': 'Red', 'paintType': PaintType.metallic, 'rimSize': 16, 'rimType': RimType.alloy,
    'tireCondition': TireCondition.good, 'condition': CarCondition.almostNew, 'mileage': 12000,
    'numberOfOwners': 1, 'hasAccidentHistory': false, 'floodDamage': false,
    'features': ['ABS', 'Dual Airbags', 'Touchscreen', 'Apple CarPlay', 'Android Auto'],
  },

  // 8. Honda Brio RS - Subcompact hatchback
  {
    'brand': 'Honda', 'model': 'Brio', 'variant': 'RS 1.2 CVT', 'year': 2023,
    'engineSize': '1.2L', 'engineType': EngineType.inline, 'cylinders': 4,
    'horsepower': 89, 'torque': 110, 'transmission': TransmissionType.cvt, 'transmissionSpeeds': 0,
    'driveType': DriveType.fwd, 'fuelType': FuelType.gasoline, 'fuelConsumption': 20.0,
    'bodyType': BodyType.hatchback, 'doors': 5, 'seats': 5,
    'curbWeight': 970, 'grossWeight': 1350, 'cargoCapacity': 258, 'groundClearance': 150,
    'length': 3815, 'width': 1680, 'height': 1485, 'wheelbase': 2405,
    'color': 'Orange', 'paintType': PaintType.pearlescent, 'rimSize': 15, 'rimType': RimType.alloy,
    'tireCondition': TireCondition.newTires, 'condition': CarCondition.brandNew, 'mileage': 200,
    'numberOfOwners': 0, 'hasAccidentHistory': false, 'floodDamage': false,
    'features': ['ABS', 'Airbags', 'Touchscreen', 'Bluetooth', 'Rear Camera'],
  },

  // 9. Nissan Almera - Turbo sedan
  {
    'brand': 'Nissan', 'model': 'Almera', 'variant': 'VL Turbo CVT', 'year': 2022,
    'engineSize': '1.0L Turbo', 'engineType': EngineType.inline, 'cylinders': 3,
    'horsepower': 99, 'torque': 152, 'transmission': TransmissionType.cvt, 'transmissionSpeeds': 0,
    'driveType': DriveType.fwd, 'fuelType': FuelType.gasoline, 'fuelConsumption': 18.8,
    'bodyType': BodyType.sedan, 'doors': 4, 'seats': 5,
    'curbWeight': 1090, 'grossWeight': 1510, 'cargoCapacity': 474, 'groundClearance': 135,
    'length': 4495, 'width': 1740, 'height': 1460, 'wheelbase': 2620,
    'color': 'Gray', 'paintType': PaintType.metallic, 'rimSize': 16, 'rimType': RimType.alloy,
    'tireCondition': TireCondition.good, 'condition': CarCondition.used, 'mileage': 24000,
    'numberOfOwners': 1, 'hasAccidentHistory': false, 'floodDamage': false,
    'features': ['ABS', '6 Airbags', '360 Camera', 'Cruise Control', 'Apple CarPlay', 'Android Auto'],
  },

  // 10. MG 5 - Affordable compact sedan
  {
    'brand': 'MG', 'model': '5', 'variant': 'Alpha CVT', 'year': 2021,
    'engineSize': '1.5L', 'engineType': EngineType.inline, 'cylinders': 4,
    'horsepower': 112, 'torque': 150, 'transmission': TransmissionType.cvt, 'transmissionSpeeds': 0,
    'driveType': DriveType.fwd, 'fuelType': FuelType.gasoline, 'fuelConsumption': 17.5,
    'bodyType': BodyType.sedan, 'doors': 4, 'seats': 5,
    'curbWeight': 1185, 'grossWeight': 1600, 'cargoCapacity': 512, 'groundClearance': 130,
    'length': 4601, 'width': 1818, 'height': 1489, 'wheelbase': 2680,
    'color': 'White', 'paintType': PaintType.solid, 'rimSize': 16, 'rimType': RimType.alloy,
    'tireCondition': TireCondition.good, 'condition': CarCondition.used, 'mileage': 32000,
    'numberOfOwners': 2, 'hasAccidentHistory': false, 'floodDamage': false,
    'features': ['ABS', 'Dual Airbags', 'Touchscreen', 'Apple CarPlay', 'Android Auto'],
  },

  // 11. Geely Emgrand - Budget compact sedan
  {
    'brand': 'Geely', 'model': 'Emgrand', 'variant': 'Premium', 'year': 2023,
    'engineSize': '1.5L', 'engineType': EngineType.inline, 'cylinders': 4,
    'horsepower': 102, 'torque': 142, 'transmission': TransmissionType.cvt, 'transmissionSpeeds': 0,
    'driveType': DriveType.fwd, 'fuelType': FuelType.gasoline, 'fuelConsumption': 18.2,
    'bodyType': BodyType.sedan, 'doors': 4, 'seats': 5,
    'curbWeight': 1200, 'grossWeight': 1600, 'cargoCapacity': 500, 'groundClearance': 130,
    'length': 4638, 'width': 1822, 'height': 1460, 'wheelbase': 2650,
    'color': 'Blue', 'paintType': PaintType.metallic, 'rimSize': 16, 'rimType': RimType.alloy,
    'tireCondition': TireCondition.newTires, 'condition': CarCondition.almostNew, 'mileage': 8000,
    'numberOfOwners': 1, 'hasAccidentHistory': false, 'floodDamage': false,
    'features': ['ABS', 'Airbags', 'Cruise Control', 'Touchscreen', 'Bluetooth', 'Rear Camera'],
  },

  // 12. Toyota Corolla Cross - Hybrid crossover
  {
    'brand': 'Toyota', 'model': 'Corolla Cross', 'variant': '1.8V Hybrid', 'year': 2023,
    'engineSize': '1.8L', 'engineType': EngineType.inline, 'cylinders': 4,
    'horsepower': 122, 'torque': 142, 'transmission': TransmissionType.cvt, 'transmissionSpeeds': 0,
    'driveType': DriveType.fwd, 'fuelType': FuelType.hybrid, 'fuelConsumption': 23.0,
    'bodyType': BodyType.crossover, 'doors': 5, 'seats': 5,
    'curbWeight': 1385, 'grossWeight': 1840, 'cargoCapacity': 487, 'groundClearance': 161,
    'length': 4460, 'width': 1825, 'height': 1620, 'wheelbase': 2640,
    'color': 'White Pearl', 'paintType': PaintType.pearlescent, 'rimSize': 18, 'rimType': RimType.alloy,
    'tireCondition': TireCondition.newTires, 'condition': CarCondition.brandNew, 'mileage': 120,
    'numberOfOwners': 0, 'hasAccidentHistory': false, 'floodDamage': false,
    'features': ['ABS', '7 Airbags', 'Toyota Safety Sense', 'Adaptive Cruise Control', 'Lane Keep Assist', 'Apple CarPlay', 'Android Auto'],
  },

  // 13. Honda HR-V - Compact crossover
  {
    'brand': 'Honda', 'model': 'HR-V', 'variant': 'V Turbo CVT', 'year': 2022,
    'engineSize': '1.5L Turbo', 'engineType': EngineType.inline, 'cylinders': 4,
    'horsepower': 177, 'torque': 240, 'transmission': TransmissionType.cvt, 'transmissionSpeeds': 0,
    'driveType': DriveType.fwd, 'fuelType': FuelType.gasoline, 'fuelConsumption': 14.5,
    'bodyType': BodyType.crossover, 'doors': 5, 'seats': 5,
    'curbWeight': 1320, 'grossWeight': 1800, 'cargoCapacity': 437, 'groundClearance': 181,
    'length': 4340, 'width': 1790, 'height': 1590, 'wheelbase': 2610,
    'color': 'Silver', 'paintType': PaintType.metallic, 'rimSize': 17, 'rimType': RimType.alloy,
    'tireCondition': TireCondition.good, 'condition': CarCondition.almostNew, 'mileage': 15000,
    'numberOfOwners': 1, 'hasAccidentHistory': false, 'floodDamage': false,
    'features': ['ABS', '6 Airbags', 'Honda Sensing', 'Adaptive Cruise Control', 'Lane Watch Camera', 'Touchscreen'],
  },

  // 14. Geely Coolray - Sporty crossover
  {
    'brand': 'Geely', 'model': 'Coolray', 'variant': 'Sport', 'year': 2022,
    'engineSize': '1.5L Turbo', 'engineType': EngineType.inline, 'cylinders': 3,
    'horsepower': 177, 'torque': 255, 'transmission': TransmissionType.dct, 'transmissionSpeeds': 7,
    'driveType': DriveType.fwd, 'fuelType': FuelType.gasoline, 'fuelConsumption': 15.0,
    'bodyType': BodyType.crossover, 'doors': 5, 'seats': 5,
    'curbWeight': 1330, 'grossWeight': 1820, 'cargoCapacity': 330, 'groundClearance': 196,
    'length': 4330, 'width': 1800, 'height': 1609, 'wheelbase': 2600,
    'color': 'White', 'paintType': PaintType.metallic, 'rimSize': 18, 'rimType': RimType.alloy,
    'tireCondition': TireCondition.good, 'condition': CarCondition.used, 'mileage': 22000,
    'numberOfOwners': 1, 'hasAccidentHistory': false, 'floodDamage': false,
    'features': ['ABS', '6 Airbags', 'Panoramic Sunroof', '360 Camera', 'Auto Park Assist', 'Touchscreen'],
  },

  // 15. Toyota Fortuner - 7-seater SUV
  {
    'brand': 'Toyota', 'model': 'Fortuner', 'variant': '2.4 G AT', 'year': 2021,
    'engineSize': '2.4L', 'engineType': EngineType.inline, 'cylinders': 4,
    'horsepower': 150, 'torque': 400, 'transmission': TransmissionType.automatic, 'transmissionSpeeds': 6,
    'driveType': DriveType.rwd, 'fuelType': FuelType.diesel, 'fuelConsumption': 12.0,
    'bodyType': BodyType.suv, 'doors': 5, 'seats': 7,
    'curbWeight': 2050, 'grossWeight': 2750, 'cargoCapacity': 1600, 'groundClearance': 193,
    'length': 4795, 'width': 1855, 'height': 1835, 'wheelbase': 2745,
    'color': 'White', 'paintType': PaintType.solid, 'rimSize': 17, 'rimType': RimType.alloy,
    'tireCondition': TireCondition.fair, 'condition': CarCondition.used, 'mileage': 58000,
    'numberOfOwners': 2, 'hasAccidentHistory': false, 'floodDamage': false,
    'features': ['ABS', '7 Airbags', 'Cruise Control', 'Parking Sensors', 'Touchscreen', 'Bluetooth'],
  },

  // 16. Isuzu MU-X - Diesel SUV
  {
    'brand': 'Isuzu', 'model': 'MU-X', 'variant': 'LS-A 4x2 AT', 'year': 2020,
    'engineSize': '3.0L', 'engineType': EngineType.inline, 'cylinders': 4,
    'horsepower': 190, 'torque': 450, 'transmission': TransmissionType.automatic, 'transmissionSpeeds': 6,
    'driveType': DriveType.rwd, 'fuelType': FuelType.diesel, 'fuelConsumption': 12.5,
    'bodyType': BodyType.suv, 'doors': 5, 'seats': 7,
    'curbWeight': 2100, 'grossWeight': 2800, 'cargoCapacity': 1600, 'groundClearance': 235,
    'length': 4825, 'width': 1860, 'height': 1825, 'wheelbase': 2845,
    'color': 'Silver', 'paintType': PaintType.metallic, 'rimSize': 18, 'rimType': RimType.alloy,
    'tireCondition': TireCondition.fair, 'condition': CarCondition.used, 'mileage': 65000,
    'numberOfOwners': 2, 'hasAccidentHistory': false, 'floodDamage': false,
    'features': ['ABS', '6 Airbags', 'Hill Descent Control', 'Cruise Control', 'Touchscreen'],
  },

  // 17. Nissan Terra - Diesel SUV
  {
    'brand': 'Nissan', 'model': 'Terra', 'variant': 'VL 4x4 AT', 'year': 2022,
    'engineSize': '2.5L', 'engineType': EngineType.inline, 'cylinders': 4,
    'horsepower': 190, 'torque': 450, 'transmission': TransmissionType.automatic, 'transmissionSpeeds': 7,
    'driveType': DriveType.fourWd, 'fuelType': FuelType.diesel, 'fuelConsumption': 11.8,
    'bodyType': BodyType.suv, 'doors': 5, 'seats': 7,
    'curbWeight': 2230, 'grossWeight': 2900, 'cargoCapacity': 1700, 'groundClearance': 225,
    'length': 4900, 'width': 1865, 'height': 1835, 'wheelbase': 2850,
    'color': 'Gray', 'paintType': PaintType.metallic, 'rimSize': 18, 'rimType': RimType.alloy,
    'tireCondition': TireCondition.good, 'condition': CarCondition.almostNew, 'mileage': 18000,
    'numberOfOwners': 1, 'hasAccidentHistory': false, 'floodDamage': false,
        'features': ['ABS', '6 Airbags', 'Around View Monitor', 'Blind Spot Warning', 'Rear Cross Traffic Alert', 'Leather Seats', 'Cruise Control', 'Apple CarPlay', 'Android Auto'],
  },

  // 18. Toyota Hilux - Reliable pickup
  {
    'brand': 'Toyota', 'model': 'Hilux', 'variant': 'Conquest 2.8 4x4 AT', 'year': 2023,
    'engineSize': '2.8L', 'engineType': EngineType.inline, 'cylinders': 4,
    'horsepower': 201, 'torque': 500, 'transmission': TransmissionType.automatic, 'transmissionSpeeds': 6,
    'driveType': DriveType.fourWd, 'fuelType': FuelType.diesel, 'fuelConsumption': 10.5,
    'bodyType': BodyType.pickup, 'doors': 4, 'seats': 5,
    'curbWeight': 2160, 'grossWeight': 3050, 'cargoCapacity': 1000, 'groundClearance': 279,
    'length': 5325, 'width': 1855, 'height': 1815, 'wheelbase': 3085,
    'color': 'White Pearl', 'paintType': PaintType.pearlescent, 'rimSize': 18, 'rimType': RimType.alloy,
    'tireCondition': TireCondition.newTires, 'condition': CarCondition.almostNew, 'mileage': 9500,
    'numberOfOwners': 1, 'hasAccidentHistory': false, 'floodDamage': false,
    'features': ['ABS', '7 Airbags', 'Cruise Control', 'Hill Start Assist', 'Touchscreen', 'Rear Camera', 'Apple CarPlay', 'Android Auto'],
  },

  // 19. Isuzu D-Max - Workhorse pickup
  {
    'brand': 'Isuzu', 'model': 'D-Max', 'variant': 'LS-E 4x4 AT', 'year': 2023,
    'engineSize': '3.0L', 'engineType': EngineType.inline, 'cylinders': 4,
    'horsepower': 190, 'torque': 450, 'transmission': TransmissionType.automatic, 'transmissionSpeeds': 6,
    'driveType': DriveType.fourWd, 'fuelType': FuelType.diesel, 'fuelConsumption': 10.8,
    'bodyType': BodyType.pickup, 'doors': 4, 'seats': 5,
    'curbWeight': 2200, 'grossWeight': 3100, 'cargoCapacity': 1100, 'groundClearance': 240,
    'length': 5275, 'width': 1870, 'height': 1790, 'wheelbase': 3125,
    'color': 'Orange', 'paintType': PaintType.metallic, 'rimSize': 18, 'rimType': RimType.alloy,
    'tireCondition': TireCondition.newTires, 'condition': CarCondition.brandNew, 'mileage': 80,
    'numberOfOwners': 0, 'hasAccidentHistory': false, 'floodDamage': false,
    'features': ['ABS', '6 Airbags', 'Hill Descent Control', 'Cruise Control', 'Touchscreen', 'Apple CarPlay', 'Android Auto'],
  },

  // 20. Nissan Navara - Lifestyle pickup
  {
    'brand': 'Nissan', 'model': 'Navara', 'variant': 'PRO-4X 4x4 AT', 'year': 2022,
    'engineSize': '2.5L', 'engineType': EngineType.inline, 'cylinders': 4,
    'horsepower': 187, 'torque': 450, 'transmission': TransmissionType.automatic, 'transmissionSpeeds': 7,
    'driveType': DriveType.fourWd, 'fuelType': FuelType.diesel, 'fuelConsumption': 11.2,
    'bodyType': BodyType.pickup, 'doors': 4, 'seats': 5,
    'curbWeight': 2150, 'grossWeight': 3050, 'cargoCapacity': 1050, 'groundClearance': 225,
    'length': 5260, 'width': 1850, 'height': 1855, 'wheelbase': 3150,
    'color': 'Stealth Gray', 'paintType': PaintType.matte, 'rimSize': 17, 'rimType': RimType.forged,
    'tireCondition': TireCondition.good, 'condition': CarCondition.almostNew, 'mileage': 14500,
    'numberOfOwners': 1, 'hasAccidentHistory': false, 'floodDamage': false,
    'features': ['ABS', '7 Airbags', 'Rear Differential Lock', '360 Camera', 'Cruise Control', 'Touchscreen', 'Android Auto', 'Apple CarPlay'],
  },

  // 21. Honda Civic - Premium sedan
  {
    'brand': 'Honda', 'model': 'Civic', 'variant': 'RS Turbo CVT', 'year': 2023,
    'engineSize': '1.5L Turbo', 'engineType': EngineType.inline, 'cylinders': 4,
    'horsepower': 176, 'torque': 240, 'transmission': TransmissionType.cvt, 'transmissionSpeeds': 0,
    'driveType': DriveType.fwd, 'fuelType': FuelType.gasoline, 'fuelConsumption': 15.2,
    'bodyType': BodyType.sedan, 'doors': 4, 'seats': 5,
    'curbWeight': 1350, 'grossWeight': 1850, 'cargoCapacity': 497, 'groundClearance': 134,
    'length': 4678, 'width': 1802, 'height': 1415, 'wheelbase': 2735,
    'color': 'Sonic Gray Pearl', 'paintType': PaintType.pearlescent, 'rimSize': 18, 'rimType': RimType.alloy,
    'tireCondition': TireCondition.newTires, 'condition': CarCondition.brandNew, 'mileage': 300,
    'numberOfOwners': 0, 'hasAccidentHistory': false, 'floodDamage': false,
    'features': ['ABS', '6 Airbags', 'Honda Sensing', 'Adaptive Cruise Control', 'Lane Keep Assist', 'Wireless Charging', 'Apple CarPlay', 'Android Auto'],
  },

  // 22. Subaru Forester - Boxer engine SUV
  {
    'brand': 'Subaru', 'model': 'Forester', 'variant': '2.0i-L EyeSight', 'year': 2022,
    'engineSize': '2.0L', 'engineType': EngineType.boxer, 'cylinders': 4,
    'horsepower': 154, 'torque': 196, 'transmission': TransmissionType.cvt, 'transmissionSpeeds': 0,
    'driveType': DriveType.awd, 'fuelType': FuelType.gasoline, 'fuelConsumption': 13.5,
    'bodyType': BodyType.suv, 'doors': 5, 'seats': 5,
    'curbWeight': 1565, 'grossWeight': 2100, 'cargoCapacity': 505, 'groundClearance': 220,
    'length': 4625, 'width': 1815, 'height': 1730, 'wheelbase': 2670,
    'color': 'Dark Green', 'paintType': PaintType.metallic, 'rimSize': 17, 'rimType': RimType.alloy,
    'tireCondition': TireCondition.good, 'condition': CarCondition.used, 'mileage': 28000,
    'numberOfOwners': 1, 'hasAccidentHistory': false, 'floodDamage': false,
    'features': ['ABS', '7 Airbags', 'EyeSight Driver Assist', 'Adaptive Cruise Control', 'All-Wheel Drive', 'Touchscreen'],
  },

  // 23. Toyota Camry - Executive hybrid sedan
  {
    'brand': 'Toyota', 'model': 'Camry', 'variant': '2.5V Hybrid', 'year': 2023,
    'engineSize': '2.5L', 'engineType': EngineType.inline, 'cylinders': 4,
    'horsepower': 211, 'torque': 221, 'transmission': TransmissionType.cvt, 'transmissionSpeeds': 0,
    'driveType': DriveType.fwd, 'fuelType': FuelType.hybrid, 'fuelConsumption': 21.0,
    'bodyType': BodyType.sedan, 'doors': 4, 'seats': 5,
    'curbWeight': 1620, 'grossWeight': 2100, 'cargoCapacity': 524, 'groundClearance': 140,
    'length': 4885, 'width': 1840, 'height': 1445, 'wheelbase': 2825,
    'color': 'Black', 'paintType': PaintType.pearlescent, 'rimSize': 18, 'rimType': RimType.alloy,
    'tireCondition': TireCondition.newTires, 'condition': CarCondition.brandNew, 'mileage': 150,
    'numberOfOwners': 0, 'hasAccidentHistory': false, 'floodDamage': false,
    'features': ['ABS', '7 Airbags', 'Toyota Safety Sense', 'Leather Seats', 'Adaptive Cruise Control', 'Apple CarPlay', 'Android Auto'],
  },

  // 24. BYD Dolphin - Electric hatchback
  {
    'brand': 'BYD', 'model': 'Dolphin', 'variant': 'Dynamic EV', 'year': 2024,
    'engineSize': 'Electric', 'engineType': EngineType.electric, 'cylinders': 0,
    'horsepower': 94, 'torque': 180, 'transmission': TransmissionType.automatic, 'transmissionSpeeds': 1,
    'driveType': DriveType.fwd, 'fuelType': FuelType.electric, 'fuelConsumption': 0.0,
    'bodyType': BodyType.hatchback, 'doors': 5, 'seats': 5,
    'curbWeight': 1450, 'grossWeight': 1900, 'cargoCapacity': 345, 'groundClearance': 145,
    'length': 4125, 'width': 1770, 'height': 1570, 'wheelbase': 2700,
    'color': 'Sky Blue', 'paintType': PaintType.pearlescent, 'rimSize': 16, 'rimType': RimType.alloy,
    'tireCondition': TireCondition.newTires, 'condition': CarCondition.brandNew, 'mileage': 25,
    'numberOfOwners': 0, 'hasAccidentHistory': false, 'floodDamage': false,
    'features': ['ABS', 'Airbags', '360 Camera', 'Adaptive Cruise Control', 'Touchscreen', 'Apple CarPlay', 'Android Auto', 'Fast Charging'],
  },

  // 25. Nissan Leaf - Electric hatchback
  {
    'brand': 'Nissan', 'model': 'Leaf', 'variant': '40kWh EV', 'year': 2022,
    'engineSize': 'Electric', 'engineType': EngineType.electric, 'cylinders': 0,
    'horsepower': 147, 'torque': 320, 'transmission': TransmissionType.automatic, 'transmissionSpeeds': 1,
    'driveType': DriveType.fwd, 'fuelType': FuelType.electric, 'fuelConsumption': 0.0,
    'bodyType': BodyType.hatchback, 'doors': 5, 'seats': 5,
    'curbWeight': 1550, 'grossWeight': 1990, 'cargoCapacity': 435, 'groundClearance': 155,
    'length': 4490, 'width': 1788, 'height': 1540, 'wheelbase': 2700,
    'color': 'White', 'paintType': PaintType.pearlescent, 'rimSize': 17, 'rimType': RimType.alloy,
    'tireCondition': TireCondition.good, 'condition': CarCondition.almostNew, 'mileage': 8500,
    'numberOfOwners': 1, 'hasAccidentHistory': false, 'floodDamage': false,
    'features': ['ABS', '6 Airbags', 'e-Pedal', 'ProPILOT Assist', 'Apple CarPlay', 'Android Auto', 'Fast Charging'],
  },
];

    final cars = <CarModel>[];
    for (int i = 0; i < carData.length; i++) {
      final data = carData[i];
      cars.add(CarModel(
        id: 'car_$i',
        sellerId: 'seller_${i % 5}',
        sellerName: 'Seller ${i % 5}',
        brand: data['brand'] as String,
        model: data['model'] as String,
        variant: data['variant'] as String,
        year: data['year'] as int,
        engineSize: data['engineSize'] as String,
        engineType: data['engineType'] as EngineType,
        cylinders: data['cylinders'] as int,
        horsepower: data['horsepower'] as int,
        torque: data['torque'] as int,
        transmission: data['transmission'] as TransmissionType,
        transmissionSpeeds: data['transmissionSpeeds'] as int,
        driveType: data['driveType'] as DriveType,
        fuelType: data['fuelType'] as FuelType,
        fuelConsumption: data['fuelConsumption'] as double,
        bodyType: data['bodyType'] as BodyType,
        doors: data['doors'] as int,
        seats: data['seats'] as int,
        curbWeight: data['curbWeight'] as int,
        grossWeight: data['grossWeight'] as int,
        cargoCapacity: data['cargoCapacity'] as int,
        groundClearance: data['groundClearance'] as int,
        length: data['length'] as int,
        width: data['width'] as int,
        height: data['height'] as int,
        wheelbase: data['wheelbase'] as int,
        color: data['color'] as String,
        paintType: data['paintType'] as PaintType,
        rimSize: data['rimSize'] as int,
        rimType: data['rimType'] as RimType,
        tireCondition: data['tireCondition'] as TireCondition,
        condition: data['condition'] as CarCondition,
        mileage: data['mileage'] as int,
        numberOfOwners: data['numberOfOwners'] as int,
        hasAccidentHistory: data['hasAccidentHistory'] as bool,
        floodDamage: data['floodDamage'] as bool,
        serviceHistoryComplete: i % 2 == 0,
        warrantyRemaining: i % 3 == 0,
        plateNumber: 'ABC${1000 + i}',
        orcrNumber: 'ORCR${1000 + i}',
        registrationStatus: RegistrationStatus.current,
        emissionTestValid: true,
        comprehensiveInsurance: i % 2 == 0,
        location: CarLocation(
          city: ['Manila', 'Quezon City', 'Makati', 'Cebu', 'Davao'][i % 5],
          province: ['Metro Manila', 'Metro Manila', 'Metro Manila', 'Cebu', 'Davao del Sur'][i % 5],
        ),
        availableForTestDrive: i % 2 == 0,
        deliveryAvailable: i % 3 == 0,
        acceptsTrade: i % 4 == 0,
        financingAvailable: i % 2 == 0,
        priceNegotiable: true,
        description: 'Well-maintained ${data['brand']} ${data['model']} ${data['variant']}. ${data['features'] != null ? "Features include: ${(data['features'] as List<String>).join(", ")}." : ""}',
        features: data['features'] as List<String>? ?? [],
        images: ['https://via.placeholder.com/800x600?text=${data['brand']}+${data['model']}'],
        categorizedImages: {
          'exterior': [
            // Front views
            'https://via.placeholder.com/800x600/4285F4/FFFFFF?text=Front+View',
            'https://via.placeholder.com/800x600/4285F4/FFFFFF?text=Front+3-4+Driver',
            'https://via.placeholder.com/800x600/4285F4/FFFFFF?text=Front+3-4+Passenger',
            // Side views
            'https://via.placeholder.com/800x600/4285F4/FFFFFF?text=Side+Driver',
            'https://via.placeholder.com/800x600/4285F4/FFFFFF?text=Side+Passenger',
            // Rear views
            'https://via.placeholder.com/800x600/4285F4/FFFFFF?text=Rear+3-4+Driver',
            'https://via.placeholder.com/800x600/4285F4/FFFFFF?text=Rear+3-4+Passenger',
            'https://via.placeholder.com/800x600/4285F4/FFFFFF?text=Rear+View',
            // Detail shots
            'https://via.placeholder.com/800x600/4285F4/FFFFFF?text=Front+Bumper',
            'https://via.placeholder.com/800x600/4285F4/FFFFFF?text=Rear+Bumper',
            'https://via.placeholder.com/800x600/4285F4/FFFFFF?text=Wheels+FL',
            'https://via.placeholder.com/800x600/4285F4/FFFFFF?text=Wheels+FR',
            'https://via.placeholder.com/800x600/4285F4/FFFFFF?text=Wheels+RL',
            'https://via.placeholder.com/800x600/4285F4/FFFFFF?text=Wheels+RR',
            'https://via.placeholder.com/800x600/4285F4/FFFFFF?text=Roof+View',
          ],
          'interior': [
            'https://via.placeholder.com/800x600/34A853/FFFFFF?text=Dashboard+Full',
            'https://via.placeholder.com/800x600/34A853/FFFFFF?text=Steering+Wheel',
            'https://via.placeholder.com/800x600/34A853/FFFFFF?text=Instrument+Cluster',
            'https://via.placeholder.com/800x600/34A853/FFFFFF?text=Center+Console',
            'https://via.placeholder.com/800x600/34A853/FFFFFF?text=Front+Seat+Driver',
            'https://via.placeholder.com/800x600/34A853/FFFFFF?text=Front+Seat+Passenger',
            'https://via.placeholder.com/800x600/34A853/FFFFFF?text=Rear+Seats',
            'https://via.placeholder.com/800x600/34A853/FFFFFF?text=Cargo+Trunk',
            'https://via.placeholder.com/800x600/34A853/FFFFFF?text=Headliner',
            'https://via.placeholder.com/800x600/34A853/FFFFFF?text=Door+Panel+Driver',
            'https://via.placeholder.com/800x600/34A853/FFFFFF?text=Door+Panel+Passenger',
            'https://via.placeholder.com/800x600/34A853/FFFFFF?text=Gear+Shifter',
          ],
          'engine': [
            'https://via.placeholder.com/800x600/FBBC04/FFFFFF?text=Engine+Bay+Full',
            'https://via.placeholder.com/800x600/FBBC04/FFFFFF?text=Engine+Close-up',
            'https://via.placeholder.com/800x600/FBBC04/FFFFFF?text=VIN+Plate',
            'https://via.placeholder.com/800x600/FBBC04/FFFFFF?text=Odometer',
            'https://via.placeholder.com/800x600/FBBC04/FFFFFF?text=Undercarriage',
            'https://via.placeholder.com/800x600/FBBC04/FFFFFF?text=Suspension',
          ],
          'details': [
            'https://via.placeholder.com/800x600/EA4335/FFFFFF?text=Paint+Condition',
            'https://via.placeholder.com/800x600/EA4335/FFFFFF?text=Tire+Tread+FL',
            'https://via.placeholder.com/800x600/EA4335/FFFFFF?text=Tire+Tread+FR',
            'https://via.placeholder.com/800x600/EA4335/FFFFFF?text=Tire+Tread+RL',
            'https://via.placeholder.com/800x600/EA4335/FFFFFF?text=Tire+Tread+RR',
            'https://via.placeholder.com/800x600/EA4335/FFFFFF?text=Headlights',
            'https://via.placeholder.com/800x600/EA4335/FFFFFF?text=Tail+Lights',
            'https://via.placeholder.com/800x600/EA4335/FFFFFF?text=Interior+Wear',
            'https://via.placeholder.com/800x600/EA4335/FFFFFF?text=Carpet+Condition',
            'https://via.placeholder.com/800x600/EA4335/FFFFFF?text=Infotainment',
            'https://via.placeholder.com/800x600/EA4335/FFFFFF?text=Service+Stickers',
            'https://via.placeholder.com/800x600/EA4335/FFFFFF?text=Registration',
            'https://via.placeholder.com/800x600/EA4335/FFFFFF?text=Service+History',
          ],
        },
        status: ListingStatus.active,
        createdAt: now.subtract(Duration(days: i)),
        updatedAt: now,
      ));
    }
    return cars;
  }

  void _generateMockAuctions() {
    final now = DateTime.now();
    final random = Random();

    // Get diverse car data - use fallback generation since MockCarService methods are private
    _availableCars = _generateFallbackCars();

    final durations = [
      Duration(minutes: 1),
      Duration(minutes: 5),
      Duration(minutes: 10),
      Duration(minutes: 20),
      // Duration(hours: 5),
      // Duration(days: 1),
      // Duration(days: 3),
    ];

    final basePrices = [150000.0, 250000.0, 350000.0, 500000.0, 750000.0, 1200000.0];

    // Create auctions for all available cars
    for (int i = 0; i < _availableCars.length; i++) {
      final car = _availableCars[i];
      final endTime = now.add(durations[random.nextInt(durations.length)]);

      // Generate prices based on car year and condition
      final basePrice = basePrices[random.nextInt(basePrices.length)];
      final startingPrice = basePrice * 0.7;
      final reservePrice = basePrice * 0.9;
      final buyNowPrice = random.nextBool() ? basePrice * 1.1 : null;

      final totalBids = random.nextInt(20);
      final currentBid = startingPrice + (totalBids * BidIncrements.minimumIncrement * (1 + random.nextInt(3)));

      final auction = Auction(
        id: 'auction_$i',
        carId: car.id,
        sellerId: 'seller_${random.nextInt(5)}',
        startingPrice: startingPrice,
        currentBid: currentBid,
        reservePrice: reservePrice,
        buyNowPrice: buyNowPrice,
        startTime: now.subtract(Duration(hours: random.nextInt(24))),
        endTime: endTime,
        status: AuctionStatus.live,
        totalBids: totalBids,
        topBidderId: totalBids > 0 ? 'user_${random.nextInt(10)}' : null,
        topBidderName: totalBids > 0 ? 'Bidder ${random.nextInt(100)}' : null,
        watchers: List.generate(random.nextInt(15), (i) => 'user_$i'),
        createdAt: now.subtract(Duration(days: random.nextInt(7))),
        updatedAt: now,
        car: car, // Attach actual car data
      );

      _auctions.add(auction);

      // Generate initial bids
      for (int j = 0; j < totalBids; j++) {
        final bidAmount = startingPrice + ((j + 1) * BidIncrements.minimumIncrement * (1 + random.nextInt(3)));
        _bids.add(Bid(
          id: 'bid_${i}_$j',
          auctionId: auction.id,
          bidderId: 'user_${random.nextInt(10)}',
          bidderName: 'Bidder ${random.nextInt(100)}',
          amount: bidAmount,
          isAutoBid: random.nextBool(),
          timestamp: now.subtract(Duration(minutes: (totalBids - j) * 5)),
          status: j == totalBids - 1 ? BidStatus.winning : BidStatus.outbid,
        ));
      }
    }

    _notifyListeners();
  }

  /// Generate mock bids for the demo user
  ///
  /// Creates a realistic bidding history:
  /// - 3 active bids (2 winning, 1 outbid)
  /// - 2 won auctions
  /// - 1 lost auction
  /// - 3 watchlist items
  void _generateMockUserBids() {
    final userId = AppConfig.demoUserId;
    final now = DateTime.now();
    final liveAuctions = _auctions.where((a) => a.status == AuctionStatus.live).toList();

    if (liveAuctions.length < 6) return;

    // 1. Create 2 winning bids
    for (int i = 0; i < 2; i++) {
      final auction = liveAuctions[i];
      final bidAmount = auction.currentBid + BidIncrements.minimumIncrement;

      // Update previous winning bid to outbid
      for (int j = 0; j < _bids.length; j++) {
        final bid = _bids[j];
        if (bid.auctionId == auction.id && bid.status == BidStatus.winning) {
          _bids[j] = bid.copyWith(status: BidStatus.outbid);
        }
      }

      _bids.add(Bid(
        id: 'bid_demo_winning_$i',
        auctionId: auction.id,
        bidderId: userId,
        bidderName: 'You',
        amount: bidAmount,
        isAutoBid: false,
        timestamp: now.subtract(Duration(minutes: 30 + i * 10)),
        status: BidStatus.winning,
      ));

      // Update auction
      final auctionIndex = _auctions.indexWhere((a) => a.id == auction.id);
      _auctions[auctionIndex] = auction.copyWith(
        currentBid: bidAmount,
        totalBids: auction.totalBids + 1,
        topBidderId: userId,
        topBidderName: 'You',
        updatedAt: now,
      );
    }

    // 2. Create 1 outbid bid
    final outbidAuction = liveAuctions[2];
    final userOutbidAmount = outbidAuction.currentBid - BidIncrements.minimumIncrement;

    _bids.add(Bid(
      id: 'bid_demo_outbid',
      auctionId: outbidAuction.id,
      bidderId: userId,
      bidderName: 'You',
      amount: userOutbidAmount,
      isAutoBid: false,
      timestamp: now.subtract(Duration(hours: 2)),
      status: BidStatus.outbid,
    ));

    // 3. Create 2 won auctions
    for (int i = 0; i < 2; i++) {
      // Use extra cars from the pool if available
      CarModel? wonCar;
      if (_availableCars.length > 15 + i) {
        wonCar = _availableCars[15 + i];
      }

      final soldAuction = Auction(
        id: 'auction_demo_won_$i',
        carId: wonCar?.id ?? 'car_demo_won_$i',
        sellerId: 'seller_demo',
        startingPrice: 200000.0,
        currentBid: 250000.0 + (i * 50000),
        reservePrice: 240000.0,
        startTime: now.subtract(Duration(days: 7 + i)),
        endTime: now.subtract(Duration(days: i + 1)),
        status: AuctionStatus.sold,
        totalBids: 12 + i * 3,
        topBidderId: userId,
        topBidderName: 'You',
        watchers: [],
        createdAt: now.subtract(Duration(days: 8 + i)),
        updatedAt: now.subtract(Duration(days: i + 1)),
        car: wonCar,
      );

      _auctions.add(soldAuction);

      _bids.add(Bid(
        id: 'bid_demo_won_$i',
        auctionId: soldAuction.id,
        bidderId: userId,
        bidderName: 'You',
        amount: soldAuction.currentBid,
        isAutoBid: false,
        timestamp: soldAuction.endTime.subtract(Duration(minutes: 5)),
        status: BidStatus.won,
      ));
    }

    // 4. Create 1 lost auction
    CarModel? lostCar;
    if (_availableCars.length > 17) {
      lostCar = _availableCars[17];
    }

    final lostAuction = Auction(
      id: 'auction_demo_lost',
      carId: lostCar?.id ?? 'car_demo_lost',
      sellerId: 'seller_demo',
      startingPrice: 300000.0,
      currentBid: 380000.0,
      reservePrice: 350000.0,
      startTime: now.subtract(Duration(days: 5)),
      endTime: now.subtract(Duration(days: 2)),
      status: AuctionStatus.sold,
      totalBids: 18,
      topBidderId: 'other_user',
      topBidderName: 'Other Bidder',
      watchers: [],
      createdAt: now.subtract(Duration(days: 6)),
      updatedAt: now.subtract(Duration(days: 2)),
      car: lostCar,
    );

    _auctions.add(lostAuction);

    _bids.add(Bid(
      id: 'bid_demo_lost',
      auctionId: lostAuction.id,
      bidderId: userId,
      bidderName: 'You',
      amount: 370000.0,
      isAutoBid: false,
      timestamp: lostAuction.endTime.subtract(Duration(hours: 3)),
      status: BidStatus.lost,
    ));

    // 5. Add 3 watchlist items (no bids)
    for (int i = 3; i < 6; i++) {
      final auction = liveAuctions[i];
      final auctionIndex = _auctions.indexWhere((a) => a.id == auction.id);

      _auctions[auctionIndex] = auction.copyWith(
        watchers: [...auction.watchers, userId],
      );
    }
  }

  void _startSimulation() {
    _simulationTimer = Timer.periodic(Duration(seconds: 15), (timer) {
      _simulateRealTimeBids();
    });
  }

  void _startStatusUpdates() {
    _statusUpdateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateAuctionStatuses();
    });
  }

  void _simulateRealTimeBids() {
    final random = Random();
    final liveAuctions = _auctions.where((a) => a.status == AuctionStatus.live).toList();

    if (liveAuctions.isEmpty) return;

    final auction = liveAuctions[random.nextInt(liveAuctions.length)];
    final bidAmount = auction.currentBid + BidIncrements.minimumIncrement * (1 + random.nextInt(3));

    _placeBidInternal(auction.id, bidAmount, 'simulated_user_${random.nextInt(20)}', 'Simulated Bidder ${random.nextInt(100)}');
  }

  void _updateAuctionStatuses() {
    final now = DateTime.now();
    bool updated = false;

    for (int i = 0; i < _auctions.length; i++) {
      final auction = _auctions[i];

      if (auction.status == AuctionStatus.live && now.isAfter(auction.endTime)) {
        final newStatus = auction.currentBid >= auction.reservePrice
            ? AuctionStatus.sold
            : AuctionStatus.ended;

        _auctions[i] = auction.copyWith(
          status: newStatus,
          updatedAt: now,
        );

        // Update bid statuses
        for (int j = 0; j < _bids.length; j++) {
          final bid = _bids[j];
          if (bid.auctionId == auction.id) {
            if (bid.status == BidStatus.winning) {
              _bids[j] = bid.copyWith(
                status: newStatus == AuctionStatus.sold ? BidStatus.won : BidStatus.lost,
              );
            } else if (bid.status == BidStatus.active || bid.status == BidStatus.outbid) {
              _bids[j] = bid.copyWith(status: BidStatus.lost);
            }
          }
        }

        updated = true;
      }
    }

    if (updated) {
      _notifyListeners();
    }
  }

  @override
  List<Auction> getActiveAuctions() {
    return _auctions.where((a) =>
      a.status == AuctionStatus.live || a.status == AuctionStatus.upcoming
    ).toList()..sort((a, b) => a.endTime.compareTo(b.endTime));
  }

  @override
  Auction? getAuctionById(String id) {
    try {
      return _auctions.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> placeBid({
    required String auctionId,
    required String userId,
    required double amount,
  }) async {
    return _placeBidInternal(auctionId, amount, userId);
  }

  bool _placeBidInternal(String auctionId, double amount, String userId, [String? userName]) {
    final auction = getAuctionById(auctionId);
    if (auction == null || auction.status != AuctionStatus.live) return false;

    final minBid = auction.currentBid + BidIncrements.minimumIncrement;
    if (amount < minBid) return false;

    final now = DateTime.now();
    final bidderName = userName ?? 'Bidder ${Random().nextInt(100)}';

    // Update previous winning bid to outbid
    for (int i = 0; i < _bids.length; i++) {
      final bid = _bids[i];
      if (bid.auctionId == auctionId && bid.status == BidStatus.winning) {
        _bids[i] = bid.copyWith(status: BidStatus.outbid);
      }
    }

    // Add new bid
    final newBid = Bid(
      id: 'bid_${auctionId}_${_bids.length}',
      auctionId: auctionId,
      bidderId: userId,
      bidderName: bidderName,
      amount: amount,
      isAutoBid: false,
      timestamp: now,
      status: BidStatus.winning,
    );

    _bids.add(newBid);

    // Update auction
    final auctionIndex = _auctions.indexWhere((a) => a.id == auctionId);
    _auctions[auctionIndex] = auction.copyWith(
      currentBid: amount,
      totalBids: auction.totalBids + 1,
      topBidderId: userId,
      topBidderName: bidderName,
      updatedAt: now,
    );

    _notifyListeners();
    return true;
  }

  @override
  List<Bid> getAuctionBids(String auctionId) {
    return _bids
        .where((b) => b.auctionId == auctionId)
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  @override
  Bid? getUserBid(String auctionId, String userId) {
    final bids = _bids
        .where((b) => b.auctionId == auctionId && b.bidderId == userId)
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return bids.isNotEmpty ? bids.first : null;
  }

  @override
  BidStatus? getUserBidStatus(String auctionId, String userId) {
    final bid = getUserBid(auctionId, userId);
    return bid?.status;
  }

  @override
  double? getUserBidAmount(String auctionId, String userId) {
    final bid = getUserBid(auctionId, userId);
    return bid?.amount;
  }

  void setupAutoBid(String auctionId, String userId, AutoBidConfig config) {
    _autoBidConfigs['${auctionId}_$userId'] = config;
  }

  AutoBidConfig? getAutoBidConfig(String auctionId, String userId) {
    return _autoBidConfigs['${auctionId}_$userId'];
  }

  @override
  Future<bool> enableAutoBid({
    required String auctionId,
    required String userId,
    required double maxAmount,
  }) async {
    final config = AutoBidConfig(
      maxBidAmount: maxAmount,
      incrementAmount: BidIncrements.minimumIncrement,
      isActive: true,
    );
    _autoBidConfigs['${auctionId}_$userId'] = config;
    return true;
  }

  @override
  Future<bool> disableAutoBid({
    required String auctionId,
    required String userId,
  }) async {
    _autoBidConfigs.remove('${auctionId}_$userId');
    return true;
  }

  @override
  Future<bool> addToWatchlist({
    required String auctionId,
    required String userId,
  }) async {
    final auctionIndex = _auctions.indexWhere((a) => a.id == auctionId);
    if (auctionIndex == -1) return false;

    final auction = _auctions[auctionIndex];
    if (auction.watchers.contains(userId)) return true;

    _auctions[auctionIndex] = auction.copyWith(
      watchers: [...auction.watchers, userId],
    );

    _notifyListeners();
    return true;
  }

  @override
  Future<bool> removeFromWatchlist({
    required String auctionId,
    required String userId,
  }) async {
    final auctionIndex = _auctions.indexWhere((a) => a.id == auctionId);
    if (auctionIndex == -1) return false;

    final auction = _auctions[auctionIndex];
    _auctions[auctionIndex] = auction.copyWith(
      watchers: auction.watchers.where((id) => id != userId).toList(),
    );

    _notifyListeners();
    return true;
  }

  @override
  bool isInWatchlist(String auctionId, String userId) {
    final auction = getAuctionById(auctionId);
    return auction?.watchers.contains(userId) ?? false;
  }

  void watchAuction(String auctionId, String userId) {
    addToWatchlist(auctionId: auctionId, userId: userId);
  }

  void unwatchAuction(String auctionId, String userId) {
    removeFromWatchlist(auctionId: auctionId, userId: userId);
  }

  List<Bid> getUserBids(String userId) {
    return _bids
        .where((b) => b.bidderId == userId)
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  @override
  List<Auction> getUserActiveAuctions(String userId) {
    final userBidAuctionIds = getUserBids(userId)
        .where((b) => b.status == BidStatus.winning || b.status == BidStatus.outbid || b.status == BidStatus.active)
        .map((b) => b.auctionId)
        .toSet();

    return _auctions
        .where((a) => userBidAuctionIds.contains(a.id) && a.status == AuctionStatus.live)
        .toList()
      ..sort((a, b) => a.endTime.compareTo(b.endTime));
  }

  @override
  List<Auction> getUserWonAuctions(String userId) {
    return _auctions
        .where((a) => a.status == AuctionStatus.sold && a.topBidderId == userId)
        .toList()
      ..sort((a, b) => b.endTime.compareTo(a.endTime));
  }

  @override
  List<Auction> getUserLostAuctions(String userId) {
    final userBidAuctionIds = getUserBids(userId)
        .where((b) => b.status == BidStatus.lost)
        .map((b) => b.auctionId)
        .toSet();

    return _auctions
        .where((a) => userBidAuctionIds.contains(a.id) &&
                     (a.status == AuctionStatus.ended || a.status == AuctionStatus.sold) &&
                     a.topBidderId != userId)
        .toList()
      ..sort((a, b) => b.endTime.compareTo(a.endTime));
  }

  @override
  List<Auction> getUserWatchlist(String userId) {
    final userBidAuctionIds = getUserBids(userId).map((b) => b.auctionId).toSet();

    return _auctions
        .where((a) => a.watchers.contains(userId) && !userBidAuctionIds.contains(a.id))
        .toList()
      ..sort((a, b) => a.endTime.compareTo(b.endTime));
  }

  void _notifyListeners() {
    _auctionStreamController.add(List.from(_auctions));

    final bidsByAuction = <String, List<Bid>>{};
    for (final bid in _bids) {
      bidsByAuction.putIfAbsent(bid.auctionId, () => []).add(bid);
    }
    _bidStreamController.add(bidsByAuction);
  }

  Auction createAuction({
    required String carId,
    required String sellerId,
    required double startingPrice,
    required double reservePrice,
    required int durationDays,
    double? buyNowPrice,
    CarModel? car,
    double? customListingFee, // Optional custom fee, uses default if null
  }) {
    final now = DateTime.now();

    // Calculate listing fee using the pricing calculator
    // Industry standard: ₱300-500 per listing (similar to Copart, Manheim)
    // Default is ₱400 as configured in PricingConfig
    final listingFee = customListingFee ??
        PricingCalculator.withDefaultConfig().calculateListingFee();

    final auction = Auction(
      id: 'auction_${_auctions.length}',
      carId: carId,
      sellerId: sellerId,
      startingPrice: startingPrice,
      currentBid: startingPrice,
      reservePrice: reservePrice,
      buyNowPrice: buyNowPrice,
      startTime: now,
      endTime: now.add(Duration(days: durationDays)),
      status: AuctionStatus.live,
      totalBids: 0,
      watchers: [],
      createdAt: now,
      updatedAt: now,
      car: car,
      // ADDED: Listing fee fields
      listingFee: listingFee,
      listingFeePaid: true, // In demo, assume paid immediately
      listingFeePaidAt: now, // Paid at creation time
    );

    _auctions.add(auction);
    _notifyListeners();

    return auction;
  }
}
