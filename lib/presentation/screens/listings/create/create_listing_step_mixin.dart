import 'package:autobid/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
// import '../../../../core/constants/color_constants.dart';
import '../../../providers/signup_provider.dart';

mixin CreateListingMixin<T extends StatefulWidget> on State<T> {
  void handleNext(String nextRoute) {
    final provider = context.read<SignupProvider>();
    if (provider.isEditingFromReview) {
      provider.setIsEditingFromReview(false);
      context.go('/signup/step9');
    } else {
      context.go(nextRoute);
    }
  }

  void handleBack(String previousRoute) {
    final provider = context.read<SignupProvider>();
    if (provider.isEditingFromReview) {
      provider.setIsEditingFromReview(false);
      context.go('/signup/step9');
    } else {
      context.go(previousRoute);
    }
  }

  Future<void> handleBackWithWarning() async {
    final shouldProceed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.warning_amber_rounded,
          color: Colors.orange,
          size: 48,
        ),
        title: Text('Discard Changes?'),
        content: Text(
          'All your listing progress will be lost if you go back. Are you sure you want to continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/home?tab=2&subTab=1');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.error,
              foregroundColor: Colors.white,
            ),
            child: Text('Discard'),
          ),
        ],
      ),
    );

    if (shouldProceed == true) {
      if (!mounted) return;
      // Clear all signup inputs
      final provider = context.read<SignupProvider>();
      provider.reset();
      context.go('/login');
    }
  }

  Widget buildBackButton(String previousRoute) {
    final provider = context.watch<SignupProvider>();
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        if (provider.isEditingFromReview) {
          provider.setIsEditingFromReview(false);
          context.go('/signup/step9');
        } else {
          context.go(previousRoute);
        }
      },
    );
  }

  Widget buildBackButtonWithWarning() {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: handleBackWithWarning,
    );
  }

  String getNextButtonText() {
    final provider = context.watch<SignupProvider>();
    return provider.isEditingFromReview ? 'Return to Review' : 'Next';
  }
}
