// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bid_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Bid _$BidFromJson(Map<String, dynamic> json) => _Bid(
  id: json['id'] as String,
  auctionId: json['auctionId'] as String,
  bidderId: json['bidderId'] as String,
  bidderName: json['bidderName'] as String,
  amount: (json['amount'] as num).toDouble(),
  isAutoBid: json['isAutoBid'] as bool? ?? false,
  timestamp: DateTime.parse(json['timestamp'] as String),
  status: $enumDecode(_$BidStatusEnumMap, json['status']),
);

Map<String, dynamic> _$BidToJson(_Bid instance) => <String, dynamic>{
  'id': instance.id,
  'auctionId': instance.auctionId,
  'bidderId': instance.bidderId,
  'bidderName': instance.bidderName,
  'amount': instance.amount,
  'isAutoBid': instance.isAutoBid,
  'timestamp': instance.timestamp.toIso8601String(),
  'status': _$BidStatusEnumMap[instance.status]!,
};

const _$BidStatusEnumMap = {
  BidStatus.active: 'active',
  BidStatus.outbid: 'outbid',
  BidStatus.winning: 'winning',
  BidStatus.won: 'won',
  BidStatus.lost: 'lost',
};
