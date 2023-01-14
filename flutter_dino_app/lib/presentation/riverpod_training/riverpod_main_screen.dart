import 'package:flutter/material.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'The current date is:',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(width: 10),
            Text(
              '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}:${date.second}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
