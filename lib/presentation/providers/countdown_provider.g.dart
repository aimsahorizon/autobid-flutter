// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countdown_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Global countdown provider - Single timer for all countdowns
/// Replaces 20+ individual timers with one efficient global timer

@ProviderFor(CountdownNotifier)
const countdownProvider = CountdownNotifierProvider._();

/// Global countdown provider - Single timer for all countdowns
/// Replaces 20+ individual timers with one efficient global timer
final class CountdownNotifierProvider
    extends $NotifierProvider<CountdownNotifier, CountdownState> {
  /// Global countdown provider - Single timer for all countdowns
  /// Replaces 20+ individual timers with one efficient global timer
  const CountdownNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'countdownProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$countdownNotifierHash();

  @$internal
  @override
  CountdownNotifier create() => CountdownNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CountdownState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CountdownState>(value),
    );
  }
}

String _$countdownNotifierHash() => r'0ed62bb523b352584ef1b98b4ec6d8510aeeaddb';

/// Global countdown provider - Single timer for all countdowns
/// Replaces 20+ individual timers with one efficient global timer

abstract class _$CountdownNotifier extends $Notifier<CountdownState> {
  CountdownState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CountdownState, CountdownState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CountdownState, CountdownState>,
              CountdownState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Individual countdown provider for specific ID

@ProviderFor(countdownById)
const countdownByIdProvider = CountdownByIdFamily._();

/// Individual countdown provider for specific ID

final class CountdownByIdProvider
    extends $FunctionalProvider<Duration?, Duration?, Duration?>
    with $Provider<Duration?> {
  /// Individual countdown provider for specific ID
  const CountdownByIdProvider._({
    required CountdownByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'countdownByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$countdownByIdHash();

  @override
  String toString() {
    return r'countdownByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Duration?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Duration? create(Ref ref) {
    final argument = this.argument as String;
    return countdownById(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Duration? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Duration?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CountdownByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$countdownByIdHash() => r'3d3a03c413e2e7d69af8fba5dddd16329762b0f9';

/// Individual countdown provider for specific ID

final class CountdownByIdFamily extends $Family
    with $FunctionalFamilyOverride<Duration?, String> {
  const CountdownByIdFamily._()
    : super(
        retry: null,
        name: r'countdownByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Individual countdown provider for specific ID

  CountdownByIdProvider call(String id) =>
      CountdownByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'countdownByIdProvider';
}
