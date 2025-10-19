import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../providers/auction_provider.dart';
import '../../../widgets/auction_card.dart';

class WatchlistTab extends StatefulWidget {
  const WatchlistTab({super.key});

  @override
  State<WatchlistTab> createState() => _WatchlistTabState();
}

class _WatchlistTabState extends State<WatchlistTab> {
  @override
  void initState() {
    super.initState();
    // Watchlist is already loaded from AuctionProvider
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final auctionProvider = context.watch<AuctionProvider>();
    final watchlist = auctionProvider.watchlist;

    if (watchlist.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 80,
              color: colorScheme.primary.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'Watchlist',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Your saved cars will appear here',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => auctionProvider.loadAuctions(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: watchlist.length,
        itemBuilder: (context, index) {
          final auction = watchlist[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AuctionCard(
              auction: auction,
              onTap: () => context.push('/auction/${auction.id}'),
            ),
          );
        },
      ),
    );
  }
}
