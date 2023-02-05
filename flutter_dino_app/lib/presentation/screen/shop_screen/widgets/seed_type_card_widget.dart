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
    return Column(
      children: [
        Card(
          color: PomodoroTheme.accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: PomodoroTheme.secondary,
              width: 2,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Image.network(
                  seedType.image,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                Text(
                  seedType.name,
                  style: PomodoroTheme.title3,
                ),
                const SizedBox(
                  height: 10,
                ),
                bought
                    ? const Text("Acheté", style: PomodoroTheme.textLarge)
                    : PriceWidget(price: seedType.price),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
