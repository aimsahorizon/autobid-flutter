import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../providers/listing_provider.dart';
import '../../../widgets/custom_button.dart';

class ListingSuccessScreen extends StatelessWidget {
  const ListingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: ColorConstants.primaryGreen.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_outline,
                  size: 100,
                  color: ColorConstants.primaryGreen,
                ),
              ),
              const SizedBox(height: 32),

              Text(
                'Listing Submitted!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primaryGreen,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              Text(
                'Your vehicle listing has been submitted for review',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[700],
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Review Notice
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 48,
                      color: Colors.blue[700],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Under Review',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your listing will be reviewed by our team and will appear on the platform within 24-48 hours. We\'ll notify you via email once it\'s approved.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue[900],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // What's Next
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What happens next?',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildStep('1', 'Our team reviews your listing'),
                    _buildStep('2', 'You receive an approval email'),
                    _buildStep('3', 'Your listing goes live'),
                    _buildStep('4', 'Buyers can view and bid'),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Action Buttons
              CustomButton(
                text: 'View My Listings',
                onPressed: () {
                  context.read<ListingProvider>().reset();
                  context.go('/listing'); // Navigate to home with My Listings tab
                },
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  context.read<ListingProvider>().reset();
                  context.go('/listing/create/step1');
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Create Another Listing'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: ColorConstants.primaryGreen,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
