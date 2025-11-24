import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auction_provider.dart';
import '../widgets/buyer_comment_section.dart';

/// Questions & Answers Tab
/// Displays Q&A section where buyers can ask questions and sellers can respond
class QuestionsAnswersTab extends StatelessWidget {
  final String auctionId;
  final String sellerId;

  const QuestionsAnswersTab({
    super.key,
    required this.auctionId,
    required this.sellerId,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuctionProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: BuyerCommentSection(
        auctionId: auctionId,
        sellerId: sellerId,
        currentUserId: provider.currentUserId,
      ),
    );
  }
}
