import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/listing_provider.dart';

/// Reusable Save Draft button widget for all listing creation steps
class SaveDraftButton extends StatelessWidget {
  final int stepNumber;
  final bool Function() validateForm;

  const SaveDraftButton({
    super.key,
    required this.stepNumber,
    required this.validateForm,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _saveDraft(context),
      child: const Text('Save Draft'),
    );
  }

  Future<void> _saveDraft(BuildContext context) async {
    final provider = context.read<ListingProvider>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Saving draft...'),
              ],
            ),
          ),
        ),
      ),
    );

    try {
      await provider.saveDraft(
        'mock-user-id', // TODO: Get from auth
        'Mock User', // TODO: Get from auth
        stepNumber,
      );

      if (!context.mounted) return;
      Navigator.pop(context); // Close loading dialog

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Draft saved! You can continue from Step $stepNumber later.',
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );

      // Navigate to My Listings tab
      context.go('/home?tab=3');
    } catch (e) {
      if (!context.mounted) return;
      Navigator.pop(context); // Close loading dialog

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save draft: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
