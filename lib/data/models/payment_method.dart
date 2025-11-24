import 'package:freezed_annotation/freezed_annotation.dart';
import 'transaction_model.dart';

part 'payment_method.freezed.dart';
part 'payment_method.g.dart';

@freezed
abstract class PaymentMethod with _$PaymentMethod {
  const factory PaymentMethod({
    required PaymentMethodType type,
    required String displayName,
    required String icon,
    required String description,
    String? accountNumber,
    @Default(false) bool isDefault,
  }) = _PaymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);
}
