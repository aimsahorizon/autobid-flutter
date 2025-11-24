import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

@freezed
abstract class CategoryRating with _$CategoryRating {
  const factory CategoryRating({
    required double communication,
    required double accuracy,
    required double condition,
    required double process,
  }) = _CategoryRating;

  factory CategoryRating.fromJson(Map<String, dynamic> json) =>
      _$CategoryRatingFromJson(json);
}

@freezed
abstract class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    required String id,
    required String transactionId,
    required String buyerId,
    required String sellerId,
    required double overallRating,
    required CategoryRating categoryRatings,
    String? comment,
    required bool isAnonymous,
    required DateTime createdAt,
    String? sellerResponse,
    DateTime? sellerRespondedAt,
    @Default(false) bool isFlagged,
    String? flagReason,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
}
