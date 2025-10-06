import 'package:freezed_annotation/freezed_annotation.dart';

part 'auto_bid_config.freezed.dart';
part 'auto_bid_config.g.dart';

@freezed
abstract class AutoBidConfig with _$AutoBidConfig {
  const factory AutoBidConfig({
    required double maxBidAmount,
    required double incrementAmount,
    @Default(true) bool isActive,
  }) = _AutoBidConfig;

  factory AutoBidConfig.fromJson(Map<String, dynamic> json) => _$AutoBidConfigFromJson(json);
}
