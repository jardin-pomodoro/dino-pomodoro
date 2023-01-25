import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/screen/growing_screen/growing_screen_widget.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CircularProgressTimer extends StatelessWidget {
  final Duration remainingTime;
  final Widget children;

  const CircularProgressTimer({
    Key? key,
    required this.remainingTime,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        startAngle: 270,
        angleRange: 360,
        size: 250,
        customColors: CustomSliderColors(
          shadowStep: 5,
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
      innerWidget: (double value) {
        return children;
      },
    );
  }
}
