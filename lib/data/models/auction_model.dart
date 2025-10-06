import 'package:freezed_annotation/freezed_annotation.dart';

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
  }) = _Auction;

  factory Auction.fromJson(Map<String, dynamic> json) => _$AuctionFromJson(json);
}
