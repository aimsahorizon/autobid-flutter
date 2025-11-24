import 'dart:async';
import 'dart:math';
import '../../models/auction_comment_model.dart';

/// Mock comment service for auction comments
/// Simulates real-time comment functionality with realistic Philippine-context data
class MockCommentService {
  static final MockCommentService _instance = MockCommentService._internal();
  factory MockCommentService() => _instance;
  MockCommentService._internal();

  final Map<String, List<AuctionComment>> _commentsByAuction = {};
  final _commentsController = StreamController<Map<String, List<AuctionComment>>>.broadcast();
  Timer? _simulationTimer;
  int _commentIdCounter = 0;

  Stream<List<AuctionComment>> getCommentsStream(String auctionId) {
    return _commentsController.stream.map((comments) => comments[auctionId] ?? []);
  }

  /// Initialize with mock comments for an auction
  void initializeForAuction(String auctionId, String sellerId) {
    if (_commentsByAuction.containsKey(auctionId)) return;

    _commentsByAuction[auctionId] = _generateMockComments(auctionId, sellerId);
    _notifyListeners();

    // Start simulation for new comments (every 30-60 seconds)
    _startCommentSimulation(auctionId, sellerId);
  }

  /// Get all comments for an auction
  List<AuctionComment> getComments(String auctionId) {
    return _commentsByAuction[auctionId] ?? [];
  }

  /// Get top-level comments (not replies)
  List<AuctionComment> getTopLevelComments(String auctionId) {
    return getComments(auctionId).where((c) => c.parentCommentId == null).toList()
      ..sort((a, b) {
        // Pinned comments first
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        // Then by timestamp (newest first)
        return b.timestamp.compareTo(a.timestamp);
      });
  }

  /// Get replies for a comment
  List<AuctionComment> getReplies(String auctionId, String commentId) {
    return getComments(auctionId)
        .where((c) => c.parentCommentId == commentId)
        .toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp)); // Oldest first for replies
  }

  /// Add a new comment
  Future<AuctionComment> addComment({
    required String auctionId,
    required String authorId,
    required String authorName,
    required String content,
    required bool isSellerComment,
    CommentCategory category = CommentCategory.general,
    String? parentCommentId,
  }) async {
    // Simulate API delay
    await Future.delayed(Duration(milliseconds: 500 + Random().nextInt(500)));

    final comment = AuctionComment(
      id: 'comment_${_commentIdCounter++}',
      auctionId: auctionId,
      authorId: authorId,
      authorName: authorName,
      content: content,
      timestamp: DateTime.now(),
      category: category,
      status: isSellerComment ? CommentStatus.answered : CommentStatus.pending,
      isSellerComment: isSellerComment,
      parentCommentId: parentCommentId,
    );

    _commentsByAuction.putIfAbsent(auctionId, () => []).add(comment);

    // If this is a seller reply, mark parent as answered
    if (isSellerComment && parentCommentId != null) {
      _updateCommentStatus(auctionId, parentCommentId, CommentStatus.answered);
    }

    _notifyListeners();
    return comment;
  }

  /// Toggle pin status for a comment
  Future<bool> togglePin(String auctionId, String commentId) async {
    await Future.delayed(Duration(milliseconds: 200));

    final comments = _commentsByAuction[auctionId];
    if (comments == null) return false;

    final index = comments.indexWhere((c) => c.id == commentId);
    if (index == -1) return false;

    _commentsByAuction[auctionId]![index] = comments[index].copyWith(
      isPinned: !comments[index].isPinned,
    );

    _notifyListeners();
    return true;
  }

  /// Update comment status
  Future<bool> updateCommentStatus(
    String auctionId,
    String commentId,
    CommentStatus status,
  ) async {
    await Future.delayed(Duration(milliseconds: 200));
    return _updateCommentStatus(auctionId, commentId, status);
  }

  bool _updateCommentStatus(
    String auctionId,
    String commentId,
    CommentStatus status,
  ) {
    final comments = _commentsByAuction[auctionId];
    if (comments == null) return false;

    final index = comments.indexWhere((c) => c.id == commentId);
    if (index == -1) return false;

    _commentsByAuction[auctionId]![index] = comments[index].copyWith(
      status: status,
    );

    _notifyListeners();
    return true;
  }

  /// Toggle like on a comment
  Future<bool> toggleLike(String auctionId, String commentId, String userId) async {
    await Future.delayed(Duration(milliseconds: 150));

    final comments = _commentsByAuction[auctionId];
    if (comments == null) return false;

    final index = comments.indexWhere((c) => c.id == commentId);
    if (index == -1) return false;

    final comment = comments[index];
    final likedBy = List<String>.from(comment.likedBy);

    if (likedBy.contains(userId)) {
      likedBy.remove(userId);
    } else {
      likedBy.add(userId);
    }

    _commentsByAuction[auctionId]![index] = comment.copyWith(
      likedBy: likedBy,
      likeCount: likedBy.length,
    );

    _notifyListeners();
    return true;
  }

  /// Delete a comment
  Future<bool> deleteComment(String auctionId, String commentId) async {
    await Future.delayed(Duration(milliseconds: 300));

    final comments = _commentsByAuction[auctionId];
    if (comments == null) return false;

    // Remove the comment and all its replies
    _commentsByAuction[auctionId] = comments.where((c) {
      return c.id != commentId && c.parentCommentId != commentId;
    }).toList();

    _notifyListeners();
    return true;
  }

  void _notifyListeners() {
    _commentsController.add(Map.from(_commentsByAuction));
  }

  void _startCommentSimulation(String auctionId, String sellerId) {
    // Simulate new buyer questions every 30-60 seconds during demo
    _simulationTimer?.cancel();
    _simulationTimer = Timer.periodic(Duration(seconds: 45), (timer) {
      if (Random().nextDouble() > 0.7) {
        // 30% chance of new comment
        _addSimulatedComment(auctionId, sellerId);
      }
    });
  }

  void _addSimulatedComment(String auctionId, String sellerId) {
    final questions = _getRealisticQuestions();
    final random = Random();
    final question = questions[random.nextInt(questions.length)];

    addComment(
      auctionId: auctionId,
      authorId: 'buyer_${random.nextInt(100)}',
      authorName: 'Buyer ${random.nextInt(100)}',
      content: question['content'] as String,
      isSellerComment: false,
      category: question['category'] as CommentCategory,
    );
  }

  List<AuctionComment> _generateMockComments(String auctionId, String sellerId) {
    final now = DateTime.now();
    final comments = <AuctionComment>[];
    final random = Random();

    final mockQuestions = _getRealisticQuestions();

    // Generate 8-12 initial comments
    final commentCount = 8 + random.nextInt(5);

    for (int i = 0; i < commentCount; i++) {
      final question = mockQuestions[i % mockQuestions.length];
      final timestamp = now.subtract(Duration(
        hours: random.nextInt(48),
        minutes: random.nextInt(60),
      ));

      final comment = AuctionComment(
        id: 'comment_${_commentIdCounter++}',
        auctionId: auctionId,
        authorId: 'buyer_$i',
        authorName: question['author'] as String,
        content: question['content'] as String,
        timestamp: timestamp,
        category: question['category'] as CommentCategory,
        status: CommentStatus.pending,
        isSellerComment: false,
        likeCount: random.nextInt(5),
      );

      comments.add(comment);

      // 60% chance seller has already replied
      if (random.nextDouble() > 0.4) {
        final reply = AuctionComment(
          id: 'comment_${_commentIdCounter++}',
          auctionId: auctionId,
          authorId: sellerId,
          authorName: 'You (Seller)',
          content: question['sellerReply'] as String,
          timestamp: timestamp.add(Duration(hours: random.nextInt(3), minutes: random.nextInt(60))),
          category: question['category'] as CommentCategory,
          status: CommentStatus.answered,
          isSellerComment: true,
          parentCommentId: comment.id,
        );

        comments.add(reply);

        // Mark original as answered
        final index = comments.indexWhere((c) => c.id == comment.id);
        if (index != -1) {
          comments[index] = comments[index].copyWith(status: CommentStatus.answered);
        }
      }
    }

    // Add 1-2 pinned important comments
    if (comments.length > 3) {
      comments[0] = comments[0].copyWith(isPinned: true);
    }

    return comments;
  }

  List<Map<String, dynamic>> _getRealisticQuestions() {
    return [
      {
        'author': 'Juan Cruz',
        'category': CommentCategory.mechanical,
        'content': 'Hi! Does the engine have any unusual noises? How is the idle? Any engine light warnings?',
        'sellerReply': 'Hello! The engine runs smoothly with no unusual noises. Idle is steady at around 700 RPM. No check engine lights or warnings. Recent tune-up was done last month with oil change and new spark plugs.',
      },
      {
        'author': 'Maria Santos',
        'category': CommentCategory.cosmetic,
        'content': 'Are there any scratches or dents on the body? How is the paint condition overall?',
        'sellerReply': 'The paint is in excellent condition - 8/10. There are minor swirl marks from regular washing (normal wear) but no deep scratches. Small door ding on driver side (pictured). Overall very clean for the year.',
      },
      {
        'author': 'Pedro Reyes',
        'category': CommentCategory.history,
        'content': 'Complete casa service records available? Any accident history? Flood or insurance claim?',
        'sellerReply': 'Yes, complete casa service records from 2020-2023. No accident history whatsoever. Never flooded, never had insurance claims. Clean title, first owner. Can provide all documentation upon request.',
      },
      {
        'author': 'Antonio Garcia',
        'category': CommentCategory.mechanical,
        'content': 'Transmission shifting smoothly? Any slipping or delay? When was the ATF last changed?',
        'sellerReply': 'Transmission shifts very smoothly, no slipping or delays. ATF was changed at 40,000 km (last year) using genuine Honda ATF-DW1. Shifts are crisp in all gears.',
      },
      {
        'author': 'Carmen Dela Cruz',
        'category': CommentCategory.cosmetic,
        'content': 'Interior condition? Any tears in seats? Dashboard cracks? Aircon working perfectly?',
        'sellerReply': 'Interior is very well-maintained. Leather seats have no tears, minor wear on driver seat bolster (normal). No dashboard cracks. Aircon is ice cold - serviced and recharged 2 months ago.',
      },
      {
        'author': 'Roberto Mendoza',
        'category': CommentCategory.documentation,
        'content': 'OR/CR updated? Registration current? Emission test valid? Ready for transfer?',
        'sellerReply': 'Yes, all documents are current. OR/CR updated this year, registration valid until December 2025. Emission test passed last month. Ready for immediate transfer with complete papers.',
      },
      {
        'author': 'Lisa Tan',
        'category': CommentCategory.mechanical,
        'content': 'Suspension and steering okay? Any clunking sounds over bumps? Recent alignment done?',
        'sellerReply': 'Suspension is in great shape. No clunking or unusual sounds. Drives straight with no pulling. 4-wheel alignment was done 3 months ago. Shocks are still firm.',
      },
      {
        'author': 'Miguel Ramos',
        'category': CommentCategory.shipping,
        'content': 'Where is the unit located? Available for inspection in Metro Manila? Can arrange shipping to Cebu?',
        'sellerReply': 'Unit is located in Quezon City. Available for inspection anytime by appointment. Yes, I can help arrange shipping to Cebu through my trusted cargo forwarder (buyer pays shipping).',
      },
      {
        'author': 'Angela Flores',
        'category': CommentCategory.inspection,
        'content': 'Is PPI welcome? Can I bring my mechanic to check? Willing to bring to casa for inspection?',
        'sellerReply': 'Absolutely! PPI is very welcome. You can bring your trusted mechanic anytime. Also willing to bring to casa for professional inspection if needed (we can split the cost).',
      },
      {
        'author': 'Carlos Bautista',
        'category': CommentCategory.mechanical,
        'content': 'Tire condition and brand? Brake pads life remaining? Battery health? Any recent replacements?',
        'sellerReply': 'Tires are Michelin with 70% tread remaining (around 2 years old). Brake pads front: 60%, rear: 75%. Battery is Motolite (6 months old) still under warranty. Replaced timing belt at 100k km.',
      },
      {
        'author': 'Diana Lopez',
        'category': CommentCategory.general,
        'content': 'Reason for selling? Any known issues I should be aware of? What will I need to replace soon?',
        'sellerReply': 'Upgrading to 7-seater for growing family. No known issues at all. For preventive maintenance, might need new wiper blades soon (₱800). Everything else is in excellent condition.',
      },
      {
        'author': 'Eduardo Silva',
        'category': CommentCategory.history,
        'content': 'Original owner? How many km per year average? Mostly highway or city driving? Garage kept?',
        'sellerReply': 'Yes, original owner since 2020. Averaged 15,000 km/year. Mostly highway (60%) - SLEX trips to Laguna. Always garage-kept at home and covered parking at work.',
      },
      {
        'author': 'Grace Pascual',
        'category': CommentCategory.documentation,
        'content': 'Comprehensive insurance? When does it expire? Is it transferable? Any pending violations?',
        'sellerReply': 'Yes, comprehensive insurance with Malayan. Expires March 2026. Transferable upon request. Zero violations - clean record. Can provide insurance papers.',
      },
      {
        'author': 'Henry Diaz',
        'category': CommentCategory.mechanical,
        'content': 'Any mods or aftermarket parts? All original? Warranty still valid on any components?',
        'sellerReply': 'All 100% original parts. No modifications. Only added OEM-spec floor mats and trunk liner. Still under manufacturer warranty for powertrain until Dec 2025.',
      },
      {
        'author': 'Isabel Morales',
        'category': CommentCategory.cosmetic,
        'content': 'Headlights clear or yellowed? All lights working? Sound system upgraded? Original head unit?',
        'sellerReply': 'Headlights are crystal clear - no yellowing. All lights working perfectly (LED). Sound system is original Honda head unit with Apple CarPlay. Speakers all working great.',
      },
    ];
  }

  void dispose() {
    _simulationTimer?.cancel();
    _commentsController.close();
  }
}
