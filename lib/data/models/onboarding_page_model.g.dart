// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OnboardingPageModel _$OnboardingPageModelFromJson(Map<String, dynamic> json) =>
    _OnboardingPageModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imagePath: json['imagePath'] as String,
      lottieAnimation: json['lottieAnimation'] as String?,
    );

Map<String, dynamic> _$OnboardingPageModelToJson(
  _OnboardingPageModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'imagePath': instance.imagePath,
  'lottieAnimation': instance.lottieAnimation,
};
