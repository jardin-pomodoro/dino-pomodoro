import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CircularProgressTimer extends StatelessWidget {
  final int remainingTime;
  final int initialTime;
  final Widget children;

  const CircularProgressTimer({
    Key? key,
    required this.initialTime,
    required this.remainingTime,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        startAngle: 270,
        angleRange: 360,
        size: 350,
        customColors: CustomSliderColors(
          shadowStep: 5,
          progressBarColor: Colors.green,
          trackColor: PomodoroTheme.darkGreen,
        ),
        customWidths: CustomSliderWidths(
          progressBarWidth: 9,
          trackWidth: 7,
        ),
      ),
      min: 0,
      max: initialTime.toDouble(),
      initialValue: initialTime.toDouble() - remainingTime.toDouble(),
      innerWidget: (double value) {
        return children;
      },
    );
  }
}
