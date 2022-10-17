import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

final timerProvider = StateNotifierProvider((ref) => TimerNotifier());
final test = StateProvider((ref) {});

class TimerNotifier extends StateNotifier<String> {
  final Stopwatch _stopwatch = Stopwatch();
  TimerNotifier() : super("00:00:00") {
    _stopwatch.start();
  }
}

class PomodoroScreen extends ConsumerWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        return Center(child: Text(value.toString()));
        // use your custom widget inside the slider (gets a slider value from the callback)
      },
    );
    final timer = ref.watch(timerProvider);
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
