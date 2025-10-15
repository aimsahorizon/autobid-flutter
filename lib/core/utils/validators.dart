class Validators {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Password validation - min 8 chars, 1 uppercase, 1 number
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  // Confirm password validation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Philippine phone number validation - +639XXXXXXXXX
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final phoneRegex = RegExp(r'^\+639\d{9}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid PH number (+639XXXXXXXXX)';
    }
    return null;
  }

  // National ID validation - XXXX-XXXX-XXXX format
  static String? validateNationalId(String? value) {
    if (value == null || value.isEmpty) {
      return 'National ID number is required';
    }
    final idRegex = RegExp(r'^\d{4}-\d{4}-\d{4}$');
    if (!idRegex.hasMatch(value)) {
      return 'Enter a valid format (XXXX-XXXX-XXXX)';
    }
    return null;
  }

  // Age validation - 18+
  static String? validateAge(DateTime? birthDate) {
    if (birthDate == null) {
      return 'Date of birth is required';
    }
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    if (age < 18) {
      return 'You must be at least 18 years old';
    }
    return null;
  }

  // ZIP code validation - 4 digits
  static String? validateZipCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'ZIP code is required';
    }
    final zipRegex = RegExp(r'^\d{4}$');
    if (!zipRegex.hasMatch(value)) {
      return 'Enter a valid 4-digit ZIP code';
    }
    return null;
  }

  // Required field validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Name validation
  static String? validateName(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (value.length < 2) {
      return '$fieldName must be at least 2 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return '$fieldName can only contain letters';
    }
    return null;
  }

  // Secondary ID number validation
  static String? validateSecondaryIdNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'ID number is required';
    }
    if (value.length < 5) {
      return 'ID number must be at least 5 characters';
    }
    return null;
  }
}
