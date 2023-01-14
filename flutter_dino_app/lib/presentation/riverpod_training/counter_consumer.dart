import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/state/counter/counter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CounterConsumer extends ConsumerWidget {
  const CounterConsumer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Text(
      '$count',
      style: Theme.of(context).textTheme.headline5,
    );
  }
}
