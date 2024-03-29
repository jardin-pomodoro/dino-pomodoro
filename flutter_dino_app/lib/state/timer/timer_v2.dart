import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/upgrade_functions.dart';

class Ticker {
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (x) => ticks - x - 1,
    ).take(ticks);
  }
}

class TimerModel {
  final String timeLeft;
  final int initialDuration;
  final int durationLeft;
  final bool isRunning;

  const TimerModel({
    required this.timeLeft,
    required this.isRunning,
    required this.initialDuration,
    required this.durationLeft,
  });
}

class TimerNotifier extends StateNotifier<TimerModel> {
  static final _initialState = TimerModel(
    timeLeft: durationString(1),
    initialDuration: 1,
    durationLeft: 0,
    isRunning: false,
  );

  TimerNotifier() : super(_initialState);

  final Ticker _ticker = Ticker();
  StreamSubscription<int>? _tickerSubscription;

  void start(int initialDuration) {
    _tickerSubscription?.cancel();

    _tickerSubscription =
        _ticker.tick(ticks: initialDuration).listen((duration) {
      state = TimerModel(
        timeLeft: durationString(duration),
        initialDuration: initialDuration,
        durationLeft: duration,
        isRunning: true,
      );
    });

    _tickerSubscription?.onDone(() {
      state = TimerModel(
        timeLeft: state.timeLeft,
        initialDuration: initialDuration,
        durationLeft: 0,
        isRunning: false,
      );
    });

    state = TimerModel(
      timeLeft: durationString(initialDuration),
      initialDuration: initialDuration,
      durationLeft: initialDuration,
      isRunning: true,
    );
  }

  void stop() {
    _tickerSubscription?.cancel();
    state = TimerModel(
      timeLeft: state.timeLeft,
      initialDuration: state.initialDuration,
      durationLeft: state.durationLeft,
      isRunning: false,
    );
  }

  void reset() {
    _tickerSubscription?.cancel();
    state = _initialState;
  }

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    super.dispose();
  }
}

final timerNotifierProvider = StateNotifierProvider<TimerNotifier, TimerModel>(
  (ref) => TimerNotifier(),
);
