import 'kyc_model.dart';

class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? phoneNumber;
  final String? street;
  final String? barangay;
  final String? city;
  final String? province;
  final String? zipCode;
  final String? nationality;
  final bool termsAccepted;
  final bool privacyAccepted;
  final String kycStatus; // 'pending', 'verified', 'rejected'
  final String accountType; // 'individual', 'business'
  final DateTime createdAt;
  final bool verifiedBadge;
  final KycModel? kycData;

  const UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    this.firstName,
    this.middleName,
    this.lastName,
    this.dateOfBirth,
    this.gender,
    this.phoneNumber,
    this.street,
    this.barangay,
    this.city,
    this.province,
    this.zipCode,
    this.nationality,
    this.termsAccepted = false,
    this.privacyAccepted = false,
    this.kycStatus = 'pending',
    this.accountType = 'individual',
    required this.createdAt,
    this.verifiedBadge = false,
    this.kycData,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'phoneNumber': phoneNumber,
      'street': street,
      'barangay': barangay,
      'city': city,
      'province': province,
      'zipCode': zipCode,
      'nationality': nationality,
      'termsAccepted': termsAccepted,
      'privacyAccepted': privacyAccepted,
      'kycStatus': kycStatus,
      'accountType': accountType,
      'createdAt': createdAt.toIso8601String(),
      'verifiedBadge': verifiedBadge,
      'kycData': kycData?.toJson(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      firstName: json['firstName'] as String?,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'] as String)
          : null,
      gender: json['gender'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      street: json['street'] as String?,
      barangay: json['barangay'] as String?,
      city: json['city'] as String?,
      province: json['province'] as String?,
      zipCode: json['zipCode'] as String?,
      nationality: json['nationality'] as String?,
      termsAccepted: json['termsAccepted'] as bool? ?? false,
      privacyAccepted: json['privacyAccepted'] as bool? ?? false,
      kycStatus: json['kycStatus'] as String? ?? 'pending',
      accountType: json['accountType'] as String? ?? 'individual',
      createdAt: DateTime.parse(json['createdAt'] as String),
      verifiedBadge: json['verifiedBadge'] as bool? ?? false,
      kycData: json['kycData'] != null
          ? KycModel.fromJson(json['kycData'] as Map<String, dynamic>)
          : null,
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? firstName,
    String? middleName,
    String? lastName,
    DateTime? dateOfBirth,
    String? gender,
    String? phoneNumber,
    String? street,
    String? barangay,
    String? city,
    String? province,
    String? zipCode,
    String? nationality,
    bool? termsAccepted,
    bool? privacyAccepted,
    String? kycStatus,
    String? accountType,
    DateTime? createdAt,
    bool? verifiedBadge,
    KycModel? kycData,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      street: street ?? this.street,
      barangay: barangay ?? this.barangay,
      city: city ?? this.city,
      province: province ?? this.province,
      zipCode: zipCode ?? this.zipCode,
      nationality: nationality ?? this.nationality,
      termsAccepted: termsAccepted ?? this.termsAccepted,
      privacyAccepted: privacyAccepted ?? this.privacyAccepted,
      kycStatus: kycStatus ?? this.kycStatus,
      accountType: accountType ?? this.accountType,
      createdAt: createdAt ?? this.createdAt,
      verifiedBadge: verifiedBadge ?? this.verifiedBadge,
      kycData: kycData ?? this.kycData,
    );
  }
}
