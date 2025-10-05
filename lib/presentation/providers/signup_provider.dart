import 'dart:typed_data';
import 'package:flutter/material.dart';

class SignupProvider with ChangeNotifier {
  // Step 1: Account Information
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _phoneNumber = '';
  bool _termsAccepted = false;
  bool _privacyAccepted = false;

  // Step 2: Personal Information
  String _firstName = '';
  String _middleName = '';
  String _lastName = '';
  DateTime? _dateOfBirth;
  String _gender = '';

  // Step 3: Address Information
  String _street = '';
  String _barangay = '';
  String _city = '';
  String _province = '';
  String _zipCode = '';
  String _nationality = 'Filipino';

  // Step 4: Primary ID (National ID)
  Uint8List? _primaryIdFront;
  Uint8List? _primaryIdBack;
  String _nationalIdNumber = '';

  // Step 5: Secondary ID
  String _secondaryIdType = '';
  Uint8List? _secondaryIdImage;
  String _secondaryIdNumber = '';

  // Step 6: Selfie
  Uint8List? _selfieImage;

  // Submission state
  bool _isSubmitting = false;
  String? _errorMessage;

  // Getters for Step 1
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get phoneNumber => _phoneNumber;
  bool get termsAccepted => _termsAccepted;
  bool get privacyAccepted => _privacyAccepted;

  // Getters for Step 2
  String get firstName => _firstName;
  String get middleName => _middleName;
  String get lastName => _lastName;
  DateTime? get dateOfBirth => _dateOfBirth;
  String get gender => _gender;

  // Getters for Step 3
  String get street => _street;
  String get barangay => _barangay;
  String get city => _city;
  String get province => _province;
  String get zipCode => _zipCode;
  String get nationality => _nationality;

  // Getters for Step 4
  Uint8List? get primaryIdFront => _primaryIdFront;
  Uint8List? get primaryIdBack => _primaryIdBack;
  String get nationalIdNumber => _nationalIdNumber;

  // Getters for Step 5
  String get secondaryIdType => _secondaryIdType;
  Uint8List? get secondaryIdImage => _secondaryIdImage;
  String get secondaryIdNumber => _secondaryIdNumber;

  // Getters for Step 6
  Uint8List? get selfieImage => _selfieImage;

  // State getters
  bool get isSubmitting => _isSubmitting;
  String? get errorMessage => _errorMessage;

  // Setters for Step 1
  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void setTermsAccepted(bool value) {
    _termsAccepted = value;
    notifyListeners();
  }

  void setPrivacyAccepted(bool value) {
    _privacyAccepted = value;
    notifyListeners();
  }

  // Setters for Step 2
  void setFirstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  void setMiddleName(String value) {
    _middleName = value;
    notifyListeners();
  }

  void setLastName(String value) {
    _lastName = value;
    notifyListeners();
  }

  void setDateOfBirth(DateTime? value) {
    _dateOfBirth = value;
    notifyListeners();
  }

  void setGender(String value) {
    _gender = value;
    notifyListeners();
  }

  // Setters for Step 3
  void setStreet(String value) {
    _street = value;
    notifyListeners();
  }

  void setBarangay(String value) {
    _barangay = value;
    notifyListeners();
  }

  void setCity(String value) {
    _city = value;
    notifyListeners();
  }

  void setProvince(String value) {
    _province = value;
    notifyListeners();
  }

  void setZipCode(String value) {
    _zipCode = value;
    notifyListeners();
  }

  void setNationality(String value) {
    _nationality = value;
    notifyListeners();
  }

  // Setters for Step 4
  void setPrimaryIdFront(Uint8List? value) {
    _primaryIdFront = value;
    notifyListeners();
  }

  void setPrimaryIdBack(Uint8List? value) {
    _primaryIdBack = value;
    notifyListeners();
  }

  void setNationalIdNumber(String value) {
    _nationalIdNumber = value;
    notifyListeners();
  }

  // Setters for Step 5
  void setSecondaryIdType(String value) {
    _secondaryIdType = value;
    notifyListeners();
  }

  void setSecondaryIdImage(Uint8List? value) {
    _secondaryIdImage = value;
    notifyListeners();
  }

  void setSecondaryIdNumber(String value) {
    _secondaryIdNumber = value;
    notifyListeners();
  }

  // Setters for Step 6
  void setSelfieImage(Uint8List? value) {
    _selfieImage = value;
    notifyListeners();
  }

  // State setters
  void setIsSubmitting(bool value) {
    _isSubmitting = value;
    notifyListeners();
  }

  void setErrorMessage(String? value) {
    _errorMessage = value;
    notifyListeners();
  }

  // Get full name
  String get fullName {
    final parts = [_firstName, _middleName, _lastName]
        .where((part) => part.isNotEmpty)
        .toList();
    return parts.join(' ');
  }

  // Get address
  String get fullAddress {
    final parts = [_street, _barangay, _city, _province, _zipCode]
        .where((part) => part.isNotEmpty)
        .toList();
    return parts.join(', ');
  }

  // Validate step completion
  bool isStep1Complete() {
    return _email.isNotEmpty &&
        _password.isNotEmpty &&
        _confirmPassword.isNotEmpty &&
        _phoneNumber.isNotEmpty &&
        _termsAccepted &&
        _privacyAccepted;
  }

  bool isStep2Complete() {
    return _firstName.isNotEmpty &&
        _lastName.isNotEmpty &&
        _dateOfBirth != null &&
        _gender.isNotEmpty;
  }

  bool isStep3Complete() {
    return _street.isNotEmpty &&
        _barangay.isNotEmpty &&
        _city.isNotEmpty &&
        _province.isNotEmpty &&
        _zipCode.isNotEmpty;
  }

  bool isStep4Complete() {
    return _primaryIdFront != null &&
        _primaryIdBack != null &&
        _nationalIdNumber.isNotEmpty;
  }

  bool isStep5Complete() {
    return _secondaryIdType.isNotEmpty &&
        _secondaryIdImage != null &&
        _secondaryIdNumber.isNotEmpty;
  }

  bool isStep6Complete() {
    return _selfieImage != null;
  }

  // Reset all data
  void reset() {
    _email = '';
    _password = '';
    _confirmPassword = '';
    _phoneNumber = '';
    _termsAccepted = false;
    _privacyAccepted = false;
    _firstName = '';
    _middleName = '';
    _lastName = '';
    _dateOfBirth = null;
    _gender = '';
    _street = '';
    _barangay = '';
    _city = '';
    _province = '';
    _zipCode = '';
    _nationality = 'Filipino';
    _primaryIdFront = null;
    _primaryIdBack = null;
    _nationalIdNumber = '';
    _secondaryIdType = '';
    _secondaryIdImage = null;
    _secondaryIdNumber = '';
    _selfieImage = null;
    _isSubmitting = false;
    _errorMessage = null;
    notifyListeners();
  }
}
