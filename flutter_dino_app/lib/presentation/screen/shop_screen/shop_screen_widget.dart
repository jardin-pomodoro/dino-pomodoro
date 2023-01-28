import 'package:flutter/material.dart';
import 'package:flutter_dino_app/domain/models/seed.dart';
import 'package:flutter_dino_app/domain/models/seed_type.dart';
import 'package:flutter_dino_app/domain/models/seed_type_expand.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:flutter_dino_app/presentation/state/pomodoro_states/seed_state_notifier.dart';
import 'package:flutter_dino_app/presentation/state/pomodoro_states/seed_type_state_notifier.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:flutter_dino_app/presentation/widgets/price_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'seed_type_card_widget.dart';
import 'seed_type_details_card_widget.dart';

class ShopScreenWidget extends ConsumerWidget {
  static void navigateTo(BuildContext context) {
    context.go(RouteNames.shop);
  }

  const ShopScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notBoughtSeedsType =
        ref.watch(notBoughtSeedTypeStateNotifierProvider);
    final boughtSeedsType = ref.watch(boughtSeedTypeStateNotifierProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 20,
          runSpacing: 20,
          children: notBoughtSeedsType
              .map(
                (seedType) => Listener(
                  onPointerUp: (_) =>
                      _showBuySeedDialog(context, seedType, ref),
                  child: SizedBox(
                    width: 180,
                    child:
                        SeedTypeCardWidget(seedType: seedType, bought: false),
                  ),
                ),
              )
              .toList()
            ..addAll(
              boughtSeedsType
                  .map(
                    (seedType) => Listener(
                      child: SizedBox(
                        width: 180,
                        child: SeedTypeCardWidget(
                            seedType: seedType, bought: true),
                      ),
                    ),
                  )
                  .toList(),
            ),
        ),
      ),
    );
  }

  _showBuySeedDialog(BuildContext context, SeedType seedType, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(0),
        content: SeedTypeDetailsCardWidget(seedType: seedType),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.only(top: 20),
        actions: [
          ElevatedButton(
            onPressed: () {
              _buySeed(seedType, ref);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: PomodoroTheme.secondary,
                  content:
                      Text('Graine achetée !', style: PomodoroTheme.textLarge),
                ),
              );
              context.pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PriceWidget(price: seedType.price),
            ),
          ),
        ],
      ),
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
