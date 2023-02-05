import 'package:flutter/material.dart';
import '../theme/theme.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    Key? key,
    required this.price,
    this.spacing,
  }) : super(key: key);

  final int price;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$price",
          style: PomodoroTheme.textLargeYellow,
        ),
        SizedBox(
          width: spacing ?? 10,
        ),
        const Icon(
          Icons.circle,
          color: PomodoroTheme.primary,
        ),
      ],
    );
  }
}
