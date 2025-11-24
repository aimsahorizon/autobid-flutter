// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for onboarding service

@ProviderFor(onboardingService)
const onboardingServiceProvider = OnboardingServiceProvider._();

/// Provider for onboarding service

final class OnboardingServiceProvider
    extends
        $FunctionalProvider<
          OnboardingService,
          OnboardingService,
          OnboardingService
        >
    with $Provider<OnboardingService> {
  /// Provider for onboarding service
  const OnboardingServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingServiceHash();

  @$internal
  @override
  $ProviderElement<OnboardingService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OnboardingService create(Ref ref) {
    return onboardingService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingService>(value),
    );
  }
}

String _$onboardingServiceHash() => r'7f70b969772aae39b5be75908e4fc27c683d4a97';

/// Provider for onboarding completion status

@ProviderFor(hasCompletedOnboarding)
const hasCompletedOnboardingProvider = HasCompletedOnboardingProvider._();

/// Provider for onboarding completion status

final class HasCompletedOnboardingProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Provider for onboarding completion status
  const HasCompletedOnboardingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hasCompletedOnboardingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hasCompletedOnboardingHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return hasCompletedOnboarding(ref);
  }
}

String _$hasCompletedOnboardingHash() =>
    r'ff4845c420548139efb5f4203dd1bc56497642c7';

/// Sync state provider for onboarding status (for router redirect)
/// This provider is used by the router for synchronous access to onboarding status

@ProviderFor(OnboardingCompleted)
const onboardingCompletedProvider = OnboardingCompletedProvider._();

/// Sync state provider for onboarding status (for router redirect)
/// This provider is used by the router for synchronous access to onboarding status
final class OnboardingCompletedProvider
    extends $NotifierProvider<OnboardingCompleted, bool> {
  /// Sync state provider for onboarding status (for router redirect)
  /// This provider is used by the router for synchronous access to onboarding status
  const OnboardingCompletedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingCompletedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingCompletedHash();

  @$internal
  @override
  OnboardingCompleted create() => OnboardingCompleted();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$onboardingCompletedHash() =>
    r'cae97bc107162af02c99fdea79d7b14eb255f25c';

/// Sync state provider for onboarding status (for router redirect)
/// This provider is used by the router for synchronous access to onboarding status

abstract class _$OnboardingCompleted extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider for onboarding pages data

@ProviderFor(onboardingPages)
const onboardingPagesProvider = OnboardingPagesProvider._();

/// Provider for onboarding pages data

final class OnboardingPagesProvider
    extends
        $FunctionalProvider<
          List<OnboardingPageModel>,
          List<OnboardingPageModel>,
          List<OnboardingPageModel>
        >
    with $Provider<List<OnboardingPageModel>> {
  /// Provider for onboarding pages data
  const OnboardingPagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingPagesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingPagesHash();

  @$internal
  @override
  $ProviderElement<List<OnboardingPageModel>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<OnboardingPageModel> create(Ref ref) {
    return onboardingPages(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<OnboardingPageModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<OnboardingPageModel>>(value),
    );
  }
}

String _$onboardingPagesHash() => r'690221609c7f47d6c901c5588f113df5dbb311bf';
