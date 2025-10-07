import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../data/models/car_image_category.dart';
import '../../../../data/models/required_car_images.dart';
import '../../../../core/utils/dev_autofill.dart';
import '../../../../core/utils/listing_autofill_helpers.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/save_draft_button.dart';

class CreateListingStep7Photos extends StatefulWidget {
  const CreateListingStep7Photos({super.key});

  @override
  State<CreateListingStep7Photos> createState() =>
      _CreateListingStep7PhotosState();
}

class _CreateListingStep7PhotosState extends State<CreateListingStep7Photos>
    with SingleTickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(
      ImageSource source, String category, String imageKey) async {
    final provider = context.read<ListingProvider>();

    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        // In production, upload to cloud storage and get URL
        // For now, use mock URL with imageKey identifier
        final imageUrl = 'mock://image_${imageKey}_${DateTime.now().millisecondsSinceEpoch}';
        provider.addCategorizedImage(category, imageUrl);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

  int _getCategoryImageCount(String category, ListingProvider provider) {
    return provider.categorizedImages[category]?.length ?? 0;
  }

  int _getRequiredCount(CarImageCategory category) {
    switch (category) {
      case CarImageCategory.exterior:
        return 15;
      case CarImageCategory.interior:
        return 12;
      case CarImageCategory.engine:
        return 6;
      case CarImageCategory.details:
        return 13;
    }
  }

  List<String> _getRequiredImages(CarImageCategory category) {
    switch (category) {
      case CarImageCategory.exterior:
        return RequiredCarImages.exteriorImages;
      case CarImageCategory.interior:
        return RequiredCarImages.interiorImages;
      case CarImageCategory.engine:
        return RequiredCarImages.engineImages;
      case CarImageCategory.details:
        return RequiredCarImages.detailImages;
    }
  }

  void _autofillForm() {
    Step7AutofillHelper.autofill(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListingProvider>();

    final totalImages = provider.categorizedImages.values
        .fold<int>(0, (sum, list) => sum + list.length);
    const requiredTotal = 46;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos'),
        actions: [
          if (DevAutofill.isEnabled)
            DevAutofill.showAutofillIconButton(
              context: context,
              onAutofill: _autofillForm,
            )!,
          SaveDraftButton(
            stepNumber: 7,
            validateForm: () {
              return provider.validateStep7();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: 7 / 8,
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Step 7 of 8',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Vehicle Photos',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: totalImages >= requiredTotal
                            ? Colors.green.shade50
                            : Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: totalImages >= requiredTotal
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                      child: Text(
                        '$totalImages / $requiredTotal',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: totalImages >= requiredTotal
                              ? Colors.green.shade900
                              : Colors.orange.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Info box
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline,
                          color: Colors.blue.shade700, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'All 46 photos are required for a complete listing. Take clear, well-lit photos from specified angles.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tab Bar
          TabBar(
            controller: _tabController,
            tabs: CarImageCategory.values.map((category) {
              final count = _getCategoryImageCount(category.name, provider);
              final required = _getRequiredCount(category);
              final isComplete = count >= required;

              return Tab(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(category.icon),
                        const SizedBox(width: 4),
                        if (isComplete)
                          const Icon(Icons.check_circle,
                              color: Colors.green, size: 16),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category.displayName,
                      style: const TextStyle(fontSize: 10),
                    ),
                    Text(
                      '$count/$required',
                      style: TextStyle(
                        fontSize: 10,
                        color: isComplete ? Colors.green : Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: CarImageCategory.values.map((category) {
                return _buildCategoryView(category, provider);
              }).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CustomButton(
            text: 'Next',
            onPressed: () {
              if (provider.validateStep7()) {
                context.push('/listing/create/step8');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Please upload all 46 required photos ($totalImages/$requiredTotal completed)'),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryView(
      CarImageCategory category, ListingProvider provider) {
    final requiredImages = _getRequiredImages(category);
    final categoryImages = provider.categorizedImages[category.name] ?? [];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...requiredImages.map((imageKey) {
          final displayName = RequiredCarImages.getImageDisplayName(imageKey);
          final hasImage = categoryImages.any((url) => url.contains(imageKey));

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: hasImage ? Colors.green.shade50 : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: hasImage ? Colors.green : Colors.grey,
                      ),
                    ),
                    child: hasImage
                        ? Icon(Icons.check_circle,
                            color: Colors.green.shade700, size: 30)
                        : Icon(Icons.add_photo_alternate,
                            color: Colors.grey.shade600, size: 30),
                  ),
                  title: Text(
                    displayName,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    hasImage ? 'Photo added' : 'Required',
                    style: TextStyle(
                      color: hasImage ? Colors.green : Colors.orange,
                      fontSize: 12,
                    ),
                  ),
                  trailing: hasImage
                      ? IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            final imageUrl = categoryImages
                                .firstWhere((url) => url.contains(imageKey));
                            provider.removeCategorizedImage(
                                category.name, imageUrl);
                          },
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.camera_alt),
                              onPressed: () => _pickImage(
                                  ImageSource.camera, category.name, imageKey),
                            ),
                            IconButton(
                              icon: const Icon(Icons.photo_library),
                              onPressed: () => _pickImage(
                                  ImageSource.gallery, category.name, imageKey),
                            ),
                          ],
                        ),
                ),
                // Sample Image Section
                if (!hasImage)
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline,
                                size: 16, color: Colors.blue.shade700),
                            const SizedBox(width: 8),
                            Text(
                              'Sample Guide',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Placeholder for sample image
                        Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.grey.shade400, width: 2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_outlined,
                                  size: 40, color: Colors.grey.shade600),
                              const SizedBox(height: 8),
                              Text(
                                'Sample: $displayName',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  _getSampleImageTip(imageKey),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey.shade600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  String _getSampleImageTip(String imageKey) {
    // Provide helpful tips for each image type
    final tips = {
      'front_view': 'Take photo from the center, 3-4 meters away',
      'front_3/4_driver': 'Capture front corner from driver side at 45°',
      'front_3/4_passenger': 'Capture front corner from passenger side at 45°',
      'side_driver': 'Full side view from driver side, parallel to car',
      'side_passenger': 'Full side view from passenger side, parallel to car',
      'rear_3/4_driver': 'Capture rear corner from driver side at 45°',
      'rear_3/4_passenger': 'Capture rear corner from passenger side at 45°',
      'rear_view': 'Take photo from the center, 3-4 meters away',
      'front_bumper': 'Close-up of front bumper showing condition',
      'rear_bumper': 'Close-up of rear bumper showing condition',
      'wheels_front_left': 'Close-up of front left wheel and tire',
      'wheels_front_right': 'Close-up of front right wheel and tire',
      'wheels_rear_left': 'Close-up of rear left wheel and tire',
      'wheels_rear_right': 'Close-up of rear right wheel and tire',
      'roof_view': 'Photo of roof from elevated position',
      'dashboard_full': 'Complete dashboard view from driver seat',
      'steering_wheel': 'Close-up of steering wheel and controls',
      'instrument_cluster': 'Clear view of gauges and displays',
      'center_console': 'Close-up of center console and controls',
      'front_seat_driver': 'Driver seat condition',
      'front_seat_passenger': 'Passenger seat condition',
      'rear_seats': 'Full rear seat view',
      'cargo_trunk': 'Open trunk/cargo area',
      'headliner': 'Interior roof/ceiling condition',
      'door_panel_driver': 'Driver door panel and controls',
      'door_panel_passenger': 'Passenger door panel',
      'gear_shifter': 'Gear shift and surrounding area',
      'engine_bay_full': 'Full engine compartment view',
      'engine_closeup': 'Close-up of engine components',
      'vin_plate': 'Clear photo of VIN number plate',
      'odometer': 'Clear reading of odometer',
      'undercarriage': 'Underside of vehicle (use ramp if available)',
      'suspension': 'Suspension components and condition',
      'paint_condition': 'Close-up showing paint quality',
      'tire_tread_front_left': 'Front left tire tread depth',
      'tire_tread_front_right': 'Front right tire tread depth',
      'tire_tread_rear_left': 'Rear left tire tread depth',
      'tire_tread_rear_right': 'Rear right tire tread depth',
      'headlights': 'Both headlights clear view',
      'tail_lights': 'Both tail lights clear view',
      'interior_wear': 'Any wear or damage inside',
      'carpet_condition': 'Floor carpet/mat condition',
      'infotainment': 'Infotainment system display',
      'service_stickers': 'Service reminder stickers',
      'registration_papers': 'Vehicle registration document',
      'service_history': 'Service records/booklet',
    };

    return tips[imageKey] ?? 'Clear, well-lit photo required';
  }
}
