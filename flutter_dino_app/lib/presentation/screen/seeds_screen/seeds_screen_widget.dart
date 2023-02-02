import 'package:flutter/material.dart';
import '../../router.dart';
import '../../state/pomodoro_states/seed_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'seed_card_widget.dart';
import 'seed_details_screen_widget.dart';

class SeedsScreenWidget extends ConsumerWidget {
  static void navigateTo(BuildContext context) {
    context.go(RouteNames.seeds);
  }

  const SeedsScreenWidget({Key? key}) : super(key: key);

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
                    ref
                        .read(selectedSeedStateNotifierProvider.notifier)
                        .selectSeed(seed);
                    SeedDetailsScreenWidget.navigateTo(context);
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
