// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_condition_attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VehicleConditionAttribute _$VehicleConditionAttributeFromJson(
  Map<String, dynamic> json,
) => _VehicleConditionAttribute(
  id: json['id'] as String,
  label: json['label'] as String,
  description: json['description'] as String,
  category: json['category'] as String,
  value: json['value'] as bool? ?? false,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
  iconData: json['iconData'] as String?,
  isPositive: json['isPositive'] as bool? ?? false,
);

Map<String, dynamic> _$VehicleConditionAttributeToJson(
  _VehicleConditionAttribute instance,
) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'description': instance.description,
  'category': instance.category,
  'value': instance.value,
  'sortOrder': instance.sortOrder,
  'iconData': instance.iconData,
  'isPositive': instance.isPositive,
};
