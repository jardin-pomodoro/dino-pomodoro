import 'package:flutter/material.dart';
import 'package:flutter_dino_app/domain/models/growing.dart';
import 'package:flutter_dino_app/presentation/growing_screen/growing_screen_widget.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:flutter_dino_app/presentation/state/timer/timer_v2.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:flutter_dino_app/utils/upgrade_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../widgets/circular_progress_timer.dart';
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
    final timer = ref.watch(timerNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (timer.isRunning == false) {
        GrowingScreenWidget.navigateTo(context);
      }
    });

    return WillPopScope(
      onWillPop: () async {
        // snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: PomodoroTheme.secondary,
            content: Text(
              'Vous devez rester con-cen-tré !',
              style: PomodoroTheme.textLarge,
              textAlign: TextAlign.center,
            ),
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: PomodoroTheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
    );
  }
}