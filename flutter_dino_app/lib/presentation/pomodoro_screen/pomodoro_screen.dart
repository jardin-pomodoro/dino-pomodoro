import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/widgets/circular_progress_indicator.dart';
import 'package:flutter_dino_app/utils/duration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/timer/timer.dart';

const Duration defaultPeriod = Duration(hours: 1);

double computeCurrentValue(Duration remainingTime) {
  final gap = defaultPeriod.inSeconds - remainingTime.inSeconds;
  return gap.toDouble();
}

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dino Pomodoro'),
      ),
      body: Center(
        child: CircularProgressTimer(
          remainingTime: remainingTime,
          children: Center(
            child: Text(
              remainingTime.inSecondsWithMinutes(),
              style: const TextStyle(
                fontSize: 40,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
