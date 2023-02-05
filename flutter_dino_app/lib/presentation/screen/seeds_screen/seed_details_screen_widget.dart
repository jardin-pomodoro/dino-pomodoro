import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/seed.dart';
import '../../../state/pomodoro_states/seed_state_notifier.dart';
import '../../router.dart';
import '../../theme/theme.dart';
import '../../widgets/price_widget.dart';
import '../../../utils/upgrade_functions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SeedDetailsScreenWidget extends ConsumerWidget {
  static void navigateTo(BuildContext context) {
    context.push(RouteNames.seedDetails);
  }

  const SeedDetailsScreenWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seed = ref.watch(selectedSeedStateNotifierProvider)!;

    return Scaffold(
      backgroundColor: PomodoroTheme.primary,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                        price: getIncome(
                            seed.seedTypeExpand.price, seed.leafLevel),
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
                          _upgradeLeaf(context, ref, seed);
                        },
                        child: seed.leafLevel <
                                seed.seedTypeExpand.leafMaxUpgrades
                            ? PriceWidget(
                                price: nextUpgradePrice(
                                    seed.seedTypeExpand.price, seed.leafLevel),
                              )
                            : const Text(
                                "Max",
                                style: PomodoroTheme.textLarge,
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
                          _upgradeTrunk(context, ref, seed);
                        },
                        child: seed.trunkLevel <
                                seed.seedTypeExpand.trunkMaxUpgrades
                            ? PriceWidget(
                                price: nextUpgradePrice(
                                    seed.seedTypeExpand.price, seed.trunkLevel),
                              )
                            : const Text(
                                "Max",
                                style: PomodoroTheme.textLarge,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _upgradeLeaf(BuildContext context, WidgetRef ref, Seed seed) {
    if (seed.leafLevel < seed.seedTypeExpand.leafMaxUpgrades) {
      final upgradedSeed = seed.upgradeLeaf();
      ref
          .read(selectedSeedStateNotifierProvider.notifier)
          .selectSeed(upgradedSeed);
      ref.read(seedStateNotifierProvider.notifier).updateSeed(upgradedSeed);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     duration: Duration(milliseconds: 500),
      //     backgroundColor: PomodoroTheme.secondary,
      //     content:
      //         Text('amélioration feuille !', style: PomodoroTheme.textLarge),
      //   ),
      // );
      // TODO: implement upgrade leaf
    }
  }

  _upgradeTrunk(BuildContext context, WidgetRef ref, Seed seed) {
    if (seed.trunkLevel < seed.seedTypeExpand.trunkMaxUpgrades) {
      final upgradedSeed = seed.upgradeTrunk();
      // TODO: implement upgrade trunk
      ref
          .read(selectedSeedStateNotifierProvider.notifier)
          .selectSeed(upgradedSeed);
      ref.read(seedStateNotifierProvider.notifier).updateSeed(upgradedSeed);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     duration: Duration(milliseconds: 500),
      //     backgroundColor: PomodoroTheme.secondary,
      //     content: Text('amélioration tronc !', style: PomodoroTheme.textLarge),
      //   ),
      // );
    }
  }
}
