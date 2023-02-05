import 'package:flutter/material.dart';

import '../../../../domain/models/tree.dart';
import '../../../theme/theme.dart';
import '../../../widgets/price_widget.dart';

class TreeRewardDialogWidget extends StatelessWidget {
  final Tree tree;

  const TreeRewardDialogWidget({
    Key? key,
    required this.tree,
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
            Image.network(
              tree.seedTypeExpand.image,
              height: 250,
            ),
            const Text(
              "Votre arbre a poussé !",
              style: PomodoroTheme.title3,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Vous avez gagné",
                  style: PomodoroTheme.textLarge,
                ),
                const SizedBox(
                  width: 5,
                ),
                PriceWidget(
                  price: tree.seedTypeExpand.price,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
