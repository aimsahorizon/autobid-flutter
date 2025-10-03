import '../models/user_model.dart';
import '../services/mock/mock_auth_service.dart';

abstract class AuthRepository {
  Stream<UserModel?> get authStateChanges;
  UserModel? getCurrentUser();
  Future<AuthResult> signInWithEmail(String email, String password);
  Future<AuthResult> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
  });
  Future<AuthResult> signInWithGoogle();
  Future<void> signOut();
}

class AuthRepositoryImpl implements AuthRepository {
  final MockAuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Stream<UserModel?> get authStateChanges => _authService.authStateChanges;

  @override
  UserModel? getCurrentUser() => _authService.getCurrentUser();

  @override
  Future<AuthResult> signInWithEmail(String email, String password) {
    return _authService.signInWithEmail(email, password);
  }

  @override
  Future<AuthResult> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
  }) {
    return _authService.signUpWithEmail(
      email: email,
      password: password,
      fullName: fullName,
      phoneNumber: phoneNumber,
    );
  }

  @override
  Future<AuthResult> signInWithGoogle() {
    return _authService.signInWithGoogle();
  }

  @override
  Future<void> signOut() {
    return _authService.signOut();
  }
}
