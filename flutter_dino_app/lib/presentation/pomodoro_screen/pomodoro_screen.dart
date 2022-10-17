import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

abstract class Timer {
  Stream<int> start();
  void stop();
  void reset();
}

class DefaultTimer extends Timer {
  @override
  Stream<int> start() async* {
    int i = 0;
    while (true) {
      yield i++;
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  void reset() {}

  @override
  void stop() {}
}

final timerProvider = Provider<Timer>((ref) => DefaultTimer());

final tickerProvider = StreamProvider<int>((ref) {
  final timer = ref.watch(timerProvider);
  return timer.start();
});

class PomodoroScreen extends ConsumerWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<int> timer = ref.watch(tickerProvider);
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
          data: (int value) => value,
          error: (Object e, _) => e,
          loading: () => 0,
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
