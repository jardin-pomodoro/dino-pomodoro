import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/seed.dart';
import '../../../state/pomodoro_states/auth_state_notifier.dart';
import '../../../state/pomodoro_states/seed_state_notifier.dart';
import '../../../state/services/seed_service_provider.dart';
import '../../../utils/upgrade_functions.dart';
import '../../router.dart';
import '../../theme/theme.dart';
import '../../widgets/price_widget.dart';
import '../../widgets/snackbar.dart';

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
    final user = ref.watch(authStateNotifierProvider).user;

    return Scaffold(
      backgroundColor: PomodoroTheme.secondary,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PriceWidget(price: user.balance),
              ],
            ),
            Image.network(seed.seedTypeExpand.image, height: 300),
            Text(
              seed.seedTypeExpand.name,
              style: PomodoroTheme.title3Yellow,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Temp de croissance",
                  style: PomodoroTheme.textLargeYellow,
                ),
                Text(
                  "${seed.seedTypeExpand.timeToGrow} min "
                  "(${getGrowTime(seed.seedTypeExpand.timeToGrow, seed.trunkLevel)} min)",
                  style: PomodoroTheme.textLargeYellow,
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
                  style: PomodoroTheme.textLargeYellow,
                ),
                Row(
                  children: [
                    PriceWidget(price: seed.seedTypeExpand.price),
                    const Text(
                      " (",
                      style: PomodoroTheme.textLargeYellow,
                    ),
                    PriceWidget(
                      price:
                          getIncome(seed.seedTypeExpand.price, seed.leafLevel),
                    ),
                    const Text(
                      ")",
                      style: PomodoroTheme.textLargeYellow,
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
                          width: 15,
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
                            color: PomodoroTheme.primary,
                            width: 2,
                          ),
                        ),
                      ),
                      onPressed: () {
                        _upgradeLeaf(context, ref, seed);
                      },
                      child:
                          seed.leafLevel < seed.seedTypeExpand.leafMaxUpgrades
                              ? PriceWidget(
                                  style: PomodoroTheme.textLarge,
                                  price: nextUpgradePrice(
                                    seed.seedTypeExpand.price,
                                    seed.leafLevel,
                                  ),
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
                            color: PomodoroTheme.primary,
                            width: 2,
                          ),
                        ),
                      ),
                      onPressed: () {
                        _upgradeTrunk(context, ref, seed);
                      },
                      child:
                          seed.trunkLevel < seed.seedTypeExpand.trunkMaxUpgrades
                              ? PriceWidget(
                                  style: PomodoroTheme.textLarge,
                                  price: nextUpgradePrice(
                                    seed.seedTypeExpand.price,
                                    seed.trunkLevel,
                                  ),
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
    );
  }

  _upgradeLeaf(BuildContext context, WidgetRef ref, Seed seed) {
    final price = nextUpgradePrice(seed.seedTypeExpand.price, seed.leafLevel);
    final user = ref.watch(authStateNotifierProvider).user;

    if (user.balance >= price &&
        seed.leafLevel < seed.seedTypeExpand.leafMaxUpgrades) {
      final upgradedSeed = seed.upgradeLeaf();
      ref.read(seedServiceProvider).saveSeed(user, upgradedSeed, price: price);
      ref.read(seedStateNotifierProvider.notifier).updateSeed(upgradedSeed);
      ref
          .read(authStateNotifierProvider.notifier)
          .updateBalance(user.balance - price);
      ref
          .read(selectedSeedStateNotifierProvider.notifier)
          .selectSeed(upgradedSeed);
    } else {
      showSnackBar(context, "Vous ne pouvez pas acheter cette amélioration");
    }
  }

  _upgradeTrunk(BuildContext context, WidgetRef ref, Seed seed) {
    final price = nextUpgradePrice(seed.seedTypeExpand.price, seed.trunkLevel);
    final user = ref.watch(authStateNotifierProvider).user;

    if (user.balance >= price &&
        seed.trunkLevel < seed.seedTypeExpand.trunkMaxUpgrades) {
      final upgradedSeed = seed.upgradeTrunk();
      ref.read(seedServiceProvider).saveSeed(user, upgradedSeed, price: price);
      ref.read(seedStateNotifierProvider.notifier).updateSeed(upgradedSeed);
      ref
          .read(authStateNotifierProvider.notifier)
          .updateBalance(user.balance - price);
      ref
          .read(selectedSeedStateNotifierProvider.notifier)
          .selectSeed(upgradedSeed);
    } else {
      showSnackBar(context, "Vous ne pouvez pas acheter cette amélioration");
    }
  }
}
