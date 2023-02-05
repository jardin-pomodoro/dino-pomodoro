import 'dart:math';

import 'package:flutter/material.dart';
import 'widgets/grow_failed_dialog_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/growing.dart';
import '../../../domain/models/seed.dart';
import '../../../domain/models/tree.dart';
import '../../../state/pomodoro_states/growing_state_notifier.dart';
import '../../../state/pomodoro_states/seed_selector_state_notifier.dart';
import '../../../state/sentences_stream_provider.dart';
import '../../../state/timer/timer_v2.dart';
import '../../router.dart';
import '../../theme/theme.dart';
import '../../../utils/upgrade_functions.dart';
import 'package:go_router/go_router.dart';

import 'growing_grow_screen_widget.dart';
import 'widgets/seeds_select_dialog_widget.dart';
import 'widgets/tree_reward_dialog_widget.dart';

class GrowingScreenWidget extends ConsumerWidget {
  static void navigateTo(BuildContext context) {
    context.go(RouteNames.growing);
  }

  const GrowingScreenWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sentence = ref.watch(sentenceProvider);
    final selectedSeed = ref.watch(seedSelectorStateNotifierProvider);
    final growingState = ref.watch(growingStateNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (growingState.isEnded == true) {
        final growing = growingState.growing!;

        // todo remove mock
        final tree = Tree(
          id: Random().nextInt(100000).toString(),
          collectionId: "1",
          collectionName: "Collection 1",
          created: DateTime.now(),
          updated: DateTime.now(),
          user: "1",
          seedType: growing.seedType,
          expand: growing.expand,
          reward: growing.reward,
          timeToGrow: growing.timeToGrow,
          started: growing.created,
          ended: DateTime.now(),
        );

        _showTreeRewardDialog(context, ref, tree);
      } else if (growingState.isFailed == true) {
        _showGrowFailedDialog(context, ref);

        // todo remove growing from PB
      }
    });
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
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(0),
        child: SeedsSelectDialogWidget(),
      ),
    );
  }

  _showTreeRewardDialog(BuildContext context, WidgetRef ref, Tree tree) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: TreeRewardDialogWidget(tree: tree),
      ),
    ).whenComplete(() {
      ref.read(timerNotifierProvider.notifier).reset();
      ref.read(growingStateNotifierProvider.notifier).reset();
    });
  }

  _showGrowFailedDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const Dialog(
        backgroundColor: Colors.transparent,
        child: GrowFailedDialogWidget(),
      ),
    ).whenComplete(() {
      ref.read(timerNotifierProvider.notifier).reset();
      ref.read(growingStateNotifierProvider.notifier).reset();
    });
  }
}
