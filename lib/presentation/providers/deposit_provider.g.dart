// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Deposit service provider

@ProviderFor(depositService)
const depositServiceProvider = DepositServiceProvider._();

/// Deposit service provider

final class DepositServiceProvider
    extends
        $FunctionalProvider<
          MockDepositService,
          MockDepositService,
          MockDepositService
        >
    with $Provider<MockDepositService> {
  /// Deposit service provider
  const DepositServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'depositServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$depositServiceHash();

  @$internal
  @override
  $ProviderElement<MockDepositService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MockDepositService create(Ref ref) {
    return depositService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MockDepositService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MockDepositService>(value),
    );
  }
}

String _$depositServiceHash() => r'4d091ce1c61124e5428ed997fae20295ba93024c';

/// Current user's deposit provider

@ProviderFor(userDeposit)
const userDepositProvider = UserDepositFamily._();

/// Current user's deposit provider

final class UserDepositProvider
    extends
        $FunctionalProvider<
          AsyncValue<BiddingDeposit?>,
          BiddingDeposit?,
          FutureOr<BiddingDeposit?>
        >
    with $FutureModifier<BiddingDeposit?>, $FutureProvider<BiddingDeposit?> {
  /// Current user's deposit provider
  const UserDepositProvider._({
    required UserDepositFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userDepositProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userDepositHash();

  @override
  String toString() {
    return r'userDepositProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<BiddingDeposit?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BiddingDeposit?> create(Ref ref) {
    final argument = this.argument as String;
    return userDeposit(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserDepositProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userDepositHash() => r'1903aa4423e52bef83d0f02ab47e8e899e3c6df2';

/// Current user's deposit provider

final class UserDepositFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<BiddingDeposit?>, String> {
  const UserDepositFamily._()
    : super(
        retry: null,
        name: r'userDepositProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Current user's deposit provider

  UserDepositProvider call(String userId) =>
      UserDepositProvider._(argument: userId, from: this);

  @override
  String toString() => r'userDepositProvider';
}

/// Check if user has paid deposit

@ProviderFor(hasDeposit)
const hasDepositProvider = HasDepositFamily._();

/// Check if user has paid deposit

final class HasDepositProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Check if user has paid deposit
  const HasDepositProvider._({
    required HasDepositFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'hasDepositProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hasDepositHash();

  @override
  String toString() {
    return r'hasDepositProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as String;
    return hasDeposit(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is HasDepositProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hasDepositHash() => r'9a16d1ef639d44c4f2a56e7568f04b12d637187c';

/// Check if user has paid deposit

final class HasDepositFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool>, String> {
  const HasDepositFamily._()
    : super(
        retry: null,
        name: r'hasDepositProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Check if user has paid deposit

  HasDepositProvider call(String userId) =>
      HasDepositProvider._(argument: userId, from: this);

  @override
  String toString() => r'hasDepositProvider';
}

/// User's deposit history provider

@ProviderFor(depositHistory)
const depositHistoryProvider = DepositHistoryFamily._();

/// User's deposit history provider

final class DepositHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BiddingDeposit>>,
          List<BiddingDeposit>,
          FutureOr<List<BiddingDeposit>>
        >
    with
        $FutureModifier<List<BiddingDeposit>>,
        $FutureProvider<List<BiddingDeposit>> {
  /// User's deposit history provider
  const DepositHistoryProvider._({
    required DepositHistoryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'depositHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$depositHistoryHash();

  @override
  String toString() {
    return r'depositHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<BiddingDeposit>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BiddingDeposit>> create(Ref ref) {
    final argument = this.argument as String;
    return depositHistory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DepositHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$depositHistoryHash() => r'cb1a480e40f41a3a9238079182079706bfcca00a';

/// User's deposit history provider

final class DepositHistoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<BiddingDeposit>>, String> {
  const DepositHistoryFamily._()
    : super(
        retry: null,
        name: r'depositHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// User's deposit history provider

  DepositHistoryProvider call(String userId) =>
      DepositHistoryProvider._(argument: userId, from: this);

  @override
  String toString() => r'depositHistoryProvider';
}

/// Deposit statistics provider (admin)

@ProviderFor(depositStatistics)
const depositStatisticsProvider = DepositStatisticsProvider._();

/// Deposit statistics provider (admin)

final class DepositStatisticsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  /// Deposit statistics provider (admin)
  const DepositStatisticsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'depositStatisticsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$depositStatisticsHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    return depositStatistics(ref);
  }
}

String _$depositStatisticsHash() => r'db4ccd5460b5402777c18859c1a6540cf60de882';

/// Deposit action notifier for managing deposits

@ProviderFor(DepositActions)
const depositActionsProvider = DepositActionsProvider._();

/// Deposit action notifier for managing deposits
final class DepositActionsProvider
    extends $AsyncNotifierProvider<DepositActions, void> {
  /// Deposit action notifier for managing deposits
  const DepositActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'depositActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$depositActionsHash();

  @$internal
  @override
  DepositActions create() => DepositActions();
}

String _$depositActionsHash() => r'21d1f8c639129f54ce868258452d4ed557f14429';

/// Deposit action notifier for managing deposits

abstract class _$DepositActions extends $AsyncNotifier<void> {
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
