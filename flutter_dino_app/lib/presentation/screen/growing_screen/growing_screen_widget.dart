import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/seed.dart';
import '../../../state/pomodoro_states/auth_state_notifier.dart';
import '../../../state/pomodoro_states/growing_state_notifier.dart';
import '../../../state/pomodoro_states/seed_selector_state_notifier.dart';
import '../../../state/sentences_stream_provider.dart';
import '../../../state/services/growing_service_provider.dart';
import '../../../state/timer/timer_v2.dart';
import '../../../utils/upgrade_functions.dart';
import '../../router.dart';
import '../../theme/theme.dart';
import '../../widgets/snackbar.dart';
import 'growing_grow_screen_widget.dart';
import 'widgets/seeds_select_dialog_widget.dart';

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
    final user = ref.read(authStateNotifierProvider).user;
    ref
        .read(growingServiceProvider)
        .addNewGrowing(user.id, selectedSeed)
        .then((growSuccess) {
      if (growSuccess.isSuccess) {
        final grow = growSuccess.data!;
        ref.read(growingStateNotifierProvider.notifier).setGrowing(grow);

        ref.read(timerNotifierProvider.notifier).start(
              getGrowTime(
                    selectedSeed.expand.seedType.timeToGrow,
                    selectedSeed.trunkLevel,
                  ) *
                  60,
            );
        GrowingGrowScreenWidget.navigateTo(context);
      } else {
        showSnackBar(context, "Erreur lors de la plantation");
      }
    });
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
}
