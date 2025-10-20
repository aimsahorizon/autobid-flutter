import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_page_model.freezed.dart';
part 'onboarding_page_model.g.dart';

/// Model representing a single onboarding page
@freezed
abstract class OnboardingPageModel with _$OnboardingPageModel {
  const factory OnboardingPageModel({
    required String id,
    required String title,
    required String description,
    required String imagePath,
    String? lottieAnimation,
  }) = _OnboardingPageModel;

  factory OnboardingPageModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingPageModelFromJson(json);
}
