import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timerProvider = StateNotifierProvider((ref) => TimerNotifier());
final test = StateProvider((ref) {});

class TimerNotifier extends StateNotifier<String> {
  final Stopwatch _stopwatch = Stopwatch();
  final Ticker _ticker = Ticker((elapsed) => print(elapsed));
  TimerNotifier() : super("00:00:00") {
    _stopwatch.start();
  }
}

class PomodoroScreen extends ConsumerWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(timerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro'),
      ),
      body: Center(
        child: Text(timer.toString()),
      ),
    );
  }
}
