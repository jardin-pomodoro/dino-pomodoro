import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class FocusCard extends StatelessWidget {

 final List<int> stats;

  const FocusCard({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: PomodoroTheme.secondary,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Vous êtes résté concetré ${stats.reduce((value, element) => value += element)} minutes",
              style: const TextStyle(
                  color: PomodoroTheme.white,
                  fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }

}