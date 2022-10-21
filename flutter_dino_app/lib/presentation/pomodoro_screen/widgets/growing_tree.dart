import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/pomodoro_screen/pomodoro_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

import '../../../utils/asset.dart';

class GrowingTree extends StatefulWidget {
  final AsyncValue<Duration> timer;
  const GrowingTree({Key? key, required this.timer}) : super(key: key);

  @override
  State<GrowingTree> createState() => _GrowingTreeState();
}

class _GrowingTreeState extends State<GrowingTree> {
  late SMINumber _input;

  void onInitRive(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'Grow');
    print(controller);
    if (controller == null) {
      return;
    }
    artboard.addController(controller);
    _input = controller.findInput<int>('input') as SMINumber;
    final Duration timer = widget.timer
        .maybeWhen(orElse: () => Duration.zero, data: (value) => value);
    final double diff = (defaultPeriod.inSeconds - timer.inSeconds) /
        defaultPeriod.inSeconds *
        100;

    _input.change(diff);
  }

  @override
  Widget build(BuildContext context) {
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
