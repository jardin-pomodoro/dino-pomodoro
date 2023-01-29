import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dino_app/domain/models/growing.dart';
import 'package:flutter_dino_app/domain/models/seed.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:flutter_dino_app/presentation/state/pomodoro_states/growing_state_notifier.dart';
import 'package:flutter_dino_app/presentation/state/pomodoro_states/seed_selector_state_notifier.dart';
import 'package:flutter_dino_app/presentation/state/timer/timer_v2.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:flutter_dino_app/utils/upgrade_functions.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'growing_grow_screen_widget.dart';
import 'widgets/seeds_select_dialog_widget.dart';

// final selectedSeed = Seed(
//   collectionId: '1',
//   collectionName: 'Collection 1',
//   created: DateTime.now(),
//   id: '1',
//   seedType: '1',
//   expand: SeedTypeExpand(
//     seedType: SeedType(
//       collectionId: '1',
//       collectionName: 'Collection 1',
//       id: '1',
//       name: 'Saul',
//       image:
//           'https://pocketbase.nospy.fr/api/files/lajospkke93eknf/klfch9yk075cmpq/canvas_removebg_preview_zRg2OoMJsv.png',
//       timeToGrow: 1,
//       price: 100,
//       reward: 10,
//       leafMaxUpgrades: 3,
//       trunkMaxUpgrades: 3,
//       created: DateTime.now(),
//       updated: DateTime.now(),
//     ),
//   ),
//   updated: DateTime.now(),
//   user: '1',
//   leafLevel: 0,
//   trunkLevel: 2,
// );

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
    final selectedSeed = ref.watch(seedSelectorStateNotifierProvider);

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
          selectedSeed == null
              ? _renderSeedNotSelected(context, ref)
              : _renderSeedSelected(selectedSeed, context, ref),
        ],
      ),
    );
  }

  Widget _renderSeedSelected(
      Seed selectedSeed, BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Listener(
          onPointerUp: (_) {
            _showSeedSelectDialog(context);
          },
          child: Container(
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
              _startGrowTree(context, ref, selectedSeed);
            },
            child: const Text(
              'Planter',
              style: PomodoroTheme.title1,
            ))
      ],
    );
  }

  Widget _renderSeedNotSelected(BuildContext context, WidgetRef ref) {
    return Listener(
      onPointerUp: (_) {
        _showSeedSelectDialog(context);
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 20),
        width: 350,
        height: 350,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: PomodoroTheme.green,
            width: 7,
          ),
        ),
        child: const Center(
          child: Text(
            "Sélectionnez \nune graine",
            style: PomodoroTheme.title1,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  _startGrowTree(BuildContext context, WidgetRef ref, Seed selectedSeed) {
    final grow = Growing(
      collectionId: "1",
      collectionName: "Collection 1",
      created: DateTime.now(),
      id: "1",
      seedType: selectedSeed.expand.seedType.id,
      expand: selectedSeed.expand,
      reward: getIncome(
        selectedSeed.expand.seedType.reward,
        selectedSeed.leafLevel,
      ),
      timeToGrow: getGrowTime(
        selectedSeed.expand.seedType.timeToGrow,
        selectedSeed.trunkLevel,
      ),
      updated: DateTime.now(),
      user: "1",
    );
    ref.read(growingStateNotifierProvider.notifier).startGrowing(grow);

    ref.read(timerNotifierProvider.notifier).start(
          getGrowTime(
                selectedSeed.expand.seedType.timeToGrow,
                selectedSeed.trunkLevel,
              ) *
              60,
        );
    GrowingGrowScreenWidget.navigateTo(context);
  }

  _showSeedSelectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const Dialog(
        backgroundColor: Colors.blue,
        insetPadding: EdgeInsets.all(0),
        child: SeedsSelectDialogWidget(),
      ),
    );
  }

  _showTreeRewardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        content: Text(
          'Vous avez gagné 10 pommes',
          style: PomodoroTheme.title1,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: EdgeInsets.only(top: 20),
      ),
    );
  }
}
