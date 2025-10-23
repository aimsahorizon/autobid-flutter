import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:autobid/data/models/bidding_deposit.dart';
import 'package:autobid/data/services/mock/mock_deposit_service.dart';

part 'deposit_provider.g.dart';

/// Deposit service provider
@Riverpod(keepAlive: true)
MockDepositService depositService(Ref ref) {
  return MockDepositService();
}

/// Current user's deposit provider
@riverpod
Future<BiddingDeposit?> userDeposit(
  Ref ref,
  String userId,
) async {
  final service = ref.watch(depositServiceProvider);
  return await service.getUserDeposit(userId);
}

/// Check if user has paid deposit
@riverpod
Future<bool> hasDeposit(
  Ref ref,
  String userId,
) async {
  final service = ref.watch(depositServiceProvider);
  return await service.hasDeposit(userId);
}

/// User's deposit history provider
@riverpod
Future<List<BiddingDeposit>> depositHistory(
  Ref ref,
  String userId,
) async {
  final service = ref.watch(depositServiceProvider);
  return await service.getDepositHistory(userId);
}

/// Deposit statistics provider (admin)
@riverpod
Future<Map<String, dynamic>> depositStatistics(
  Ref ref,
) async {
  final service = ref.watch(depositServiceProvider);
  return await service.getDepositStatistics();
}

/// Deposit action notifier for managing deposits
@riverpod
class DepositActions extends _$DepositActions {
  @override
  FutureOr<void> build() {}

  /// Create a new pending deposit
  Future<BiddingDeposit> createDeposit({required String userId}) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(depositServiceProvider);
      final deposit = await service.createDeposit(userId: userId);

      // Invalidate related providers
      ref.invalidate(userDepositProvider);
      ref.invalidate(hasDepositProvider);
      ref.invalidate(depositHistoryProvider);

      state = const AsyncValue.data(null);
      return deposit;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  /// Pay deposit (complete payment)
  Future<BiddingDeposit> payDeposit({
    required String depositId,
    required String paymentMethod,
    required String paymentReference,
  }) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(depositServiceProvider);
      final deposit = await service.payDeposit(
        depositId: depositId,
        paymentMethod: paymentMethod,
        paymentReference: paymentReference,
      );

      // Invalidate related providers
      ref.invalidate(userDepositProvider);
      ref.invalidate(hasDepositProvider);
      ref.invalidate(depositHistoryProvider);

      state = const AsyncValue.data(null);
      return deposit;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  /// Credit deposit to auction win
  Future<BiddingDeposit> creditDeposit({
    required String depositId,
    required String auctionId,
    required double premiumAmount,
  }) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(depositServiceProvider);
      final deposit = await service.creditDeposit(
        depositId: depositId,
        auctionId: auctionId,
        premiumAmount: premiumAmount,
      );

      // Invalidate related providers
      ref.invalidate(userDepositProvider);
      ref.invalidate(hasDepositProvider);
      ref.invalidate(depositHistoryProvider);

      state = const AsyncValue.data(null);
      return deposit;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  /// Refund deposit
  Future<BiddingDeposit> refundDeposit({
    required String depositId,
    String? reason,
  }) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(depositServiceProvider);
      final deposit = await service.refundDeposit(
        depositId: depositId,
        reason: reason,
      );

      // Invalidate related providers
      ref.invalidate(userDepositProvider);
      ref.invalidate(hasDepositProvider);
      ref.invalidate(depositHistoryProvider);

      state = const AsyncValue.data(null);
      return deposit;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  /// Process expired deposits (admin/cron)
  Future<void> processExpiredDeposits() async {
    // For this admin/cron action we don't produce a BiddingDeposit result,
    // so avoid using AsyncValue.guard with a void return. Instead set
    // loading, perform the work, invalidate related providers and restore
    // the state to null (no current deposit selected).
    state = const AsyncValue.loading();
    try {
      final service = ref.read(depositServiceProvider);
      await service.processExpiredDeposits();

      // Invalidate all deposit providers
      ref.invalidate(userDepositProvider);
      ref.invalidate(hasDepositProvider);
      ref.invalidate(depositHistoryProvider);
      ref.invalidate(depositStatisticsProvider);

      // No specific deposit to return; set state to data with null
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
