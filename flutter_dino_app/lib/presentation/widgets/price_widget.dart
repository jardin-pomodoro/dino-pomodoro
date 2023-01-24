import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    Key? key,
    required this.price,
  }) : super(key: key);

  final int price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$price",
          style: PomodoroTheme.textLarge,
        ),
        const SizedBox(
          width: 10,
        ),
        const Icon(
          Icons.circle,
          color: PomodoroTheme.yellow,
        ),
      ],
    );
  }
}