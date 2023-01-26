import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dino_app/domain/models/seed.dart';
import 'package:flutter_dino_app/domain/models/seed_type.dart';
import 'package:flutter_dino_app/domain/models/seed_type_expand.dart';
import 'package:flutter_dino_app/presentation/growing_screen/growing_grow_screen_widget.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:flutter_dino_app/presentation/shop_screen/seed_type_details_card_widget.dart';
import 'package:flutter_dino_app/presentation/state/timer/timer_v2.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:flutter_dino_app/presentation/widgets/price_widget.dart';
import 'package:flutter_dino_app/utils/upgrade_functions.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedSeed = Seed(
  collectionId: '1',
  collectionName: 'Collection 1',
  created: DateTime.now(),
  id: '1',
  seedType: '1',
  expand: SeedTypeExpand(
    seedType: SeedType(
      collectionId: '1',
      collectionName: 'Collection 1',
      id: '1',
      name: 'Saul',
      image:
          'https://pocketbase.nospy.fr/api/files/lajospkke93eknf/klfch9yk075cmpq/canvas_removebg_preview_zRg2OoMJsv.png',
      timeToGrow: 1,
      price: 100,
      reward: 10,
      leafMaxUpgrades: 3,
      trunkMaxUpgrades: 3,
      created: DateTime.now(),
      updated: DateTime.now(),
    ),
  ),
  updated: DateTime.now(),
  user: '1',
  leafLevel: 0,
  trunkLevel: 2,
);

final sentenses = [
  "La vie est trop courte pour boire du mauvais café.",
  "La vérité est comme un ballon de football, plus on l'attrape, plus elle s'échappe.",
  "La sagesse est comme une bouteille de vin, plus vieille, plus chère et plus forte.",
  "La liberté est comme un chat, elle ne se laisse jamais attraper.",
  "Le bonheur est comme un papillon, il vient quand on cesse de le poursuivre.",
  "La vie est comme un livre, certains chapitres sont tristes, d'autres sont heureux, mais tous sont nécessaires pour en comprendre l'histoire.",
  "La vie est comme une boîte de chocolats, on ne sait jamais sur quoi on va tomber.",
  "L'amour est comme un puzzle, il faut tout mettre en place pour que ça fonctionne.",
  "La vie est comme une roue de la fortune, on ne sait jamais quand on va monter ou descendre.",
  "La réalité est comme une illusion, elle dépend de la façon dont on la regarde.",
  "Avec Flutter, vous pouvez construire des applications pour toutes les plateformes avec un seul code.",
  "Flutter rend le développement d'application mobile plus rapide qu'une flèche.",
  "Avec Flutter, vous pouvez donner vie à vos idées en un rien de temps.",
  "Flutter vous permet de créer des designs élégants et fluides pour vos applications."
];

class GrowingScreenWidget extends ConsumerWidget {
  static void navigateTo(BuildContext context) {
    context.go(RouteNames.growing);
  }

  const GrowingScreenWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final sentence = sentenses[Random().nextInt(sentenses.length)];
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            sentence,
            style: PomodoroTheme.title3,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: PomodoroTheme.green,
                width: 7,
              ),
            ),
            padding: const EdgeInsets.all(25),
            child: Image.network(
              selectedSeed.expand.seedType.image,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            durationString(
              getGrowTime(
                    selectedSeed.expand.seedType.timeToGrow,
                    selectedSeed.trunkLevel,
                  ) *
                  60,
            ),
            style: PomodoroTheme.title1,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                backgroundColor: PomodoroTheme.accent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(
                    color: PomodoroTheme.secondary,
                    width: 3,
                  ),
                ),
              ),
              onPressed: () {
                ref.read(timerNotifierProvider.notifier).start(
                      getGrowTime(
                            selectedSeed.expand.seedType.timeToGrow,
                            selectedSeed.trunkLevel,
                          ) *
                          60,
                    );
                GrowingGrowScreenWidget.navigateTo(context, selectedSeed);
              },
              child: const Text(
                'Planter',
                style: PomodoroTheme.title1,
              ))
        ],
      ),
    );
  }

  _showBuySeedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(0),
        content: SeedTypeDetailsCardWidget(seedType: selectedSeed.seedTypeExpand),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.only(top: 20),
        actions: [
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: PomodoroTheme.secondary,
                  content:
                  Text('Graine achetée !', style: PomodoroTheme.textLarge),
                ),
              ); // TODO: Buy
              context.pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PriceWidget(price: selectedSeed.seedTypeExpand.price),
            ),
          ),
        ],
      ),
    );
  }
}
