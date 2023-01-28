import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:flutter_dino_app/presentation/state/pomodoro_states/seed_selector_state_notifier.dart';
import 'package:flutter_dino_app/presentation/state/pomodoro_states/seed_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../seeds_screen/seed_card_widget.dart';

class SeedsSelectDialogWidget extends ConsumerWidget {
  static void navigateTo(BuildContext context) {
    context.go(RouteNames.seeds);
  }

  const SeedsSelectDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seeds = ref.watch(seedStateNotifierProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 10,
          runSpacing: 10,
          children: seeds
              .map(
                (seed) => Listener(
                  onPointerUp: (_) {
                    // select seed
                    ref
                        .read(seedSelectorStateNotifierProvider.notifier)
                        .selectSeed(seed);
                    context.pop();
                  },
                  child: SizedBox(
                    width: 190,
                    child: SeedCardWidget(seed: seed),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
