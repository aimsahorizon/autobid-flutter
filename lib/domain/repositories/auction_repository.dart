import '../../data/models/auction_model.dart';
import '../../data/models/bid_model.dart';

/// Abstract repository interface for auction data
///
/// This interface allows switching between mock and real implementations
/// without changing the provider layer.
abstract class AuctionRepository {
  /// Stream of all auctions
  Stream<List<Auction>> get auctionsStream;

  /// Stream of all bids
  Stream<List<Bid>> get bidsStream;

  /// Initialize the repository
  void initialize();

  /// Dispose resources
  void dispose();

  /// Get all auctions
  List<Auction> getAuctions();

  /// Get auction by ID
  Auction? getAuctionById(String id);

  /// Get active auctions only
  List<Auction> getActiveAuctions();

  /// Get user's active auctions (where user has active bids)
  List<Auction> getUserActiveAuctions(String userId);

  /// Get user's won auctions
  List<Auction> getUserWonAuctions(String userId);

  /// Get user's lost auctions
  List<Auction> getUserLostAuctions(String userId);

  /// Get user's watchlist
  List<Auction> getUserWatchlist(String userId);

  /// Get all bids for an auction
  List<Bid> getAuctionBids(String auctionId);

  /// Get user's bid for an auction
  Bid? getUserBid(String auctionId, String userId);

  /// Get user's bid status for an auction
  BidStatus? getUserBidStatus(String auctionId, String userId);

  /// Get user's bid amount for an auction
  double? getUserBidAmount(String auctionId, String userId);

  /// Place a bid
  Future<bool> placeBid({
    required String auctionId,
    required String userId,
    required double amount,
  });

  /// Enable auto-bid
  Future<bool> enableAutoBid({
    required String auctionId,
    required String userId,
    required double maxAmount,
  });

  /// Disable auto-bid
  Future<bool> disableAutoBid({
    required String auctionId,
    required String userId,
  });

  /// Add to watchlist
  Future<bool> addToWatchlist({
    required String auctionId,
    required String userId,
  });

  /// Remove from watchlist
  Future<bool> removeFromWatchlist({
    required String auctionId,
    required String userId,
  });

  /// Check if auction is in watchlist
  bool isInWatchlist(String auctionId, String userId);
}
