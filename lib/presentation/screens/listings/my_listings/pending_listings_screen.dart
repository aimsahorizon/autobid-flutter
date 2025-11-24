import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/car_model.dart';
import '../../../../core/utils/listing_status_extensions.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/car_card.dart';

/// Screen displaying user's pending listings awaiting admin approval
///
/// Backend Integration:
/// - Fetch pending listings: GET /api/listings?userId={id}&status=pending_review
/// - Real-time updates via WebSocket when admin approves/rejects
/// - Pull-to-refresh for manual updates
class PendingListingsScreen extends StatefulWidget {
  const PendingListingsScreen({super.key});

  @override
  State<PendingListingsScreen> createState() => _PendingListingsScreenState();
}

class _PendingListingsScreenState extends State<PendingListingsScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPendingListings();
  }

  Future<void> _loadPendingListings() async {
    setState(() => _isLoading = true);

    // TODO: Replace with actual API call
    // await context.read<ListingProvider>().fetchUserListings(
    //   status: ListingStatus.pendingReview,
    // );

    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _isLoading = false);
  }

  Future<void> _onRefresh() async {
    await _loadPendingListings();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();

    // Filter pending listings (temporary - will be done server-side)
    final pendingListings = provider.myListings
        .where((listing) => listing.status == ListingStatus.pendingReview)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Listings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfoDialog(context),
            tooltip: 'About Pending Listings',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _onRefresh,
              child: pendingListings.isEmpty
                  ? _buildEmptyState()
                  : _buildPendingList(pendingListings),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pending_actions_outlined,
              size: 120,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 24),
            Text(
              'No Pending Listings',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your submitted listings will appear here while waiting for admin approval.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.add),
              label: const Text('Create New Listing'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingList(List<CarModel> listings) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: listings.length + 1, // +1 for header
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildHeader(listings.length);
        }

        final listing = listings[index - 1];
        return _buildPendingListingCard(listing);
      },
    );
  }

  Widget _buildHeader(int count) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(ListingStatus.pendingReview.colorValue).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(ListingStatus.pendingReview.colorValue).withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(ListingStatus.pendingReview.colorValue),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              ListingStatus.pendingReview.iconEmoji,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$count Listing${count == 1 ? '' : 's'} Pending',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Awaiting admin review and approval',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingListingCard(CarModel listing) {
    final daysSinceSubmission = DateTime.now().difference(listing.createdAt).inDays;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          CarCard(
            car: listing,
            onTap: () {
              // TODO: Navigate to preview
            },
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Colors.orange.shade700,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    daysSinceSubmission == 0
                        ? 'Submitted today'
                        : 'Submitted $daysSinceSubmission day${daysSinceSubmission == 1 ? '' : 's'} ago',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.orange.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => _showListingActions(context, listing),
                  child: const Text('Options'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showListingActions(BuildContext context, CarModel listing) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Listing'),
              subtitle: const Text('Make changes before approval'),
              enabled: listing.status.canEdit,
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to edit listing
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit functionality coming soon')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.visibility),
              title: const Text('Preview'),
              subtitle: const Text('See how it will look'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to listing preview
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Preview functionality coming soon')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel, color: Colors.red),
              title: const Text('Cancel Submission'),
              subtitle: const Text('Remove from review queue'),
              enabled: listing.status.canCancel,
              onTap: () {
                Navigator.pop(context);
                _confirmCancelListing(context, listing);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmCancelListing(BuildContext context, CarModel listing) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Listing?'),
        content: Text(
          'Are you sure you want to cancel "${listing.brand} ${listing.model}"?\n\n'
          'This will remove it from the review queue. You can resubmit it later.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Keep It'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _cancelListing(listing);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Cancel Listing'),
          ),
        ],
      ),
    );
  }

  void _cancelListing(CarModel listing) {
    // TODO: API call to cancel listing
    // await listingService.updateListingStatus(
    //   listingId: listing.id,
    //   status: ListingStatus.cancelled,
    // );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${listing.brand} ${listing.model} has been cancelled'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // TODO: Implement undo functionality
          },
        ),
      ),
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.info_outline, color: Colors.orange),
            SizedBox(width: 12),
            Text('Pending Listings'),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'About the Review Process:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                '• All listings must be approved by our admin team before going live\n\n'
                '• Review typically takes 24-48 hours\n\n'
                '• Admins verify vehicle information, photos, and documentation\n\n'
                '• You\'ll be notified once your listing is approved or if changes are needed\n\n'
                '• You can edit or cancel pending listings at any time',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}
