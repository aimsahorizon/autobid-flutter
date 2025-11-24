// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Token service singleton

@ProviderFor(tokenService)
const tokenServiceProvider = TokenServiceProvider._();

/// Token service singleton

final class TokenServiceProvider
    extends
        $FunctionalProvider<
          MockTokenService,
          MockTokenService,
          MockTokenService
        >
    with $Provider<MockTokenService> {
  /// Token service singleton
  const TokenServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenServiceHash();

  @$internal
  @override
  $ProviderElement<MockTokenService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MockTokenService create(Ref ref) {
    return tokenService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MockTokenService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MockTokenService>(value),
    );
  }
}

String _$tokenServiceHash() => r'50a69f442fdb5004e4e1696120534133de35f8ff';

/// Get user's current token balance

@ProviderFor(userTokenBalance)
const userTokenBalanceProvider = UserTokenBalanceFamily._();

/// Get user's current token balance

final class UserTokenBalanceProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  /// Get user's current token balance
  const UserTokenBalanceProvider._({
    required UserTokenBalanceFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userTokenBalanceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userTokenBalanceHash();

  @override
  String toString() {
    return r'userTokenBalanceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    final argument = this.argument as String;
    return userTokenBalance(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserTokenBalanceProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userTokenBalanceHash() => r'a623000af9024d7350c9f93edaea9de79eff5894';

/// Get user's current token balance

final class UserTokenBalanceFamily extends $Family
    with $FunctionalFamilyOverride<Stream<int>, String> {
  const UserTokenBalanceFamily._()
    : super(
        retry: null,
        name: r'userTokenBalanceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Get user's current token balance

  UserTokenBalanceProvider call(String userId) =>
      UserTokenBalanceProvider._(argument: userId, from: this);

  @override
  String toString() => r'userTokenBalanceProvider';
}

/// Get user's token transaction history

@ProviderFor(userTokenTransactions)
const userTokenTransactionsProvider = UserTokenTransactionsFamily._();

/// Get user's token transaction history

final class UserTokenTransactionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TokenTransaction>>,
          List<TokenTransaction>,
          FutureOr<List<TokenTransaction>>
        >
    with
        $FutureModifier<List<TokenTransaction>>,
        $FutureProvider<List<TokenTransaction>> {
  /// Get user's token transaction history
  const UserTokenTransactionsProvider._({
    required UserTokenTransactionsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userTokenTransactionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userTokenTransactionsHash();

  @override
  String toString() {
    return r'userTokenTransactionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<TokenTransaction>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TokenTransaction>> create(Ref ref) {
    final argument = this.argument as String;
    return userTokenTransactions(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserTokenTransactionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userTokenTransactionsHash() =>
    r'4e050380854e098f34c0247724b16f2bce8846c4';

/// Get user's token transaction history

final class UserTokenTransactionsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<TokenTransaction>>, String> {
  const UserTokenTransactionsFamily._()
    : super(
        retry: null,
        name: r'userTokenTransactionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Get user's token transaction history

  UserTokenTransactionsProvider call(String userId) =>
      UserTokenTransactionsProvider._(argument: userId, from: this);

  @override
  String toString() => r'userTokenTransactionsProvider';
}

/// Get user's token purchase history

@ProviderFor(userTokenPurchases)
const userTokenPurchasesProvider = UserTokenPurchasesFamily._();

/// Get user's token purchase history

final class UserTokenPurchasesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TokenPurchase>>,
          List<TokenPurchase>,
          FutureOr<List<TokenPurchase>>
        >
    with
        $FutureModifier<List<TokenPurchase>>,
        $FutureProvider<List<TokenPurchase>> {
  /// Get user's token purchase history
  const UserTokenPurchasesProvider._({
    required UserTokenPurchasesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userTokenPurchasesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userTokenPurchasesHash();

  @override
  String toString() {
    return r'userTokenPurchasesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<TokenPurchase>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TokenPurchase>> create(Ref ref) {
    final argument = this.argument as String;
    return userTokenPurchases(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserTokenPurchasesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userTokenPurchasesHash() =>
    r'72217cf4bff77d4e58cb1a37e2686480d852bfa1';

/// Get user's token purchase history

final class UserTokenPurchasesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<TokenPurchase>>, String> {
  const UserTokenPurchasesFamily._()
    : super(
        retry: null,
        name: r'userTokenPurchasesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Get user's token purchase history

  UserTokenPurchasesProvider call(String userId) =>
      UserTokenPurchasesProvider._(argument: userId, from: this);

  @override
  String toString() => r'userTokenPurchasesProvider';
}

/// Get user's token statistics

@ProviderFor(userTokenStatistics)
const userTokenStatisticsProvider = UserTokenStatisticsFamily._();

/// Get user's token statistics

final class UserTokenStatisticsProvider
    extends
        $FunctionalProvider<
          AsyncValue<TokenStatistics>,
          TokenStatistics,
          FutureOr<TokenStatistics>
        >
    with $FutureModifier<TokenStatistics>, $FutureProvider<TokenStatistics> {
  /// Get user's token statistics
  const UserTokenStatisticsProvider._({
    required UserTokenStatisticsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userTokenStatisticsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userTokenStatisticsHash();

  @override
  String toString() {
    return r'userTokenStatisticsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TokenStatistics> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TokenStatistics> create(Ref ref) {
    final argument = this.argument as String;
    return userTokenStatistics(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserTokenStatisticsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userTokenStatisticsHash() =>
    r'3f5b6b25bd38df369accfd4a307a174e1efdb243';

/// Get user's token statistics

final class UserTokenStatisticsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<TokenStatistics>, String> {
  const UserTokenStatisticsFamily._()
    : super(
        retry: null,
        name: r'userTokenStatisticsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Get user's token statistics

  UserTokenStatisticsProvider call(String userId) =>
      UserTokenStatisticsProvider._(argument: userId, from: this);

  @override
  String toString() => r'userTokenStatisticsProvider';
}

/// Check if user can deduct token (handles unlimited tier)

@ProviderFor(canDeductToken)
const canDeductTokenProvider = CanDeductTokenFamily._();

/// Check if user can deduct token (handles unlimited tier)

final class CanDeductTokenProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Check if user can deduct token (handles unlimited tier)
  const CanDeductTokenProvider._({
    required CanDeductTokenFamily super.from,
    required (String, SubscriptionTierType) super.argument,
  }) : super(
         retry: null,
         name: r'canDeductTokenProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$canDeductTokenHash();

  @override
  String toString() {
    return r'canDeductTokenProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as (String, SubscriptionTierType);
    return canDeductToken(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is CanDeductTokenProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$canDeductTokenHash() => r'21ca5dd981286a9fe731ff8f9dbe66fb6d4cf6c9';

/// Check if user can deduct token (handles unlimited tier)

final class CanDeductTokenFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<bool>,
          (String, SubscriptionTierType)
        > {
  const CanDeductTokenFamily._()
    : super(
        retry: null,
        name: r'canDeductTokenProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Check if user can deduct token (handles unlimited tier)

  CanDeductTokenProvider call(String userId, SubscriptionTierType tierType) =>
      CanDeductTokenProvider._(argument: (userId, tierType), from: this);

  @override
  String toString() => r'canDeductTokenProvider';
}

/// Get available token purchase tiers

@ProviderFor(tokenPurchaseTiers)
const tokenPurchaseTiersProvider = TokenPurchaseTiersProvider._();

/// Get available token purchase tiers

final class TokenPurchaseTiersProvider
    extends
        $FunctionalProvider<
          List<TokenPurchaseTierConfig>,
          List<TokenPurchaseTierConfig>,
          List<TokenPurchaseTierConfig>
        >
    with $Provider<List<TokenPurchaseTierConfig>> {
  /// Get available token purchase tiers
  const TokenPurchaseTiersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenPurchaseTiersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenPurchaseTiersHash();

  @$internal
  @override
  $ProviderElement<List<TokenPurchaseTierConfig>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<TokenPurchaseTierConfig> create(Ref ref) {
    return tokenPurchaseTiers(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TokenPurchaseTierConfig> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TokenPurchaseTierConfig>>(
        value,
      ),
    );
  }
}

String _$tokenPurchaseTiersHash() =>
    r'b0c2a3163f17d4520516e58b54cd0197a7a5e787';

/// Get current user's token balance

@ProviderFor(currentUserTokenBalance)
const currentUserTokenBalanceProvider = CurrentUserTokenBalanceProvider._();

/// Get current user's token balance

final class CurrentUserTokenBalanceProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  /// Get current user's token balance
  const CurrentUserTokenBalanceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserTokenBalanceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserTokenBalanceHash();

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    return currentUserTokenBalance(ref);
  }
}

String _$currentUserTokenBalanceHash() =>
    r'a47e84c9207faefce5afa05fc5d5830c1c2cc41c';

/// Get current user's token transactions

@ProviderFor(currentUserTokenTransactions)
const currentUserTokenTransactionsProvider =
    CurrentUserTokenTransactionsProvider._();

/// Get current user's token transactions

final class CurrentUserTokenTransactionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TokenTransaction>>,
          List<TokenTransaction>,
          FutureOr<List<TokenTransaction>>
        >
    with
        $FutureModifier<List<TokenTransaction>>,
        $FutureProvider<List<TokenTransaction>> {
  /// Get current user's token transactions
  const CurrentUserTokenTransactionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserTokenTransactionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserTokenTransactionsHash();

  @$internal
  @override
  $FutureProviderElement<List<TokenTransaction>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TokenTransaction>> create(Ref ref) {
    return currentUserTokenTransactions(ref);
  }
}

String _$currentUserTokenTransactionsHash() =>
    r'88cba4db90d2ec50e333f3861554903b07eda981';

/// Get current user's token statistics

@ProviderFor(currentUserTokenStatistics)
const currentUserTokenStatisticsProvider =
    CurrentUserTokenStatisticsProvider._();

/// Get current user's token statistics

final class CurrentUserTokenStatisticsProvider
    extends
        $FunctionalProvider<
          AsyncValue<TokenStatistics>,
          TokenStatistics,
          FutureOr<TokenStatistics>
        >
    with $FutureModifier<TokenStatistics>, $FutureProvider<TokenStatistics> {
  /// Get current user's token statistics
  const CurrentUserTokenStatisticsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserTokenStatisticsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserTokenStatisticsHash();

  @$internal
  @override
  $FutureProviderElement<TokenStatistics> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TokenStatistics> create(Ref ref) {
    return currentUserTokenStatistics(ref);
  }
}

String _$currentUserTokenStatisticsHash() =>
    r'0d19b173cbf71a53e2db205a63c411bcf722a699';

/// Token action provider for purchases, deductions, and refunds

@ProviderFor(TokenActions)
const tokenActionsProvider = TokenActionsProvider._();

/// Token action provider for purchases, deductions, and refunds
final class TokenActionsProvider
    extends $AsyncNotifierProvider<TokenActions, void> {
  /// Token action provider for purchases, deductions, and refunds
  const TokenActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenActionsHash();

  @$internal
  @override
  TokenActions create() => TokenActions();
}

String _$tokenActionsHash() => r'e6b2b25f33234dcb34da42b06289aea61e896c8c';

/// Token action provider for purchases, deductions, and refunds

abstract class _$TokenActions extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
