// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Auction _$AuctionFromJson(Map<String, dynamic> json) => _Auction(
  id: json['id'] as String,
  carId: json['carId'] as String,
  sellerId: json['sellerId'] as String,
  startingPrice: (json['startingPrice'] as num).toDouble(),
  currentBid: (json['currentBid'] as num).toDouble(),
  reservePrice: (json['reservePrice'] as num).toDouble(),
  buyNowPrice: (json['buyNowPrice'] as num?)?.toDouble(),
  startTime: DateTime.parse(json['startTime'] as String),
  endTime: DateTime.parse(json['endTime'] as String),
  status: $enumDecode(_$AuctionStatusEnumMap, json['status']),
  totalBids: (json['totalBids'] as num?)?.toInt() ?? 0,
  topBidderId: json['topBidderId'] as String?,
  topBidderName: json['topBidderName'] as String?,
  autoBidEnabled: json['autoBidEnabled'] as bool? ?? false,
  watchers:
      (json['watchers'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  car: json['car'] == null
      ? null
      : CarModel.fromJson(json['car'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuctionToJson(_Auction instance) => <String, dynamic>{
  'id': instance.id,
  'carId': instance.carId,
  'sellerId': instance.sellerId,
  'startingPrice': instance.startingPrice,
  'currentBid': instance.currentBid,
  'reservePrice': instance.reservePrice,
  'buyNowPrice': instance.buyNowPrice,
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime.toIso8601String(),
  'status': _$AuctionStatusEnumMap[instance.status]!,
  'totalBids': instance.totalBids,
  'topBidderId': instance.topBidderId,
  'topBidderName': instance.topBidderName,
  'autoBidEnabled': instance.autoBidEnabled,
  'watchers': instance.watchers,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'car': instance.car,
};

const _$AuctionStatusEnumMap = {
  AuctionStatus.upcoming: 'upcoming',
  AuctionStatus.live: 'live',
  AuctionStatus.ended: 'ended',
  AuctionStatus.sold: 'sold',
  AuctionStatus.cancelled: 'cancelled',
};
