import 'package:flutter/material.dart';
import 'package:flutter_dino_app/domain/models/seed.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:flutter_dino_app/presentation/widgets/price_widget.dart';
import 'package:flutter_dino_app/utils/upgrade_functions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SeedCardWidget extends StatelessWidget {
  final Seed seed;

  const SeedCardWidget({
    Key? key,
    required this.seed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: PomodoroTheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: PomodoroTheme.primary,
          width: 2,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.network(seed.seedTypeExpand.image),
            Text(
              seed.seedTypeExpand.name,
              style: PomodoroTheme.title3,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  direction: Axis.vertical,
                  spacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.leaf,
                          color: PomodoroTheme.accent,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${seed.leafLevel}/${seed.seedTypeExpand.leafMaxUpgrades}",
                          style: PomodoroTheme.textLarge,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Image(
                          image: AssetImage('assets/icons/lumber.png'),
                          color: PomodoroTheme.accent,
                          height: 25,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${seed.trunkLevel}/${seed.seedTypeExpand.trunkMaxUpgrades}",
                          style: PomodoroTheme.textLarge,
                        ),
                      ],
                    ),
                  ],
                ),
                Wrap(
                  direction: Axis.vertical,
                  spacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.piggyBank,
                          color: PomodoroTheme.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        PriceWidget(
                          price: getIncome(
                            seed.seedTypeExpand.reward,
                            seed.leafLevel,
                          ),
                          spacing: 5,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.hourglassHalf,
                          color: PomodoroTheme.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${getGrowTime(seed.seedTypeExpand.timeToGrow, seed.trunkLevel)} min",
                          style: PomodoroTheme.textLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
