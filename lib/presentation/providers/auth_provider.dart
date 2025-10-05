import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/services/mock/mock_auth_service.dart';

part 'auth_provider.g.dart';

// Auth Service Provider
@riverpod
MockAuthService authService(Ref ref) {
  return MockAuthService();
}

// Auth Repository Provider
@riverpod
AuthRepository authRepository(Ref ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthRepositoryImpl(authService);
}

// Auth State Stream Provider
@riverpod
Stream<UserModel?> authStateChanges(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges;
}

// Current User Provider
@riverpod
UserModel? currentUser(Ref ref) {
  return ref.watch(authStateChangesProvider).value;
}

// Login State Notifier
@riverpod
class LoginState extends _$LoginState {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncValue.loading();

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.signInWithEmail(email, password);

    if (result.success) {
      state = const AsyncValue.data(null);
    } else {
      state = AsyncValue.error(
        result.errorMessage ?? 'Login failed',
        StackTrace.current,
      );
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.signInWithGoogle();

    if (result.success) {
      state = const AsyncValue.data(null);
    } else {
      state = AsyncValue.error(
        result.errorMessage ?? 'Google sign-in failed',
        StackTrace.current,
      );
    }
  }
}

// Signup State Notifier
@riverpod
class SignupState extends _$SignupState {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
  }) async {
    state = const AsyncValue.loading();

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.signUpWithEmail(
      email: email,
      password: password,
      fullName: fullName,
      phoneNumber: phoneNumber,
    );

    if (result.success) {
      state = const AsyncValue.data(null);
    } else {
      state = AsyncValue.error(
        result.errorMessage ?? 'Sign up failed',
        StackTrace.current,
      );
    }
  }

  Future<void> signUpWithGoogle() async {
    state = const AsyncValue.loading();

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.signInWithGoogle();

    if (result.success) {
      state = const AsyncValue.data(null);
    } else {
      state = AsyncValue.error(
        result.errorMessage ?? 'Google sign-in failed',
        StackTrace.current,
      );
    }
  }
}

// Sign Out Action
@riverpod
class SignOutAction extends _$SignOutAction {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> signOut() async {
    state = const AsyncValue.loading();

    final repository = ref.read(authRepositoryProvider);
    await repository.signOut();

    state = const AsyncValue.data(null);
  }
}
