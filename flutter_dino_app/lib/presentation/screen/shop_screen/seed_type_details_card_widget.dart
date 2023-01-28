import 'package:flutter/material.dart';
import 'package:flutter_dino_app/domain/models/seed_type.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:flutter_dino_app/presentation/widgets/price_widget.dart';

class SeedTypeDetailsCardWidget extends StatelessWidget {
  final SeedType seedType;

  const SeedTypeDetailsCardWidget({Key? key, required this.seedType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          color: PomodoroTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: PomodoroTheme.white,
              width: 2,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Image.network(seedType.image, height: 200),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  seedType.name,
                  style: PomodoroTheme.title2,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      direction: Axis.vertical,
                      spacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: const [
                        Text(
                          "Temps de pousse",
                          style: PomodoroTheme.textLarge,
                        ),
                        Text(
                          "Récompense",
                          style: PomodoroTheme.textLarge,
                        ),
                        Text(
                          "Amélioration feuilles max",
                          style: PomodoroTheme.textLarge,
                        ),
                        Text(
                          "Amélioration tronc max",
                          style: PomodoroTheme.textLarge,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      spacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Text(
                          "${seedType.timeToGrow} min",
                          style: PomodoroTheme.textLarge,
                        ),
                        PriceWidget(price: seedType.reward),
                        Text(
                          "${seedType.leafMaxUpgrades}",
                          style: PomodoroTheme.textLarge,
                        ),
                        Text(
                          "${seedType.trunkMaxUpgrades}",
                          style: PomodoroTheme.textLarge,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
