import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../theme/theme.dart';

class SwipeArrow extends StatelessWidget {
  const SwipeArrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: PomodoroTheme.secondary,
          ),
          onPressed: () {
            // Action lorsque la flèche gauche est appuyée
          },
        ),
        const Center(
          child: Text("23 Juillet 2012", style: PomodoroTheme.title4),
        ),
        IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.arrowRight,
            color: PomodoroTheme.secondary,
          ),
          onPressed: () {
            // Action lorsque la flèche droite est appuyée
          },
        ),
      ],
    );
  }
}
