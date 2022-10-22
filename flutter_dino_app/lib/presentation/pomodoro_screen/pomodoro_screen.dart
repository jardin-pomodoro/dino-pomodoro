import 'package:flutter/material.dart';

const Duration defaultPeriod = Duration(minutes: 1);

double computeCurrentValue(Duration remainingTime) {
  final gap = defaultPeriod.inSeconds - remainingTime.inSeconds;
  return gap.toDouble();
}

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context) => Container();
}
