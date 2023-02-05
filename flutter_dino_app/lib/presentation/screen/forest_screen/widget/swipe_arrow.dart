import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/screen/forest_screen/forest_screen_widget.dart';
import '../../../theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SwipeArrow extends StatelessWidget {
  final String text;
  final Function() clickRight;
  final Function() clickLeft;
  const SwipeArrow({
    Key? key,
    required this.text,
    required this.clickRight,
    required this.clickLeft,
  }) : super(key: key);

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
            clickLeft();
          },
        ),
        Center(
          child: Text(text, style: PomodoroTheme.title4),
        ),
        IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.arrowRight,
            color: PomodoroTheme.secondary,
          ),
          onPressed: () {
            clickRight();
          },
        ),
      ],
    );
  }
}
