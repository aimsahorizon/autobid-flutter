import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_timeline.freezed.dart';
part 'transaction_timeline.g.dart';

@freezed
abstract class TransactionTimeline with _$TransactionTimeline {
  const factory TransactionTimeline({
    required String status,
    required DateTime timestamp,
    required String description,
    required String icon,
  }) = _TransactionTimeline;

  factory TransactionTimeline.fromJson(Map<String, dynamic> json) =>
      _$TransactionTimelineFromJson(json);
}
