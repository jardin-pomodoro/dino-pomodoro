import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/state/time/date.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DateWidget extends ConsumerWidget {
  const DateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(currentDate);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'The current date is:',
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: 10),
        Text(
          '${date.day}/${date.month}/${date.year}',
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }
}
