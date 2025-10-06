import 'dart:async';
import 'dart:math';
import '../../models/auction_model.dart';
import '../../models/bid_model.dart';
import '../../models/auto_bid_config.dart';
import '../../models/car_model.dart';
import '../../../core/constants/bid_increments.dart';
import '../../../config/app_config.dart';
import '../../../domain/repositories/auction_repository.dart';

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
    final brands = ['Toyota', 'Honda', 'Mazda', 'Ford', 'BMW', 'Mercedes-Benz', 'Nissan', 'Hyundai'];
    final models = ['Sedan Model', 'SUV Model', 'Hatchback Model'];
    final colors = ['White', 'Black', 'Silver', 'Red', 'Blue'];
    final cities = ['Manila', 'Quezon City', 'Makati', 'Cebu', 'Davao'];
    final provinces = ['Metro Manila', 'Cebu', 'Davao del Sur'];

    final cars = <CarModel>[];
    for (int i = 0; i < 18; i++) {
      cars.add(CarModel(
        id: 'car_$i',
        sellerId: 'seller_${i % 5}',
        sellerName: 'Seller ${i % 5}',
        brand: brands[i % brands.length],
        model: models[i % models.length],
        variant: 'Standard',
        year: 2015 + (i % 10),
        mileage: 30000 + (i * 10000),
        transmission: TransmissionType.values[i % TransmissionType.values.length],
        fuelType: FuelType.values[i % FuelType.values.length],
        bodyType: BodyType.values[i % BodyType.values.length],
        color: colors[i % colors.length],
        engineSize: '2.0L',
        seats: 5,
        doors: 4,
        plateNumber: 'ABC${1000 + i}',
        orcrNumber: 'ORCR${1000 + i}',
        location: CarLocation(
          city: cities[i % cities.length],
          province: provinces[i % provinces.length],
        ),
        numberOfOwners: 1 + (i % 3),
        serviceHistoryComplete: i % 2 == 0,
        hasAccidentHistory: i % 3 == 0,
        condition: CarCondition.used,
        description: 'Well-maintained ${brands[i % brands.length]} ${models[i % models.length]}',
        images: ['https://via.placeholder.com/400x300?text=${brands[i % brands.length]}'],
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
      Duration(hours: 1),
      Duration(hours: 5),
      Duration(days: 1),
      Duration(days: 3),
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
  }) {
    final now = DateTime.now();
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
    );

    _auctions.add(auction);
    _notifyListeners();

    return auction;
  }
}
