import 'package:flutter/material.dart';
import '../../core/constants/color_constants.dart';

class SignupStepper extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const SignupStepper({
    super.key,
    required this.currentStep,
    this.totalSteps = 7,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(totalSteps, (index) {
            final stepNumber = index + 1;
            final isCompleted = stepNumber < currentStep;
            final isCurrent = stepNumber == currentStep;

            return Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: isCompleted || isCurrent
                            ? ColorConstants.primaryGreen
                            : Colors.grey[300],
                        borderRadius: BorderRadius.horizontal(
                          left: index == 0 ? const Radius.circular(2) : Radius.zero,
                          right: index == totalSteps - 1
                              ? const Radius.circular(2)
                              : Radius.zero,
                        ),
                      ),
                    ),
                  ),
                  if (index < totalSteps - 1) const SizedBox(width: 4),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Step $currentStep of $totalSteps',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.primaryGreen,
                  ),
            ),
            Text(
              '${((currentStep / totalSteps) * 100).toInt()}%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
