import 'package:freezed_annotation/freezed_annotation.dart';
import 'car_model.dart';

part 'auction_model.freezed.dart';
part 'auction_model.g.dart';

enum AuctionStatus {
  @JsonValue('upcoming')
  upcoming,
  @JsonValue('live')
  live,
  @JsonValue('ended')
  ended,
  @JsonValue('sold')
  sold,
  @JsonValue('cancelled')
  cancelled,
}

@freezed
abstract class Auction with _$Auction {
  const factory Auction({
    required String id,
    required String carId,
    required String sellerId,
    required double startingPrice,
    required double currentBid,
    required double reservePrice,
    double? buyNowPrice,
    required DateTime startTime,
    required DateTime endTime,
    required AuctionStatus status,
    @Default(0) int totalBids,
    String? topBidderId,
    String? topBidderName,
    @Default(false) bool autoBidEnabled,
    @Default([]) List<String> watchers,
    required DateTime createdAt,
    required DateTime updatedAt,
    CarModel? car,

    // ===== EXTENDED: Listing Fee =====
    /// Listing fee charged to seller when creating this auction (PHP 300-500)
    /// This is a fixed upfront fee covering operational costs:
    /// - Platform hosting and bandwidth
    /// - Image storage and processing
    /// - Auction management overhead
    ///
    /// Industry reference: Similar to Copart ($59-$189), Manheim ($75-$300)
    /// Default value of 400 PHP aligns with mid-tier industry standards
    @Default(400.0) double listingFee,

    /// Whether the listing fee has been paid by the seller
    /// In production, this would be tracked through payment gateway
    @Default(false) bool listingFeePaid,

    /// When the listing fee was paid (if applicable)
    DateTime? listingFeePaidAt,
  }) = _Auction;

  factory Auction.fromJson(Map<String, dynamic> json) => _$AuctionFromJson(json);
}
