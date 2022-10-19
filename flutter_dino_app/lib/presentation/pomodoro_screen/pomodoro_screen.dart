import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

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
  const startDuration = Duration(minutes: 25);
  return timer.start(startDuration);
});

class PomodoroScreen extends ConsumerWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Duration> timer = ref.watch(tickerProvider);
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
      max: 60,
      initialValue: 10,
      onChange: (double value) {
        // callback providing a value while its being changed (with a pan gesture)
      },
      onChangeStart: (double startValue) {
        // callback providing a starting value (when a pan gesture starts)
      },
      onChangeEnd: (double endValue) {
        // ucallback providing an ending value (when a pan gesture ends)
      },
      innerWidget: (double value) {
        final res = timer.when(
          data: (Duration value) => value,
          error: (Object e, _) => e,
          loading: () => 0, // Make default value
        );
        return Center(child: Text(res.toString()));
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
