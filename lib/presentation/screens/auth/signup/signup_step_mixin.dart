import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../providers/signup_provider.dart';

mixin SignupStepMixin<T extends StatefulWidget> on State<T> {
  void handleNext(String nextRoute) {
    final provider = context.read<SignupProvider>();
    if (provider.isEditingFromReview) {
      provider.setIsEditingFromReview(false);
      context.go('/signup/step8');
    } else {
      context.go(nextRoute);
    }
  }

  void handleBack(String previousRoute) {
    final provider = context.read<SignupProvider>();
    if (provider.isEditingFromReview) {
      provider.setIsEditingFromReview(false);
      context.go('/signup/step8');
    } else {
      context.go(previousRoute);
    }
  }

  Widget buildBackButton() {
    final provider = context.watch<SignupProvider>();
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        if (provider.isEditingFromReview) {
          provider.setIsEditingFromReview(false);
          context.go('/signup/step8');
        } else {
          Navigator.of(context).pop();
        }
      },
    );
  }

  String getNextButtonText() {
    final provider = context.watch<SignupProvider>();
    return provider.isEditingFromReview ? 'Return to Review' : 'Next';
  }
}
