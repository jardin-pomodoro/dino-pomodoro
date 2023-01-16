import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screen/pomodoro_screen/pomodoro_screen.dart';

abstract class Timer {
  Stream<Duration> start(Duration period);
}

class DefaultTimer extends Timer {
  @override
  Stream<Duration> start(Duration period) async* {
    Duration timer = period;
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      timer = timer - const Duration(seconds: 1);
      yield timer;
      if (timer == Duration.zero) {
        return;
      }
    }
  }
}

final timerProvider = Provider<Timer>((ref) => DefaultTimer());

final tickerProvider = StreamProvider<Duration>((ref) {
  final timer = ref.watch(timerProvider);
  return timer.start(defaultPeriod);
});
