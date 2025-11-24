import '../../models/review_model.dart';

class MockReviewService {
  static final MockReviewService _instance = MockReviewService._internal();
  factory MockReviewService() => _instance;
  MockReviewService._internal();

  final List<ReviewModel> _reviews = [];

  Future<ReviewModel> submitReview({
    required String transactionId,
    required String buyerId,
    required String sellerId,
    required double overallRating,
    required double communicationRating,
    required double accuracyRating,
    required double conditionRating,
    required double processRating,
    String? comment,
    required bool isAnonymous,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final review = ReviewModel(
      id: 'REV${DateTime.now().millisecondsSinceEpoch}',
      transactionId: transactionId,
      buyerId: buyerId,
      sellerId: sellerId,
      overallRating: overallRating,
      categoryRatings: CategoryRating(
        communication: communicationRating,
        accuracy: accuracyRating,
        condition: conditionRating,
        process: processRating,
      ),
      comment: comment,
      isAnonymous: isAnonymous,
      createdAt: DateTime.now(),
    );

    _reviews.add(review);
    return review;
  }

  Future<List<ReviewModel>> getSellerReviews(String sellerId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _reviews.where((r) => r.sellerId == sellerId).toList();
  }

  Future<ReviewModel?> getReviewByTransaction(String transactionId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _reviews.firstWhere((r) => r.transactionId == transactionId);
    } catch (e) {
      return null;
    }
  }

  Future<bool> flagReview({
    required String reviewId,
    required String reason,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _reviews.indexWhere((r) => r.id == reviewId);
    if (index == -1) return false;

    final review = _reviews[index];
    final flaggedReview = review.copyWith(
      isFlagged: true,
      flagReason: reason,
    );

    _reviews[index] = flaggedReview;
    return true;
  }
}
