import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../providers/auction_provider.dart';
import '../../../widgets/auction_card.dart';

class BrowseTab extends StatefulWidget {
  final bool isGridView;

  const BrowseTab({super.key, required this.isGridView});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<AuctionProvider>().loadAuctions();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final auctionProvider = context.watch<AuctionProvider>();
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: () => auctionProvider.loadAuctions(),
      child: auctionProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : auctionProvider.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(auctionProvider.error!),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () => auctionProvider.loadAuctions(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : auctionProvider.activeAuctions.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.gavel,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No auctions found',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'No auctions available at the moment',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    )
                  : widget.isGridView
                      ? GridView.builder(
                          padding: const EdgeInsets.all(16),
                          cacheExtent: 500.0, // Cache 2 screens ahead
                          addAutomaticKeepAlives: false, // Reduce memory
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: auctionProvider.activeAuctions.length,
                          itemBuilder: (context, index) {
                            final auction = auctionProvider.activeAuctions[index];
                            return AuctionCard(
                              key: ValueKey(auction.id), // Preserve state
                              auction: auction,
                              onTap: () => context.push('/auction/${auction.id}'),
                            );
                          },
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          cacheExtent: 500.0, // Cache 2 screens ahead
                          addAutomaticKeepAlives: false, // Reduce memory
                          itemCount: auctionProvider.activeAuctions.length,
                          itemBuilder: (context, index) {
                            final auction = auctionProvider.activeAuctions[index];
                            return Padding(
                              key: ValueKey(auction.id), // Preserve state
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
