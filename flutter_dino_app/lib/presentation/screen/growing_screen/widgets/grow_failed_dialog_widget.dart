import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class GrowFailedDialogWidget extends StatelessWidget {
  const GrowFailedDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: PomodoroTheme.accent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: PomodoroTheme.white,
          width: 2,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/dead_tree.png"),
            const Text(
              "Oh non !",
              style: PomodoroTheme.title3,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Votre arbre est mort...",
              style: PomodoroTheme.title4,
            ),
          ],
        ),
      ),
    );
  }
}
