import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class SimpleCard extends StatelessWidget {
  final String message;
  final Color color;
  final Color textColor;
  final int textSize;
  const SimpleCard({
    super.key,
    required this.message,
    required this.color,
    required this.textColor,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message, style: TextStyle(color: textColor, fontSize: textSize.toDouble())),
          ],
        ),
      ),
    );
  }
}
