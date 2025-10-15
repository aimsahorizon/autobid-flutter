import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';

class LocalStorageService {
  static const String _userKey = 'current_user';
  static const String _usersKey = 'all_users';

  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  static Future<LocalStorageService> getInstance() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalStorageService(prefs);
  }

  // Save current user
  Future<bool> saveUser(UserModel user) async {
    try {
      final userJson = jsonEncode(user.toJson());
      await _prefs.setString(_userKey, userJson);

      // Also save to all users list
      await _saveToAllUsers(user);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get current user
  UserModel? getUser() {
    try {
      final userJson = _prefs.getString(_userKey);
      if (userJson == null) return null;

      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      return null;
    }
  }

  // Check if account exists by email or phone
  UserModel? getUserByEmailOrPhone(String emailOrPhone) {
    try {
      final usersJson = _prefs.getString(_usersKey);
      if (usersJson == null) return null;

      final usersList = jsonDecode(usersJson) as List<dynamic>;

      for (final userMap in usersList) {
        final user = UserModel.fromJson(userMap as Map<String, dynamic>);
        if (user.email.toLowerCase() == emailOrPhone.toLowerCase() ||
            user.phoneNumber == emailOrPhone) {
          return user;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Save to all users list
  Future<void> _saveToAllUsers(UserModel user) async {
    try {
      final usersJson = _prefs.getString(_usersKey);
      List<Map<String, dynamic>> usersList = [];

      if (usersJson != null) {
        usersList = (jsonDecode(usersJson) as List<dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .toList();
      }

      // Remove existing user with same email/phone
      usersList.removeWhere((u) =>
          u['email'] == user.email || u['phoneNumber'] == user.phoneNumber);

      // Add updated user
      usersList.add(user.toJson());

      await _prefs.setString(_usersKey, jsonEncode(usersList));
    } catch (e) {
      // Handle error
    }
  }

  // Update user status
  Future<bool> updateUserStatus(String email, AccountStatus status, {String? rejectionReason}) async {
    try {
      final user = getUserByEmailOrPhone(email);
      if (user == null) return false;

      final updatedUser = user.copyWith(
        accountStatus: status,
        rejectionReason: rejectionReason,
      );

      return await saveUser(updatedUser);
    } catch (e) {
      return false;
    }
  }

  // Update OTP failure count
  Future<bool> updateOtpFailureCount(String email, int count) async {
    try {
      final user = getUserByEmailOrPhone(email);
      if (user == null) return false;

      final updatedUser = user.copyWith(
        otpFailureCount: count,
        lastOtpAttempt: DateTime.now(),
        accountStatus: count >= 3 ? AccountStatus.locked : user.accountStatus,
      );

      return await saveUser(updatedUser);
    } catch (e) {
      return false;
    }
  }

  // Verify user credentials
  bool verifyCredentials(String emailOrPhone, String password) {
    final user = getUserByEmailOrPhone(emailOrPhone);
    if (user == null) return false;
    return user.password == password;
  }

  // Clear current user
  Future<bool> clearUser() async {
    return await _prefs.remove(_userKey);
  }

  // Clear all data
  Future<bool> clearAll() async {
    return await _prefs.clear();
  }
}
