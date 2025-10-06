import 'package:freezed_annotation/freezed_annotation.dart';

part 'bid_model.freezed.dart';
part 'bid_model.g.dart';

enum BidStatus {
  @JsonValue('active')
  active,
  @JsonValue('outbid')
  outbid,
  @JsonValue('winning')
  winning,
  @JsonValue('won')
  won,
  @JsonValue('lost')
  lost,
}

@freezed
abstract class Bid with _$Bid {
  const factory Bid({
    required String id,
    required String auctionId,
    required String bidderId,
    required String bidderName,
    required double amount,
    @Default(false) bool isAutoBid,
    required DateTime timestamp,
    required BidStatus status,
  }) = _Bid;

  factory Bid.fromJson(Map<String, dynamic> json) => _$BidFromJson(json);
}
