class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String? phoneNumber;
  final String kycStatus; // 'pending', 'verified', 'rejected'
  final String accountType; // 'individual', 'business'
  final DateTime createdAt;
  final bool verifiedBadge;

  const UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    this.phoneNumber,
    this.kycStatus = 'pending',
    this.accountType = 'individual',
    required this.createdAt,
    this.verifiedBadge = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'kycStatus': kycStatus,
      'accountType': accountType,
      'createdAt': createdAt.toIso8601String(),
      'verifiedBadge': verifiedBadge,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      kycStatus: json['kycStatus'] as String? ?? 'pending',
      accountType: json['accountType'] as String? ?? 'individual',
      createdAt: DateTime.parse(json['createdAt'] as String),
      verifiedBadge: json['verifiedBadge'] as bool? ?? false,
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phoneNumber,
    String? kycStatus,
    String? accountType,
    DateTime? createdAt,
    bool? verifiedBadge,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      kycStatus: kycStatus ?? this.kycStatus,
      accountType: accountType ?? this.accountType,
      createdAt: createdAt ?? this.createdAt,
      verifiedBadge: verifiedBadge ?? this.verifiedBadge,
    );
  }
}
