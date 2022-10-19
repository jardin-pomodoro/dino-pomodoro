import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

const Duration defaultPeriod = Duration(minutes: 5);

extension GetAsString on Duration {
  String inSecondWithMinutes() {
    final Duration duration = this;
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    } else {
      return '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    }
  }
}

double computeCurrentValue(Duration remainingTime) {
  final gap = defaultPeriod.inSeconds - remainingTime.inSeconds;
  return gap.toDouble();
}

abstract class Timer {
  Stream<Duration> start(Duration period);
  void stop();
  void reset();
}

class DefaultTimer extends Timer {
  @override
  Stream<Duration> start(Duration period) async* {
    Duration timer = period;
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      timer = timer - const Duration(seconds: 1);
      yield timer;
    }
  }

  @override
  void reset() {}

  @override
  void stop() {}
}

final timerProvider = Provider<Timer>((ref) => DefaultTimer());

final tickerProvider = StreamProvider<Duration>((ref) {
  final timer = ref.watch(timerProvider);
  return timer.start(defaultPeriod);
});

class PomodoroScreen extends ConsumerWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Duration> timer = ref.watch(tickerProvider);
    final Duration remainingTime = timer.when(
      data: (Duration value) => value,
      error: (Object e, _) {
        print(e); // TODO add logger
        return defaultPeriod;
      },
      loading: () => defaultPeriod,
    );
    final slider = SleekCircularSlider(
      appearance: CircularSliderAppearance(
        startAngle: 270,
        angleRange: 360,
        size: 250,
        customColors: CustomSliderColors(
          shadowStep: 12,
          progressBarColor: Colors.purpleAccent,
          trackColor: Colors.purple,
        ),
        customWidths: CustomSliderWidths(
          progressBarWidth: 15,
          trackWidth: 12,
        ),
      ),
      min: 0,
      max: defaultPeriod.inSeconds.toDouble(),
      initialValue: computeCurrentValue(remainingTime),
      onChange: (value) {
        print(value);
      },
      innerWidget: (double value) {
        print('value: $value');
        return Center(child: Text(remainingTime.inSecondWithMinutes()));
        // use your custom widget inside the slider (gets a slider value from the callback)
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro'),
      ),
      body: Center(
        child: slider,
      ),
    );
  }
}
