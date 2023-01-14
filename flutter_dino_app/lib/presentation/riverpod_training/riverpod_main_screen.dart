import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/state/counter/counter.dart';
import 'package:flutter_dino_app/presentation/state/time/date.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RiverPodMainScreen extends ConsumerWidget {
  const RiverPodMainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(currentDate);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'The current date is:',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(width: 10),
              Text(
                '${date.day}/${date.month}/${date.year}',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'The current counter is :',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(width: 5),
                  Consumer(
                    builder: (context, ref, child) {
                      final count = ref.watch(counterProvider);
                      return Text(
                        '$count',
                        style: Theme.of(context).textTheme.headline5,
                      );
                    },
                  ),
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
          ),
        ),
      ),
    );
  }
}
