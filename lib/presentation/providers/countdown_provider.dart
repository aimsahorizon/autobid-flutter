import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'countdown_provider.g.dart';

/// Global countdown state model
class CountdownState {
  final Map<String, Duration> remainingTimes;
  final DateTime lastUpdate;

  const CountdownState({
    required this.remainingTimes,
    required this.lastUpdate,
  });

  CountdownState copyWith({
    Map<String, Duration>? remainingTimes,
    DateTime? lastUpdate,
  }) {
    return CountdownState(
      remainingTimes: remainingTimes ?? this.remainingTimes,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }
}

/// Global countdown provider - Single timer for all countdowns
/// Replaces 20+ individual timers with one efficient global timer
@Riverpod(keepAlive: true)
class CountdownNotifier extends _$CountdownNotifier {
  @override
  CountdownState build() {
    // Initialize with empty state
    final state = CountdownState(
      remainingTimes: {},
      lastUpdate: DateTime.now(),
    );

    // Start single global timer
    _startGlobalTimer();

    return state;
  }

  void _startGlobalTimer() {
    // OPTIMIZED: Single timer updates all countdowns every 1 MINUTE
    // This significantly reduces CPU usage and battery drain
    // UI shows hours/minutes only, no seconds needed
    Stream.periodic(const Duration(minutes: 1)).listen((_) {
      if (state.remainingTimes.isEmpty) return;

      final now = DateTime.now();
      final updatedTimes = <String, Duration>{};

      // Update all registered countdowns in one pass
      state.remainingTimes.forEach((key, remaining) {
        final newRemaining = remaining - const Duration(minutes: 1);
        if (newRemaining.isNegative) {
          updatedTimes[key] = Duration.zero;
        } else {
          updatedTimes[key] = newRemaining;
        }
      });

      state = CountdownState(
        remainingTimes: updatedTimes,
        lastUpdate: now,
      );
    });
  }

  /// Register a countdown with its end time
  void register(String id, DateTime endTime) {
    final now = DateTime.now();
    final remaining = endTime.difference(now);

    state = state.copyWith(
      remainingTimes: {...state.remainingTimes, id: remaining},
      lastUpdate: now,
    );
  }

  /// Unregister a countdown when widget is disposed
  void unregister(String id) {
    final updated = Map<String, Duration>.from(state.remainingTimes)
      ..remove(id);
    state = state.copyWith(remainingTimes: updated);
  }

  /// Get remaining time for specific countdown
  Duration? getRemaining(String id) {
    return state.remainingTimes[id];
  }
}

/// Individual countdown provider for specific ID
@riverpod
Duration? countdownById(Ref ref, String id) {
  final state = ref.watch(countdownProvider);
  return state.remainingTimes[id];
}
