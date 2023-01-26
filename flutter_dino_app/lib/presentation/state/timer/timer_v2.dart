import 'dart:async';

import 'package:flutter_dino_app/utils/upgrade_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  TimerNotifier()
      : super(
          TimerModel(
            timeLeft: durationString(0),
            initialDuration: 0,
            durationLeft: 0,
            isRunning: false,
          ),
        );

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

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    super.dispose();
  }
}

final timerNotifierProvider = StateNotifierProvider<TimerNotifier, TimerModel>(
  (ref) => TimerNotifier(),
);

final timerStreamProvider = StreamProvider<TimerModel>((ref) {
  final timer = ref.watch(timerNotifierProvider);
  return Stream.periodic(
    const Duration(seconds: 1),
    (x) => timer,
  );
});
