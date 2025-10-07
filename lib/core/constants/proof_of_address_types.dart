import '../../data/models/user_model.dart';

class ProofOfAddressTypeInfo {
  final ProofOfAddressType type;
  final String displayName;
  final String description;
  final String example;

  const ProofOfAddressTypeInfo({
    required this.type,
    required this.displayName,
    required this.description,
    required this.example,
  });
}

class ProofOfAddressTypes {
  static const utilityBill = ProofOfAddressTypeInfo(
    type: ProofOfAddressType.utilityBill,
    displayName: 'Utility Bill',
    description: 'Electric, water, or internet bill issued within 3 months',
    example: 'Meralco, Manila Water, PLDT bill',
  );

  static const bankStatement = ProofOfAddressTypeInfo(
    type: ProofOfAddressType.bankStatement,
    displayName: 'Bank Statement',
    description: 'Official bank account statement issued within 3 months',
    example: 'BDO, BPI, Metrobank statement',
  );

  static const governmentLetter = ProofOfAddressTypeInfo(
    type: ProofOfAddressType.governmentLetter,
    displayName: 'Government Letter',
    description: 'Official correspondence from government agencies',
    example: 'SSS, PhilHealth, Pag-IBIG documents',
  );

  static const rentalContract = ProofOfAddressTypeInfo(
    type: ProofOfAddressType.rentalContract,
    displayName: 'Rental Contract',
    description: 'Notarized lease or rental agreement',
    example: 'Signed and notarized rental contract',
  );

  static const barangayCertificate = ProofOfAddressTypeInfo(
    type: ProofOfAddressType.barangayCertificate,
    displayName: 'Barangay Certificate',
    description: 'Certificate of residency from barangay',
    example: 'Barangay clearance or certificate of residency',
  );

  static List<ProofOfAddressTypeInfo> get all => [
        utilityBill,
        bankStatement,
        governmentLetter,
        rentalContract,
        barangayCertificate,
      ];

  static ProofOfAddressTypeInfo getInfo(ProofOfAddressType type) {
    switch (type) {
      case ProofOfAddressType.utilityBill:
        return utilityBill;
      case ProofOfAddressType.bankStatement:
        return bankStatement;
      case ProofOfAddressType.governmentLetter:
        return governmentLetter;
      case ProofOfAddressType.rentalContract:
        return rentalContract;
      case ProofOfAddressType.barangayCertificate:
        return barangayCertificate;
    }
  }

  static String getDisplayName(ProofOfAddressType type) {
    return getInfo(type).displayName;
  }
}
