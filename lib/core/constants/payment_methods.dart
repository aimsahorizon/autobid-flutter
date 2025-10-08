import '../../data/models/payment_method.dart';
import '../../data/models/transaction_model.dart';

class PaymentMethods {
  static final gcash = PaymentMethod(
    type: PaymentMethodType.gcash,
    displayName: 'GCash',
    icon: 'gcash',
    description: 'Instant transfer via GCash',
    accountNumber: '09123456789',
  );

  static final paymaya = PaymentMethod(
    type: PaymentMethodType.paymaya,
    displayName: 'PayMaya',
    icon: 'paymaya',
    description: 'Instant transfer via PayMaya',
    accountNumber: '09987654321',
  );

  static final bankTransfer = PaymentMethod(
    type: PaymentMethodType.bankTransfer,
    displayName: 'Bank Transfer',
    icon: 'bank',
    description: 'Manual verification 1-2 business days',
  );

  static final cash = PaymentMethod(
    type: PaymentMethodType.cash,
    displayName: 'Cash on Pickup',
    icon: 'cash',
    description: 'Pay when you collect the vehicle',
  );

  static final card = PaymentMethod(
    type: PaymentMethodType.card,
    displayName: 'Credit/Debit Card',
    icon: 'card',
    description: 'Quick and secure card payment',
  );

  static final allMethods = [gcash, paymaya, bankTransfer, cash];

  static const bankDetails = {
    'BDO': {
      'accountName': 'AutoBID Philippines Inc.',
      'accountNumber': '1234567890',
      'branch': 'Makati',
    },
    'BPI': {
      'accountName': 'AutoBID Philippines Inc.',
      'accountNumber': '0987654321',
      'branch': 'BGC',
    },
    'Metrobank': {
      'accountName': 'AutoBID Philippines Inc.',
      'accountNumber': '5555666677',
      'branch': 'Ortigas',
    },
  };
}
