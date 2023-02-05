/*
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
*/

import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/screen/growing_screen/widgets/growing_tree.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:is_lock_screen/is_lock_screen.dart';

import '../../../state/pomodoro_states/growing_state_notifier.dart';
import '../../../state/sentences_stream_provider.dart';
import '../../../state/timer/timer_v2.dart';
import '../../../utils/upgrade_functions.dart';
import '../../router.dart';
import '../../theme/theme.dart';
import '../../widgets/circular_progress_timer.dart';
import '../../widgets/snackbar.dart';
import 'growing_screen_widget.dart';

class GrowingGrowScreenWidget extends ConsumerStatefulWidget {
  static void navigateTo(BuildContext context) {
    context.push(RouteNames.growingGrow);
  }

  const GrowingGrowScreenWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _GrowingGrowScreenWidgetDetectorState();
}

class _GrowingGrowScreenWidgetDetectorState
    extends ConsumerState<GrowingGrowScreenWidget> with WidgetsBindingObserver {
  bool _isScreenLocked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      bool isScreenLocked = await isLockScreen() ?? false;
      setState(() {
        _isScreenLocked = isScreenLocked;
      });
      if (_isScreenLocked == false) {
        ref.read(timerNotifierProvider.notifier).stop();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (_isScreenLocked == false) {
        ref.read(growingStateNotifierProvider.notifier).failGrowing();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final sentence = ref.watch(sentenceProvider);
    final timer = ref.watch(timerNotifierProvider);
    final isGrowing = ref.watch(isGrowingProvider);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (isGrowing == false) {
        ref.read(timerNotifierProvider.notifier).reset();
        GrowingScreenWidget.navigateTo(context);
      } else if (timer.durationLeft == 0) {
        ref.read(growingStateNotifierProvider.notifier).endGrowing();
      }
    });

/*    WidgetsBinding.instance.addObserver(LifecycleEventHandler(
      onAppDetached: () {
        ref.read(growingStateNotifierProvider.notifier).failGrowing();
      },
      onAppPaused: () {
        ref.read(growingStateNotifierProvider.notifier).failGrowing();
      },
    ));*/

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
