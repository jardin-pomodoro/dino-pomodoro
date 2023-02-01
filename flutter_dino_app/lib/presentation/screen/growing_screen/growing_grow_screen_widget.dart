import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:flutter_dino_app/presentation/state/timer/timer_v2.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:flutter_dino_app/presentation/widgets/snackbar.dart';
import 'package:flutter_dino_app/utils/lifecycle_event_handler.dart';
import 'package:flutter_dino_app/utils/upgrade_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../state/pomodoro_states/growing_state_notifier.dart';
import '../../state/sentences_stream_provider.dart';
import '../../widgets/circular_progress_timer.dart';
import 'growing_screen_widget.dart';
import 'widgets/growing_tree.dart';

const Duration defaultPeriod = Duration(minutes: 1);

double computeCurrentValue(Duration remainingTime) {
  final gap = defaultPeriod.inSeconds - remainingTime.inSeconds;
  return gap.toDouble();
}

class GrowingGrowScreenWidget extends ConsumerWidget {
  static void navigateTo(BuildContext context) {
    context.push(RouteNames.growingGrow);
  }

  const GrowingGrowScreenWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sentence = ref.watch(sentenceProvider);
    final timer = ref.watch(timerNotifierProvider);
    final isGrowing = ref.watch(isGrowingProvider);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (isGrowing == false) {
        // ref.read(timerNotifierProvider.notifier).reset();
        GrowingScreenWidget.navigateTo(context);
      } else if (timer.durationLeft == 0) {
        ref.read(growingStateNotifierProvider.notifier).endGrowing();
      }
    });

    WidgetsBinding.instance.addObserver(LifecycleEventHandler(
      onAppDetached: () {
        ref.read(growingStateNotifierProvider.notifier).failGrowing();
      },
      onAppPaused: () {
        ref.read(growingStateNotifierProvider.notifier).failGrowing();
      },
    ));

    return WillPopScope(
      onWillPop: () async {
        // snackbar
        showSnackBar(
          context,
          'Vous devez rester con-cen-tré !',
          duration: const Duration(seconds: 1),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: PomodoroTheme.background,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  sentence,
                  style: PomodoroTheme.title3,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                CircularProgressTimer(
                  initialTime: timer.initialDuration,
                  remainingTime: timer.durationLeft,
                  children: Container(
                    padding: const EdgeInsets.all(20),
                    child: const GrowingTree(),
                  ),
                ),
                const SizedBox(height: 60),
                Text(
                  durationString(
                    timer.durationLeft,
                  ),
                  style: PomodoroTheme.title1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
