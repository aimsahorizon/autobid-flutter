import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/models/car_model.dart';
import '../../../../data/models/auction_model.dart';
import '../../../../data/services/mock/mock_car_service.dart';
import '../../../../data/services/mock/mock_auction_service.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../widgets/image_carousel.dart';
import '../../../widgets/spec_info_row.dart';

/// Pending Listing Detail Screen
/// Follows auction platform best practices:
/// - Clear pending review status display
/// - Submission timeline and review information
/// - Read-only view of submitted details
/// - Option to withdraw submission
/// - Professional waiting/review messaging
class PendingListingDetailScreen extends StatefulWidget {
  final String carId;

  const PendingListingDetailScreen({super.key, required this.carId});

  @override
  State<PendingListingDetailScreen> createState() => _PendingListingDetailScreenState();
}

class _PendingListingDetailScreenState extends State<PendingListingDetailScreen> {
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
    final startingPrice = _auction?.startingPrice ?? 0;
    final submittedDate = car.createdAt;
    final daysSinceSubmission = DateTime.now().difference(submittedDate).inDays;
    final hoursSinceSubmission = DateTime.now().difference(submittedDate).inHours;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Pending review header with badge
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
                  // Pending overlay
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
                  // Pending badge
                  Positioned(
                    top: 60,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.orange[600],
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
                          Icon(Icons.pending, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'PENDING REVIEW',
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
                // Review status banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.amber[50]!,
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.hourglass_top, color: Colors.orange[700], size: 28),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Under Admin Review',
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange[900],
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Your listing is being reviewed by our team',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Vehicle title and starting price
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
                      // Starting price
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.blue[200]!,
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
                                  'Proposed Starting Bid',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '₱${_formatCurrency(startingPrice)}',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[700],
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.gavel,
                              color: Colors.blue[700],
                              size: 48,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Submission summary
                _buildSectionHeader(context, 'Submission Details'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildInfoRow(
                        'Submitted',
                        daysSinceSubmission == 0
                            ? (hoursSinceSubmission == 0 ? 'Just now' : '$hoursSinceSubmission hour${hoursSinceSubmission == 1 ? '' : 's'} ago')
                            : '$daysSinceSubmission day${daysSinceSubmission == 1 ? '' : 's'} ago',
                      ),
                      _buildInfoRow('Submission Date', _formatDate(submittedDate)),
                      _buildInfoRow('Status', 'Pending Admin Approval'),
                      _buildInfoRow('Expected Review Time', '24-48 hours'),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Review process information
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
                              'What Happens Next?',
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
                          '• Our admin team is reviewing your vehicle details\n'
                          '• We verify all information, photos, and documentation\n'
                          '• You\'ll receive a notification once approved\n'
                          '• If changes are needed, we\'ll contact you\n'
                          '• You can withdraw this submission at any time',
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

                const SizedBox(height: 24),

                // Vehicle specifications
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
                      SpecInfoRow(
                        icon: Icons.palette,
                        label: 'Color',
                        value: car.color,
                      ),
                      SpecInfoRow(
                        icon: Icons.event,
                        label: 'Year',
                        value: car.year.toString(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Vehicle description
                if (car.description.isNotEmpty) ...[
                  _buildSectionHeader(context, 'Description'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      car.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Action buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => _showWithdrawDialog(context, car),
                          icon: const Icon(Icons.cancel_outlined),
                          label: const Text('Withdraw Submission'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red[700],
                            side: BorderSide(color: Colors.red[300]!),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () => context.pop(),
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Back to My Listings'),
                          style: FilledButton.styleFrom(
                            backgroundColor: ColorConstants.primaryGreen,
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

  void _showWithdrawDialog(BuildContext context, CarModel car) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Withdraw Submission?'),
        content: Text(
          'Are you sure you want to withdraw "${car.brand} ${car.model}" from review?\n\n'
          'This will remove it from the admin review queue. You can resubmit it later.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _withdrawListing(car);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Withdraw'),
          ),
        ],
      ),
    );
  }

  void _withdrawListing(CarModel car) {
    // TODO: Implement actual withdrawal logic
    // For now, just show success message and go back
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${car.brand} ${car.model} has been withdrawn from review'),
        backgroundColor: Colors.orange[700],
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            // TODO: Implement undo functionality
          },
        ),
      ),
    );
    context.pop();
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
