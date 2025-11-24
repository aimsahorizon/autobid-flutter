import '../../data/models/auction_model.dart';
import '../constants/bid_increments.dart';

class BidValidator {
  static String? validateBid(double bidAmount, Auction auction) {
    final minBid = auction.currentBid + BidIncrements.minimumIncrement;

    if (bidAmount < minBid) {
      return 'Minimum bid is ₱${_formatCurrency(minBid)}';
    }

    if ((bidAmount - auction.currentBid) % BidIncrements.minimumIncrement != 0) {
      return 'Bid must be in increments of ₱${_formatCurrency(BidIncrements.minimumIncrement)}';
    }

    if (auction.buyNowPrice != null && bidAmount > auction.buyNowPrice!) {
      return 'Bid cannot exceed Buy Now price of ₱${_formatCurrency(auction.buyNowPrice!)}';
    }

    return null;
  }

  static String? validateAutoBid(double maxBid, double currentBid, double? buyNowPrice) {
    if (maxBid <= currentBid) {
      return 'Max bid must be higher than current bid';
    }

    if (buyNowPrice != null && maxBid > buyNowPrice) {
      return 'Max bid cannot exceed Buy Now price';
    }

    return null;
  }

  static double getMinimumBid(Auction auction) {
    return auction.currentBid + BidIncrements.minimumIncrement;
  }

  static String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
