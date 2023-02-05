import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../state/pomodoro_states/growing_state_notifier.dart';
import '../../../theme/theme.dart';
import '../../../widgets/price_widget.dart';

class TreeRewardDialogWidget extends ConsumerWidget {
  const TreeRewardDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final growing = ref.watch(growingStateNotifierProvider);
    return Card(
      color: PomodoroTheme.accent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: PomodoroTheme.white,
          width: 2,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              growing!.seedTypeExpand.image,
              height: 250,
            ),
            const Text(
              "Votre arbre a poussé !",
              style: PomodoroTheme.title3,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Vous avez gagné",
                  style: PomodoroTheme.textLarge,
                ),
                const SizedBox(
                  width: 5,
                ),
                PriceWidget(
                  price: growing.reward,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
