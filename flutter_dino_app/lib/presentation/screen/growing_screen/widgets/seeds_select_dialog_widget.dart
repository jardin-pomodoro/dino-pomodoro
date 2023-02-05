import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../state/pomodoro_states/seed_selector_state_notifier.dart';
import '../../../../state/pomodoro_states/seed_state_notifier.dart';
import '../../../theme/theme.dart';
import '../../seeds_screen/seed_card_widget.dart';

class SeedsSelectDialogWidget extends ConsumerWidget {
  const SeedsSelectDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seeds = ref.watch(seedStateNotifierProvider);

    if (seeds.isEmpty) {
      return Listener(
        onPointerUp: (_) => context.pop(),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  FaIcon(
                    FontAwesomeIcons.hourglassHalf,
                    color: PomodoroTheme.secondary,
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Vous n'avez pas de graines allez en acheter dans la boutique !",
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

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
