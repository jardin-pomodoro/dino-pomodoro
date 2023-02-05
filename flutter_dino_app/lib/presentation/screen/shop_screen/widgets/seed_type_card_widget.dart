import 'package:flutter/material.dart';

import '../../../../domain/models/seed_type.dart';
import '../../../theme/theme.dart';
import '../../../widgets/price_widget.dart';

class SeedTypeCardWidget extends StatelessWidget {
  final SeedType seedType;
  final bool bought;

  const SeedTypeCardWidget({
    Key? key,
    required this.seedType,
    required this.bought,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: PomodoroTheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: PomodoroTheme.green,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.network(
              seedType.image,
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
            cardTitle(seedType.name),
            const SizedBox(
              height: 10,
            ),
            bought
                ? const Text("Acheté", style: PomodoroTheme.textLargeYellow)
                : PriceWidget(price: seedType.price),
          ],
        ),
      ),
    );
  }

  Widget cardTitle(String title) {
    const maxLineLength = 12;
    if (title.length > maxLineLength) {
      return Text(
        title,
        style: PomodoroTheme.title5Yellow,
      );
    }
    return Text(
      title,
      style: PomodoroTheme.title3Yellow,
    );
  }
}
