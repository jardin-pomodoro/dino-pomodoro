import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:is_lock_screen/is_lock_screen.dart';

import '../../../state/pomodoro_states/auth_state_notifier.dart';
import '../../../state/pomodoro_states/growing_state_notifier.dart';
import '../../../state/sentences_stream_provider.dart';
import '../../../state/services/growing_service_provider.dart';
import '../../../state/services/tree_service_provider.dart';
import '../../../state/timer/timer_v2.dart';
import '../../../utils/upgrade_functions.dart';
import '../../router.dart';
import '../../theme/theme.dart';
import '../../widgets/circular_progress_timer.dart';
import '../../widgets/snackbar.dart';
import 'growing_screen_widget.dart';
import 'widgets/grow_failed_dialog_widget.dart';
import 'widgets/growing_tree.dart';
import 'widgets/tree_reward_dialog_widget.dart';

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
  bool _isGrowFailed = false;
  bool _popupShown = false;

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
        setState(() {
          _isGrowFailed = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final sentence = ref.watch(sentenceProvider);
    final timer = ref.watch(timerNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (_isGrowFailed && !_popupShown) {
          setState(() {
            _popupShown = true;
          });
          _showGrowFailedDialog(context);
        } else if (timer.durationLeft == 0 && !_popupShown) {
          setState(() {
            _popupShown = true;
          });
          _showTreeRewardDialog(context);
        }
      },
    );

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

  _showTreeRewardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const Dialog(
        backgroundColor: Colors.transparent,
        child: TreeRewardDialogWidget(),
      ),
    ).whenComplete(() {
      final growing = ref.read(growingStateNotifierProvider);
      final user = ref.read(authStateNotifierProvider).user;
      final treeService = ref.read(treeServiceProvider);
      treeService.addNewTree(user, growing!).then((treeSuccess) {
        if (treeSuccess.isSuccess) {
          ref.read(timerNotifierProvider.notifier).reset();
          ref.read(growingServiceProvider).clearGrowing(user.id);
          ref.read(growingStateNotifierProvider.notifier).endGrowing();
          ref
              .read(authStateNotifierProvider.notifier)
              .updateBalance(user.balance + growing.reward);
          GrowingScreenWidget.navigateTo(context);
        } else {
          showSnackBar(context, "Erreur lors de l'ajout de l'arbre");
        }
      });

      // ref.read(growingStateNotifierProvider.notifier).reset();
    });
  }

  _showGrowFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const Dialog(
        backgroundColor: Colors.transparent,
        child: GrowFailedDialogWidget(),
      ),
    ).whenComplete(() {
      final user = ref.read(authStateNotifierProvider).user;
      ref.read(timerNotifierProvider.notifier).reset();
      ref.read(growingServiceProvider).clearGrowing(user.id);
      ref.read(growingStateNotifierProvider.notifier).endGrowing();
      GrowingScreenWidget.navigateTo(context);
    });
  }
}
