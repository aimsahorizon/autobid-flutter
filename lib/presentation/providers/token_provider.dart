import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:autobid/data/models/token_model.dart';
import 'package:autobid/data/models/subscription_tier.dart';
import 'package:autobid/data/services/mock/mock_token_service.dart';
import 'package:autobid/presentation/providers/auth_provider.dart';

part 'token_provider.g.dart';

// ========== SERVICE PROVIDER ==========

/// Token service singleton
@Riverpod(keepAlive: true)
MockTokenService tokenService(Ref ref) {
  return MockTokenService();
}

// ========== STATE PROVIDERS ==========

/// Get user's current token balance
@riverpod
Stream<int> userTokenBalance(Ref ref, String userId) {
  final service = ref.watch(tokenServiceProvider);
  return service.balanceStream(userId);
}

/// Get user's token transaction history
@riverpod
Future<List<TokenTransaction>> userTokenTransactions(
  Ref ref,
  String userId,
) async {
  final service = ref.watch(tokenServiceProvider);
  return service.getTransactionHistory(userId);
}

/// Get user's token purchase history
@riverpod
Future<List<TokenPurchase>> userTokenPurchases(
  Ref ref,
  String userId,
) async {
  final service = ref.watch(tokenServiceProvider);
  return service.getPurchaseHistory(userId);
}

/// Get user's token statistics
@riverpod
Future<TokenStatistics> userTokenStatistics(
  Ref ref,
  String userId,
) async {
  final service = ref.watch(tokenServiceProvider);
  return service.getStatistics(userId);
}

/// Check if user can deduct token (handles unlimited tier)
@riverpod
Future<bool> canDeductToken(
  Ref ref,
  String userId,
  SubscriptionTierType tierType,
) async {
  final service = ref.watch(tokenServiceProvider);
  return service.canDeductToken(
    userId: userId,
    tierType: tierType,
  );
}

/// Get available token purchase tiers
@riverpod
List<TokenPurchaseTierConfig> tokenPurchaseTiers(Ref ref) {
  return TokenPurchaseTierConfig.allTiers;
}

// ========== CURRENT USER PROVIDERS ==========

/// Get current user's token balance
@riverpod
Stream<int> currentUserTokenBalance(Ref ref) async* {
  final authState = ref.watch(authStateChangesProvider);

  yield* authState.when(
    data: (user) {
      if (user == null) return Stream.value(0);
      return ref.watch(userTokenBalanceProvider(user.id) as ProviderListenable<Stream<int>>);
    },
    loading: () => Stream.value(0),
    error: (_, __) => Stream.value(0),
  );
}

/// Get current user's token transactions
@riverpod
Future<List<TokenTransaction>> currentUserTokenTransactions(
  Ref ref,
) async {
  final authState = ref.watch(authStateChangesProvider);

  return authState.when(
    data: (user) {
      if (user == null) return [];
      return ref.watch(userTokenTransactionsProvider(user.id).future);
    },
    loading: () => [],
    error: (_, __) => [],
  );
}

/// Get current user's token statistics
@riverpod
Future<TokenStatistics> currentUserTokenStatistics(
  Ref ref,
) async {
  final authState = ref.watch(authStateChangesProvider);

  return authState.when(
    data: (user) async {
      if (user == null) {
        return TokenStatistics(
          currentBalance: 0,
          totalPurchased: 0,
          totalSpent: 0,
          totalAllocated: 0,
          totalTransactions: 0,
        );
      }
      return ref.watch(userTokenStatisticsProvider(user.id).future);
    },
    loading: () => TokenStatistics(
      currentBalance: 0,
      totalPurchased: 0,
      totalSpent: 0,
      totalAllocated: 0,
      totalTransactions: 0,
    ),
    error: (_, __) => TokenStatistics(
      currentBalance: 0,
      totalPurchased: 0,
      totalSpent: 0,
      totalAllocated: 0,
      totalTransactions: 0,
    ),
  );
}

// ========== ACTION PROVIDERS ==========

/// Token action provider for purchases, deductions, and refunds
@riverpod
class TokenActions extends _$TokenActions {
  @override
  FutureOr<void> build() async {
    // No initial state needed
  }

  /// Purchase tokens
  Future<TokenPurchase> purchaseTokens({
    required String userId,
    required TokenPurchaseTier tier,
  }) async {
    state = const AsyncLoading();

    try {
      final service = ref.read(tokenServiceProvider);
      final purchase = await service.purchaseTokens(
        userId: userId,
        tier: tier,
      );

      state = const AsyncData(null);

      // Invalidate balance to refresh UI
      ref.invalidate(userTokenBalanceProvider(userId));
      ref.invalidate(userTokenTransactionsProvider(userId));
      ref.invalidate(userTokenStatisticsProvider(userId));

      return purchase;
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  /// Deduct token for bid placement
  Future<bool> deductToken({
    required String userId,
    required String auctionId,
  }) async {
    state = const AsyncLoading();

    try {
      final service = ref.read(tokenServiceProvider);
      final result = await service.deductToken(
        userId: userId,
        auctionId: auctionId,
      );

      state = const AsyncData(null);

      // Invalidate balance to refresh UI
      ref.invalidate(userTokenBalanceProvider(userId));
      ref.invalidate(userTokenTransactionsProvider(userId));
      ref.invalidate(userTokenStatisticsProvider(userId));

      return result;
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  /// Refund token (auction cancelled, bid cancelled)
  Future<void> refundToken({
    required String userId,
    required String auctionId,
    String? reason,
  }) async {
    state = const AsyncLoading();

    try {
      final service = ref.read(tokenServiceProvider);
      await service.refundToken(
        userId: userId,
        auctionId: auctionId,
        reason: reason,
      );

      state = const AsyncData(null);

      // Invalidate balance to refresh UI
      ref.invalidate(userTokenBalanceProvider(userId));
      ref.invalidate(userTokenTransactionsProvider(userId));
      ref.invalidate(userTokenStatisticsProvider(userId));
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  /// Add tokens manually (admin/promotional)
  Future<void> addTokens({
    required String userId,
    required int amount,
    String? reason,
  }) async {
    state = const AsyncLoading();

    try {
      final service = ref.read(tokenServiceProvider);
      await service.addTokens(
        userId: userId,
        amount: amount,
        reason: reason,
      );

      state = const AsyncData(null);

      // Invalidate balance to refresh UI
      ref.invalidate(userTokenBalanceProvider(userId));
      ref.invalidate(userTokenTransactionsProvider(userId));
      ref.invalidate(userTokenStatisticsProvider(userId));
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  /// Allocate monthly subscription tokens
  Future<void> allocateSubscriptionTokens({
    required String userId,
    required SubscriptionTierType tierType,
  }) async {
    state = const AsyncLoading();

    try {
      final service = ref.read(tokenServiceProvider);
      await service.allocateSubscriptionTokens(
        userId: userId,
        tierType: tierType,
      );

      state = const AsyncData(null);

      // Invalidate balance to refresh UI
      ref.invalidate(userTokenBalanceProvider(userId));
      ref.invalidate(userTokenTransactionsProvider(userId));
      ref.invalidate(userTokenStatisticsProvider(userId));
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }
}
