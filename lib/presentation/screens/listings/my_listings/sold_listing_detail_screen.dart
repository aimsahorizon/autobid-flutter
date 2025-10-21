import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/models/car_model.dart';
import '../../../../data/models/auction_model.dart';
import '../../../../data/services/mock/mock_car_service.dart';
import '../../../../data/services/mock/mock_auction_service.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../widgets/image_carousel.dart';
import '../../../widgets/spec_info_row.dart';

/// Sold Listing Detail Screen
/// Follows auction platform best practices:
/// - Prominent sold status display
/// - Transaction summary and final price
/// - Timeline of auction events
/// - Read-only view with historical data
/// - Professional completion messaging
class SoldListingDetailScreen extends StatefulWidget {
  final String carId;

  const SoldListingDetailScreen({super.key, required this.carId});

  @override
  State<SoldListingDetailScreen> createState() => _SoldListingDetailScreenState();
}

class _SoldListingDetailScreenState extends State<SoldListingDetailScreen> {
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
    final finalPrice = _auction?.currentBid ?? _auction?.startingPrice ?? 0;
    final soldDate = DateTime.now().subtract(Duration(days: car.id.hashCode % 30));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Success header with sold badge
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  ImageCarousel(
                    images: car.images,
                    height: 300,
                  ),
                  // Success overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.transparent,
                          Colors.black.withOpacity(0.5),
                        ],
                      ),
                    ),
                  ),
                  // Sold badge
                  Positioned(
                    top: 60,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: ColorConstants.primaryGreen,
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
                          Icon(Icons.check_circle, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'SOLD',
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
                // Success banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorConstants.primaryGreen.withOpacity(0.1),
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Congratulations!',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.primaryGreen,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Your vehicle has been successfully sold',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),

                // Vehicle title and final price
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
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Final sale price
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: ColorConstants.primaryGreen.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Final Sale Price',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '₱${_formatCurrency(finalPrice)}',
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.primaryGreen,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.check_circle,
                              color: ColorConstants.primaryGreen,
                              size: 48,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Transaction summary
                _buildSectionHeader(context, 'Transaction Summary'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildInfoRow('Sold Date', _formatDate(soldDate)),
                      _buildInfoRow('Starting Bid', '₱${_formatCurrency(_auction?.startingPrice ?? 0)}'),
                      _buildInfoRow('Total Bids', '${_auction?.totalBids ?? 0}'),
                      if (_auction?.buyNowPrice != null)
                        _buildInfoRow('Buy Now Price', '₱${_formatCurrency(_auction!.buyNowPrice!)}'),
                      _buildInfoRow('Auction Duration', _getAuctionDuration()),
                      _buildInfoRow('Views', '${car.viewCount}'),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Buyer information (if available)
                if (_auction?.topBidderName != null) ...[
                  _buildSectionHeader(context, 'Buyer Information'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: ColorConstants.primaryGreen.withOpacity(0.2),
                            child: Icon(
                              Icons.person,
                              color: ColorConstants.primaryGreen,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _auction!.topBidderName!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Winning Bidder',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.verified_user, color: ColorConstants.primaryGreen, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Vehicle specifications (condensed)
                _buildSectionHeader(context, 'Vehicle Specifications'),
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

                // Next steps banner
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline, color: Colors.blue[700]),
                            const SizedBox(width: 8),
                            Text(
                              'What\'s Next?',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '• The buyer will contact you to arrange payment and delivery\n'
                          '• Ensure all documents are ready for transfer\n'
                          '• Coordinate with AutoBID admin for transaction completion\n'
                          '• Payment will be processed through our secure platform',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue[900],
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
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

  String _getAuctionDuration() {
    if (_auction == null) return 'N/A';
    final duration = _auction!.endTime.difference(_auction!.startTime);
    final days = duration.inDays;
    if (days > 0) return '$days day${days > 1 ? 's' : ''}';
    final hours = duration.inHours;
    return '$hours hour${hours > 1 ? 's' : ''}';
  }
}
