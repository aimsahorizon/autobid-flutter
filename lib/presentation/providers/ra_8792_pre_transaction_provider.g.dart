// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ra_8792_pre_transaction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// RA 8792 compliant pre-transaction provider
/// Manages the entire pre-transaction workflow with legal compliance

@ProviderFor(Ra8792PreTransactionNotifier)
const ra8792PreTransactionProvider = Ra8792PreTransactionNotifierFamily._();

/// RA 8792 compliant pre-transaction provider
/// Manages the entire pre-transaction workflow with legal compliance
final class Ra8792PreTransactionNotifierProvider
    extends $NotifierProvider<Ra8792PreTransactionNotifier, PreTransaction?> {
  /// RA 8792 compliant pre-transaction provider
  /// Manages the entire pre-transaction workflow with legal compliance
  const Ra8792PreTransactionNotifierProvider._({
    required Ra8792PreTransactionNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'ra8792PreTransactionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ra8792PreTransactionNotifierHash();

  @override
  String toString() {
    return r'ra8792PreTransactionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Ra8792PreTransactionNotifier create() => Ra8792PreTransactionNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PreTransaction? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PreTransaction?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Ra8792PreTransactionNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ra8792PreTransactionNotifierHash() =>
    r'a21539c037517c81b29accf9da699a0472b8a1f3';

/// RA 8792 compliant pre-transaction provider
/// Manages the entire pre-transaction workflow with legal compliance

final class Ra8792PreTransactionNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          Ra8792PreTransactionNotifier,
          PreTransaction?,
          PreTransaction?,
          PreTransaction?,
          String
        > {
  const Ra8792PreTransactionNotifierFamily._()
    : super(
        retry: null,
        name: r'ra8792PreTransactionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// RA 8792 compliant pre-transaction provider
  /// Manages the entire pre-transaction workflow with legal compliance

  Ra8792PreTransactionNotifierProvider call(String preTransactionId) =>
      Ra8792PreTransactionNotifierProvider._(
        argument: preTransactionId,
        from: this,
      );

  @override
  String toString() => r'ra8792PreTransactionProvider';
}

/// RA 8792 compliant pre-transaction provider
/// Manages the entire pre-transaction workflow with legal compliance

abstract class _$Ra8792PreTransactionNotifier
    extends $Notifier<PreTransaction?> {
  late final _$args = ref.$arg as String;
  String get preTransactionId => _$args;

  PreTransaction? build(String preTransactionId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<PreTransaction?, PreTransaction?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PreTransaction?, PreTransaction?>,
              PreTransaction?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
