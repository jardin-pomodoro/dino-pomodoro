import 'package:flutter/material.dart';

import '../theme/theme.dart';

class PriceWidget extends StatelessWidget {
  final TextStyle style;
  const PriceWidget({
    Key? key,
    this.style = PomodoroTheme.textLargeYellow,
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
          style: style,
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
