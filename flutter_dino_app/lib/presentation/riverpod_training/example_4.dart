import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/state/example_4/names.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Example4 extends ConsumerWidget {
  const Example4({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesProvider);
    return names.when(
      data: (names)=> ListView.builder(
        shrinkWrap: true,
        itemCount: names.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(names.elementAt(index)),
          );
        },
      ),
      error: (error, stack) => const Text("Reached the end of the users"),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
