import 'package:flutter/material.dart';
import '../../../utils/duration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../router.dart';
import '../../state/timer/timer.dart';
import '../../theme/theme.dart';
import '../../widgets/circular_progress_timer.dart';
import 'widgets/growing_tree.dart';

const Duration defaultPeriod = Duration(minutes: 1);

double computeCurrentValue(Duration remainingTime) {
  final gap = defaultPeriod.inSeconds - remainingTime.inSeconds;
  return gap.toDouble();
}

class GrowingScreenWidget extends ConsumerWidget {
  static void navigateTo(BuildContext context) {
    context.go(RouteNames.growing);
  }

  const GrowingScreenWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Duration> timer = ref.watch(tickerProvider);
    final Duration remainingTime = timer.when(
      data: (Duration value) => value,
      error: (Object e, _) {
        print(e); // TODO add logger
        return defaultPeriod;
      },
      loading: () => defaultPeriod,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressTimer(
          remainingTime: remainingTime,
          children: Center(
            child: Text(
              remainingTime.inSecondsWithMinutes(),
              style: const TextStyle(
                fontSize: 40,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const GrowingTree()
      ],
    );
  }
}
