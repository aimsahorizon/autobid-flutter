// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Subscription service provider

@ProviderFor(subscriptionService)
const subscriptionServiceProvider = SubscriptionServiceProvider._();

/// Subscription service provider

final class SubscriptionServiceProvider
    extends
        $FunctionalProvider<
          MockSubscriptionService,
          MockSubscriptionService,
          MockSubscriptionService
        >
    with $Provider<MockSubscriptionService> {
  /// Subscription service provider
  const SubscriptionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subscriptionServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subscriptionServiceHash();

  @$internal
  @override
  $ProviderElement<MockSubscriptionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MockSubscriptionService create(Ref ref) {
    return subscriptionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MockSubscriptionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MockSubscriptionService>(value),
    );
  }
}

String _$subscriptionServiceHash() =>
    r'c20deb2f2182be7b1a4a918e3a2ead684d227422';

/// Current user's subscription provider

@ProviderFor(userSubscription)
const userSubscriptionProvider = UserSubscriptionFamily._();

/// Current user's subscription provider

final class UserSubscriptionProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserSubscription?>,
          UserSubscription?,
          FutureOr<UserSubscription?>
        >
    with
        $FutureModifier<UserSubscription?>,
        $FutureProvider<UserSubscription?> {
  /// Current user's subscription provider
  const UserSubscriptionProvider._({
    required UserSubscriptionFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userSubscriptionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userSubscriptionHash();

  @override
  String toString() {
    return r'userSubscriptionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<UserSubscription?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UserSubscription?> create(Ref ref) {
    final argument = this.argument as String;
    return userSubscription(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserSubscriptionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userSubscriptionHash() => r'd72e85019cdcaf88ed3a73dd6667aa1c27398dbc';

/// Current user's subscription provider

final class UserSubscriptionFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<UserSubscription?>, String> {
  const UserSubscriptionFamily._()
    : super(
        retry: null,
        name: r'userSubscriptionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Current user's subscription provider

  UserSubscriptionProvider call(String userId) =>
      UserSubscriptionProvider._(argument: userId, from: this);

  @override
  String toString() => r'userSubscriptionProvider';
}

/// Current user's subscription tier provider

@ProviderFor(userSubscriptionTier)
const userSubscriptionTierProvider = UserSubscriptionTierFamily._();

/// Current user's subscription tier provider

final class UserSubscriptionTierProvider
    extends
        $FunctionalProvider<
          AsyncValue<SubscriptionTierType>,
          SubscriptionTierType,
          FutureOr<SubscriptionTierType>
        >
    with
        $FutureModifier<SubscriptionTierType>,
        $FutureProvider<SubscriptionTierType> {
  /// Current user's subscription tier provider
  const UserSubscriptionTierProvider._({
    required UserSubscriptionTierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userSubscriptionTierProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userSubscriptionTierHash();

  @override
  String toString() {
    return r'userSubscriptionTierProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SubscriptionTierType> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SubscriptionTierType> create(Ref ref) {
    final argument = this.argument as String;
    return userSubscriptionTier(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserSubscriptionTierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userSubscriptionTierHash() =>
    r'83541ec3c1d830f0caf43b5e78aa6723ba91c51e';

/// Current user's subscription tier provider

final class UserSubscriptionTierFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<SubscriptionTierType>, String> {
  const UserSubscriptionTierFamily._()
    : super(
        retry: null,
        name: r'userSubscriptionTierProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Current user's subscription tier provider

  UserSubscriptionTierProvider call(String userId) =>
      UserSubscriptionTierProvider._(argument: userId, from: this);

  @override
  String toString() => r'userSubscriptionTierProvider';
}

/// Available subscription tiers provider

@ProviderFor(availableSubscriptionTiers)
const availableSubscriptionTiersProvider =
    AvailableSubscriptionTiersProvider._();

/// Available subscription tiers provider

final class AvailableSubscriptionTiersProvider
    extends
        $FunctionalProvider<
          List<SubscriptionTier>,
          List<SubscriptionTier>,
          List<SubscriptionTier>
        >
    with $Provider<List<SubscriptionTier>> {
  /// Available subscription tiers provider
  const AvailableSubscriptionTiersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'availableSubscriptionTiersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availableSubscriptionTiersHash();

  @$internal
  @override
  $ProviderElement<List<SubscriptionTier>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<SubscriptionTier> create(Ref ref) {
    return availableSubscriptionTiers(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<SubscriptionTier> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<SubscriptionTier>>(value),
    );
  }
}

String _$availableSubscriptionTiersHash() =>
    r'acc02a10dc91ef7c9f89798cd317133c5d648b5b';

/// Subscription benefits summary provider

@ProviderFor(subscriptionBenefits)
const subscriptionBenefitsProvider = SubscriptionBenefitsFamily._();

/// Subscription benefits summary provider

final class SubscriptionBenefitsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  /// Subscription benefits summary provider
  const SubscriptionBenefitsProvider._({
    required SubscriptionBenefitsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'subscriptionBenefitsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$subscriptionBenefitsHash();

  @override
  String toString() {
    return r'subscriptionBenefitsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    final argument = this.argument as String;
    return subscriptionBenefits(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SubscriptionBenefitsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$subscriptionBenefitsHash() =>
    r'80392202a5a7c43b4b2b05a81e8e5821192ff4a0';

/// Subscription benefits summary provider

final class SubscriptionBenefitsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Map<String, dynamic>>, String> {
  const SubscriptionBenefitsFamily._()
    : super(
        retry: null,
        name: r'subscriptionBenefitsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Subscription benefits summary provider

  SubscriptionBenefitsProvider call(String userId) =>
      SubscriptionBenefitsProvider._(argument: userId, from: this);

  @override
  String toString() => r'subscriptionBenefitsProvider';
}

/// Check if user can place bid provider

@ProviderFor(canPlaceBid)
const canPlaceBidProvider = CanPlaceBidFamily._();

/// Check if user can place bid provider

final class CanPlaceBidProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Check if user can place bid provider
  const CanPlaceBidProvider._({
    required CanPlaceBidFamily super.from,
    required (String, int) super.argument,
  }) : super(
         retry: null,
         name: r'canPlaceBidProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$canPlaceBidHash();

  @override
  String toString() {
    return r'canPlaceBidProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as (String, int);
    return canPlaceBid(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is CanPlaceBidProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$canPlaceBidHash() => r'8e3e2c9c7c1ab7a0a390446b7b03c316ace2d893';

/// Check if user can place bid provider

final class CanPlaceBidFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool>, (String, int)> {
  const CanPlaceBidFamily._()
    : super(
        retry: null,
        name: r'canPlaceBidProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Check if user can place bid provider

  CanPlaceBidProvider call(String userId, int currentActiveBids) =>
      CanPlaceBidProvider._(argument: (userId, currentActiveBids), from: this);

  @override
  String toString() => r'canPlaceBidProvider';
}

/// Check if user can create listing provider

@ProviderFor(canCreateListing)
const canCreateListingProvider = CanCreateListingFamily._();

/// Check if user can create listing provider

final class CanCreateListingProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Check if user can create listing provider
  const CanCreateListingProvider._({
    required CanCreateListingFamily super.from,
    required (String, int) super.argument,
  }) : super(
         retry: null,
         name: r'canCreateListingProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$canCreateListingHash();

  @override
  String toString() {
    return r'canCreateListingProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as (String, int);
    return canCreateListing(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is CanCreateListingProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$canCreateListingHash() => r'c5e49dba7b81dca8ada4879b82960d55887bd114';

/// Check if user can create listing provider

final class CanCreateListingFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool>, (String, int)> {
  const CanCreateListingFamily._()
    : super(
        retry: null,
        name: r'canCreateListingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Check if user can create listing provider

  CanCreateListingProvider call(String userId, int currentActiveListings) =>
      CanCreateListingProvider._(
        argument: (userId, currentActiveListings),
        from: this,
      );

  @override
  String toString() => r'canCreateListingProvider';
}

/// Check if user's listing quota needs reset (rolling 30-day)

@ProviderFor(needsQuotaReset)
const needsQuotaResetProvider = NeedsQuotaResetFamily._();

/// Check if user's listing quota needs reset (rolling 30-day)

final class NeedsQuotaResetProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Check if user's listing quota needs reset (rolling 30-day)
  const NeedsQuotaResetProvider._({
    required NeedsQuotaResetFamily super.from,
    required UserModel super.argument,
  }) : super(
         retry: null,
         name: r'needsQuotaResetProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$needsQuotaResetHash();

  @override
  String toString() {
    return r'needsQuotaResetProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as UserModel;
    return needsQuotaReset(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is NeedsQuotaResetProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$needsQuotaResetHash() => r'86bfdb64c50324df3a7047de7411a290d17a0198';

/// Check if user's listing quota needs reset (rolling 30-day)

final class NeedsQuotaResetFamily extends $Family
    with $FunctionalFamilyOverride<bool, UserModel> {
  const NeedsQuotaResetFamily._()
    : super(
        retry: null,
        name: r'needsQuotaResetProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Check if user's listing quota needs reset (rolling 30-day)

  NeedsQuotaResetProvider call(UserModel user) =>
      NeedsQuotaResetProvider._(argument: user, from: this);

  @override
  String toString() => r'needsQuotaResetProvider';
}

/// Get remaining listing quota for user

@ProviderFor(remainingListingQuota)
const remainingListingQuotaProvider = RemainingListingQuotaFamily._();

/// Get remaining listing quota for user

final class RemainingListingQuotaProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Get remaining listing quota for user
  const RemainingListingQuotaProvider._({
    required RemainingListingQuotaFamily super.from,
    required UserModel super.argument,
  }) : super(
         retry: null,
         name: r'remainingListingQuotaProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$remainingListingQuotaHash();

  @override
  String toString() {
    return r'remainingListingQuotaProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    final argument = this.argument as UserModel;
    return remainingListingQuota(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RemainingListingQuotaProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$remainingListingQuotaHash() =>
    r'89b883dd0dcfcb0370b739f6b27ede07d7cb7d5c';

/// Get remaining listing quota for user

final class RemainingListingQuotaFamily extends $Family
    with $FunctionalFamilyOverride<int, UserModel> {
  const RemainingListingQuotaFamily._()
    : super(
        retry: null,
        name: r'remainingListingQuotaProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Get remaining listing quota for user

  RemainingListingQuotaProvider call(UserModel user) =>
      RemainingListingQuotaProvider._(argument: user, from: this);

  @override
  String toString() => r'remainingListingQuotaProvider';
}

/// Check if user can create listing (REVISED - monthly quota)

@ProviderFor(canCreateListingRevised)
const canCreateListingRevisedProvider = CanCreateListingRevisedFamily._();

/// Check if user can create listing (REVISED - monthly quota)

final class CanCreateListingRevisedProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Check if user can create listing (REVISED - monthly quota)
  const CanCreateListingRevisedProvider._({
    required CanCreateListingRevisedFamily super.from,
    required UserModel super.argument,
  }) : super(
         retry: null,
         name: r'canCreateListingRevisedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$canCreateListingRevisedHash();

  @override
  String toString() {
    return r'canCreateListingRevisedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    final argument = this.argument as UserModel;
    return canCreateListingRevised(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CanCreateListingRevisedProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$canCreateListingRevisedHash() =>
    r'6b90a85d04953610c605d3b4ac4c6c86a491d7a1';

/// Check if user can create listing (REVISED - monthly quota)

final class CanCreateListingRevisedFamily extends $Family
    with $FunctionalFamilyOverride<bool, UserModel> {
  const CanCreateListingRevisedFamily._()
    : super(
        retry: null,
        name: r'canCreateListingRevisedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Check if user can create listing (REVISED - monthly quota)

  CanCreateListingRevisedProvider call(UserModel user) =>
      CanCreateListingRevisedProvider._(argument: user, from: this);

  @override
  String toString() => r'canCreateListingRevisedProvider';
}

/// Calculate extra listing fee for Free tier

@ProviderFor(extraListingFee)
const extraListingFeeProvider = ExtraListingFeeFamily._();

/// Calculate extra listing fee for Free tier

final class ExtraListingFeeProvider
    extends $FunctionalProvider<double, double, double>
    with $Provider<double> {
  /// Calculate extra listing fee for Free tier
  const ExtraListingFeeProvider._({
    required ExtraListingFeeFamily super.from,
    required UserModel super.argument,
  }) : super(
         retry: null,
         name: r'extraListingFeeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$extraListingFeeHash();

  @override
  String toString() {
    return r'extraListingFeeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<double> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  double create(Ref ref) {
    final argument = this.argument as UserModel;
    return extraListingFee(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ExtraListingFeeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$extraListingFeeHash() => r'fa5c2087626b3ca87867440f3f2c17630e977c9d';

/// Calculate extra listing fee for Free tier

final class ExtraListingFeeFamily extends $Family
    with $FunctionalFamilyOverride<double, UserModel> {
  const ExtraListingFeeFamily._()
    : super(
        retry: null,
        name: r'extraListingFeeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Calculate extra listing fee for Free tier

  ExtraListingFeeProvider call(UserModel user) =>
      ExtraListingFeeProvider._(argument: user, from: this);

  @override
  String toString() => r'extraListingFeeProvider';
}

/// Subscription action notifier for managing subscriptions

@ProviderFor(SubscriptionActions)
const subscriptionActionsProvider = SubscriptionActionsProvider._();

/// Subscription action notifier for managing subscriptions
final class SubscriptionActionsProvider
    extends $AsyncNotifierProvider<SubscriptionActions, void> {
  /// Subscription action notifier for managing subscriptions
  const SubscriptionActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subscriptionActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subscriptionActionsHash();

  @$internal
  @override
  SubscriptionActions create() => SubscriptionActions();
}

String _$subscriptionActionsHash() =>
    r'234e02df93722be78612d3b4a6d6e3c0b79f2e1d';

/// Subscription action notifier for managing subscriptions

abstract class _$SubscriptionActions extends $AsyncNotifier<void> {
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
