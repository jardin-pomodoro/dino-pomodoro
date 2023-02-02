import 'package:flutter/material.dart';
import 'package:flutter_dino_app/domain/models/seed_type.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:flutter_dino_app/presentation/widgets/price_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../domain/models/seed.dart';
import '../../../../domain/models/seed_type_expand.dart';
import '../../../state/pomodoro_states/seed_state_notifier.dart';
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
                        Chip(label: PriceWidget(price: seedType.reward)),
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
                  style: ElevatedButtonTheme.of(context).style?.copyWith(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.green,
                        ),
                      ),
                  onPressed: () {
                    _buySeed(seedType, ref);
                    showSnackBar(context, "Graine achetée !");
                    context.pop();
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

  _buySeed(SeedType seedType, WidgetRef ref) {
    // TODO Buy seed
    Seed seed = Seed(
      id: const Uuid().v4(),
      seedType: seedType.id,
      expand: SeedTypeExpand(seedType: seedType),
      user: "1",
      leafLevel: 0,
      trunkLevel: 0,
      collectionId: "1",
      collectionName: "1",
      created: DateTime.now(),
      updated: DateTime.now(),
    );
    ref.read(seedStateNotifierProvider.notifier).addSeed(seed);
  }
}
