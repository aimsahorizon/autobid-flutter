import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/car_model.dart';
import '../../../../data/models/auction_model.dart';
import '../../../../data/services/mock/mock_car_service.dart';
import '../../../../data/services/mock/mock_auction_service.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../widgets/image_carousel.dart';
import '../../../widgets/spec_info_row.dart';
import '../../../providers/listing_provider.dart';

/// Cancelled Listing Detail Screen
/// Follows e-commerce best practices for inactive listings:
/// - Clear cancelled status indication
/// - Historical listing information
/// - Prominent reactivation options
/// - Easy access to delete or reauction
/// - Suggestions for improvement before relisting
class CancelledListingDetailScreen extends StatefulWidget {
  final String carId;

  const CancelledListingDetailScreen({super.key, required this.carId});

  @override
  State<CancelledListingDetailScreen> createState() => _CancelledListingDetailScreenState();
}

class _CancelledListingDetailScreenState extends State<CancelledListingDetailScreen> {
  final MockCarService _carService = MockCarService();
  final MockAuctionService _auctionService = MockAuctionService();
  CarModel? _car;
  Auction? _auction;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final car = await _carService.getCarById(widget.carId);
    final auction = car != null ? _auctionService.getAuctionByCarId(widget.carId) : null;
    setState(() {
      _car = car;
      _auction = auction;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_car == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Listing not found'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    final car = _car!;
    final cancelledDate = DateTime.now().subtract(Duration(days: car.id.hashCode % 60));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Desaturated header with cancelled badge
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.grey.withOpacity(0.3),
                      BlendMode.saturation,
                    ),
                    child: ImageCarousel(
                      images: car.images,
                      height: 300,
                    ),
                  ),
                  // Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                  // Cancelled badge
                  Positioned(
                    top: 60,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.cancel_outlined, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'CANCELLED',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Listing Cancelled',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.grey[200] : Colors.grey[800],
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Cancelled on ${_formatDate(cancelledDate)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                // Vehicle title and original price
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${car.year} ${car.brand} ${car.model}',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        car.variant,
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Original listing price
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[850] : Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Original Starting Price',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '₱${_formatCurrency(_auction?.startingPrice ?? 0)}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.info_outline,
                              color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                              size: 32,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Reactivation action card (primary CTA)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ColorConstants.primary.withOpacity(isDarkMode ? 0.15 : 0.1),
                          cardColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: ColorConstants.primary.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: ColorConstants.primary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.restart_alt,
                                color: ColorConstants.primary,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Ready to Try Again?',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Relist this vehicle with updated details',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: () => _handleReauction(),
                            icon: const Icon(Icons.refresh),
                            label: const Text('Reauction This Listing'),
                            style: FilledButton.styleFrom(
                              backgroundColor: ColorConstants.primary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Listing statistics
                _buildSectionHeader(context, 'Listing Performance'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[850] : Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDarkMode ? Colors.grey[700]! : Colors.grey[200]!,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildStatRow('Total Views', '${car.viewCount}', Icons.visibility, isDarkMode),
                        if (_auction != null) ...[
                          const Divider(height: 24),
                          _buildStatRow('Bids Received', '${_auction!.totalBids}', Icons.gavel, isDarkMode),
                          const Divider(height: 24),
                          _buildStatRow(
                            'Highest Bid',
                            _auction!.totalBids > 0 ? '₱${_formatCurrency(_auction!.currentBid)}' : 'No bids',
                            Icons.trending_up,
                            isDarkMode,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Improvement suggestions
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ColorConstants.info.withOpacity(isDarkMode ? 0.15 : 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: ColorConstants.info.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.lightbulb_outline, color: ColorConstants.info, size: 24),
                            const SizedBox(width: 8),
                            Text(
                              'Tips for Better Results',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.info,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildTip('Consider adjusting your starting price based on market demand', isDarkMode),
                        _buildTip('Add more high-quality photos from different angles', isDarkMode),
                        _buildTip('Provide detailed maintenance and service history', isDarkMode),
                        _buildTip('Highlight unique features and recent upgrades', isDarkMode),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Vehicle specifications (condensed)
                _buildSectionHeader(context, 'Vehicle Details'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SpecInfoRow(
                        icon: Icons.speed,
                        label: 'Mileage',
                        value: '${car.mileage.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} km',
                      ),
                      SpecInfoRow(
                        icon: Icons.settings,
                        label: 'Transmission',
                        value: car.transmission.name.toUpperCase(),
                      ),
                      SpecInfoRow(
                        icon: Icons.local_gas_station,
                        label: 'Fuel Type',
                        value: car.fuelType.name.toUpperCase(),
                      ),
                      SpecInfoRow(
                        icon: Icons.location_on,
                        label: 'Location',
                        value: '${car.location.city}, ${car.location.province}',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Action buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _handleDelete(),
                          icon: const Icon(Icons.delete_outline),
                          label: const Text('Delete Listing'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: ColorConstants.error,
                            side: BorderSide(
                              color: ColorConstants.error.withOpacity(0.5),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () => _handleReauction(),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reauction'),
                          style: FilledButton.styleFrom(
                            backgroundColor: ColorConstants.primary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon, bool isDarkMode) {
    return Row(
      children: [
        Icon(
          icon,
          color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTip(String tip, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: ColorConstants.info, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(
                fontSize: 13,
                color: isDarkMode ? Colors.grey[300] : ColorConstants.info.withOpacity(0.9),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleReauction() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reauction Listing'),
        content: Text(
          'Do you want to reauction "${_car!.brand} ${_car!.model}"?\n\n'
          'You\'ll be able to review and update the listing details before publishing.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: ColorConstants.primary,
            ),
            child: const Text('Continue'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      final provider = context.read<ListingProvider>();
      provider.loadListingForEdit(_car!);
      if (mounted) {
        context.go('/listing/create/step1');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Review and update your listing details'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _handleDelete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Listing'),
        content: Text(
          'Are you sure you want to permanently delete "${_car!.brand} ${_car!.model}"?\n\n'
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: ColorConstants.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      await context.read<ListingProvider>().deleteListing(_car!.id);
      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Listing deleted')),
        );
      }
    }
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
