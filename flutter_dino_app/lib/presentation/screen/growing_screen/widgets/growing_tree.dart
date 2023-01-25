import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

import '../../../../../utils/asset.dart';
import '../../../state/timer/timer.dart';
import '../growing_screen_widget.dart';

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
    AsyncValue<Duration> elaspedTime = ref.watch(tickerProvider);
    _progress?.value = elaspedTime.when(
      data: (value) {
        final diff = defaultPeriod.inSeconds - value.inSeconds;
        final percentageDifference = diff / defaultPeriod.inSeconds * 100;
        return percentageDifference;
      },
      loading: () => 0,
      error: (error, stack) => 0,
    );
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
