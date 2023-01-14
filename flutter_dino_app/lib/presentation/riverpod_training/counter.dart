import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/riverpod_training/counter_consumer.dart';
import 'package:flutter_dino_app/presentation/state/counter/counter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CounterWidget extends ConsumerWidget {
  const CounterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'The current counter is :',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(width: 5),
            const CounterConsumer(),
          ],
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {
            ref.read(counterProvider.notifier).increment();
          },
          child: const Text('Increment my counter'),
        ),
      ],
    );
  }
}
