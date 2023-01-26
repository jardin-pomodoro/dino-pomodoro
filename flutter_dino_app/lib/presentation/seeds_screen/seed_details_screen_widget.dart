import 'package:flutter/material.dart';
import 'package:flutter_dino_app/domain/models/seed.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:flutter_dino_app/presentation/widgets/price_widget.dart';
import 'package:flutter_dino_app/utils/upgrade_functions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SeedDetailsScreenWidget extends StatelessWidget {
  final Seed seed;

  static void navigateTo(BuildContext context, Seed seed) {
    context.push(RouteNames.seedDetails, extra: seed);
  }

  const SeedDetailsScreenWidget({
    Key? key,
    required this.seed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.network(seed.seedTypeExpand.image, height: 300),
          Text(
            seed.seedTypeExpand.name,
            style: PomodoroTheme.title3,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Temp de croissance",
                style: PomodoroTheme.textLarge,
              ),
              Text(
                "${seed.seedTypeExpand.timeToGrow} min "
                "(${getGrowTime(seed.seedTypeExpand.timeToGrow, seed.trunkLevel)} min)",
                style: PomodoroTheme.textLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Récompense",
                style: PomodoroTheme.textLarge,
              ),
              Row(
                children: [
                  PriceWidget(price: seed.seedTypeExpand.price),
                  const Text(
                    " (",
                    style: PomodoroTheme.textLarge,
                  ),
                  PriceWidget(
                    price: getIncome(seed.seedTypeExpand.price, seed.leafLevel),
                  ),
                  const Text(
                    ")",
                    style: PomodoroTheme.textLarge,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Wrap(
                direction: Axis.vertical,
                spacing: 50,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.leaf,
                        color: PomodoroTheme.white,
                      ),
                      const SizedBox(
                        width: 15,
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
                        color: PomodoroTheme.white,
                        height: 25,
                      ),
                      const SizedBox(
                        width: 15,
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
                spacing: 40,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      backgroundColor: PomodoroTheme.accent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(
                          color: PomodoroTheme.secondary,
                          width: 2,
                        ),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: PomodoroTheme.secondary,
                          content: Text('amélioration feuille !',
                              style: PomodoroTheme.textLarge),
                        ),
                      ); // TODO: implement upgrade leaf
                    },
                    child: PriceWidget(
                      price: nextUpgradePrice(
                          seed.seedTypeExpand.price, seed.leafLevel),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      backgroundColor: PomodoroTheme.accent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(
                          color: PomodoroTheme.secondary,
                          width: 2,
                        ),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: PomodoroTheme.secondary,
                          content: Text('amélioration tronc !',
                              style: PomodoroTheme.textLarge),
                        ),
                      ); // TODO: implement trunk upgrade
                    },
                    child: PriceWidget(
                      price: nextUpgradePrice(
                          seed.seedTypeExpand.price, seed.trunkLevel),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
