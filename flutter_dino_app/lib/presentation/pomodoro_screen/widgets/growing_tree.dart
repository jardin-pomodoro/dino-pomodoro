import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/pomodoro_screen/pomodoro_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

import '../../../utils/asset.dart';
import '../../state/timer/timer.dart';

class GrowingTree extends ConsumerStatefulWidget {
  const GrowingTree({Key? key}) : super(key: key);

  @override
  ConsumerState<GrowingTree> createState() => _GrowingTreeState();
}

class _GrowingTreeState extends ConsumerState<GrowingTree> {
  SMIInput<double>? _progress;

  @override
  void initState() {
    super.initState();

    AsyncValue<Duration> elapsedTime = ref.read(tickerProvider);
    print(elapsedTime);
  }

  void onInitRive(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'Grow');
    if (controller == null) {
      return;
    }
    artboard.addController(controller);
    _progress = controller.findInput('input');

    _progress?.value = 0;
    // res.whenData((value) {
    //   print(value);
    //   final double diff = (defaultPeriod.inSeconds - value.inSeconds) /
    //       defaultPeriod.inSeconds *
    //       100;
    //   _progress?.value = 100 - diff;
    // });
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<Duration> elaspedTime = ref.watch(tickerProvider);
    _progress?.value = elaspedTime.when(
      data: (value) {
        final double diff = (defaultPeriod.inSeconds - value.inSeconds) /
            defaultPeriod.inSeconds *
            100;
        return 100 - diff;
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
