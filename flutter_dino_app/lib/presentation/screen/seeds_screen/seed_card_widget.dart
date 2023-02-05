import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/models/seed.dart';
import '../../../utils/upgrade_functions.dart';
import '../../theme/theme.dart';
import '../../widgets/price_widget.dart';

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
              style: PomodoroTheme.title3Yellow,
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
                          color: PomodoroTheme.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${seed.leafLevel}/${seed.seedTypeExpand.leafMaxUpgrades}",
                          style: PomodoroTheme.textLargeYellow,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Image(
                          image: AssetImage('assets/icons/lumber.png'),
                          color: PomodoroTheme.white,
                          height: 25,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${seed.trunkLevel}/${seed.seedTypeExpand.trunkMaxUpgrades}",
                          style: PomodoroTheme.textLargeYellow,
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
                          style: PomodoroTheme.textLargeYellow,
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
