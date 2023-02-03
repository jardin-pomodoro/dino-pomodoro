import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

import '../../../../state/timer/timer_v2.dart';
import '../../../../utils/asset.dart';

class GrowingTree extends ConsumerStatefulWidget {
  const GrowingTree({Key? key}) : super(key: key);

  @override
  ConsumerState<GrowingTree> createState() => _GrowingTreeState();
}

class _GrowingTreeState extends ConsumerState<GrowingTree> {
  SMIInput<double>? _progress;

  void onInitRive(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'Grow');
    if (controller == null) {
      return;
    }
    artboard.addController(controller);
    _progress = controller.findInput('input');

    _progress?.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    final timerStream = ref.watch(timerNotifierProvider.notifier);
    timerStream.addListener((state) {
      final diff = state.initialDuration - state.durationLeft;
      final percentageDifference = diff / state.initialDuration * 100;
      _progress?.value = percentageDifference;
    });
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: RiveAnimation.asset(
        Assets.tree,
        fit: BoxFit.contain,
        onInit: onInitRive,
      ),
    );
  }
}
