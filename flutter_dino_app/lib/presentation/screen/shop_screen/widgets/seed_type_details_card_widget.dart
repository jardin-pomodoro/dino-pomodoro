import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/models/seed_type.dart';
import '../../../../state/pomodoro_states/auth_state_notifier.dart';
import '../../../../state/pomodoro_states/seed_state_notifier.dart';
import '../../../../state/services/seed_service_provider.dart';
import '../../../theme/theme.dart';
import '../../../widgets/price_widget.dart';
import '../../../widgets/snackbar.dart';

class SeedTypeDetailsCardWidget extends ConsumerWidget {
  final SeedType seedType;

  const SeedTypeDetailsCardWidget({Key? key, required this.seedType})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          color: PomodoroTheme.accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: PomodoroTheme.secondary,
              width: 3,
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
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Temps de pousse",
                          style: PomodoroTheme.textLarge,
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Récompense",
                          style: PomodoroTheme.textLarge,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Wrap(
                            children: const [
                              Text(
                                "Amélioration feuilles max",
                                style: PomodoroTheme.textLarge,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Amélioration tronc max",
                          style: PomodoroTheme.textLarge,
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Chip(
                          label: Text(
                            "${seedType.timeToGrow} min",
                            style: PomodoroTheme.textLarge,
                          ),
                        ),
                        Chip(
                          label: PriceWidget(price: seedType.reward),
                          backgroundColor: PomodoroTheme.secondary,
                        ),
                        Chip(
                          label: Text(
                            "${seedType.leafMaxUpgrades}",
                            style: PomodoroTheme.textLarge,
                          ),
                        ),
                        Chip(
                          label: Text(
                            "${seedType.trunkMaxUpgrades}",
                            style: PomodoroTheme.textLarge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: PomodoroTheme.secondary,
                  ),
                  onPressed: () {
                    _buySeed(seedType, context, ref).then((_) => context.pop());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PriceWidget(price: seedType.price),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buySeed(SeedType seedType, BuildContext context, WidgetRef ref) async {
    final price = seedType.price;
    final user = ref.read(authStateNotifierProvider).user;

    if (user.balance >= price) {
      final seedSuccess =
          await ref.read(seedServiceProvider).buySeed(user, seedType);
      if (seedSuccess.isSuccess) {
        final seed = seedSuccess.data!;
        ref.read(seedStateNotifierProvider.notifier).addSeed(seed);
        ref
            .read(authStateNotifierProvider.notifier)
            .updateBalance(user.balance - price);
        showSnackBar(context, "Graine achetée !");
      } else {
        showSnackBar(context, "Erreur lors de l'achat !");
      }
    } else {
      showSnackBar(context, "Pas assez d'argent !");
    }
  }
}
