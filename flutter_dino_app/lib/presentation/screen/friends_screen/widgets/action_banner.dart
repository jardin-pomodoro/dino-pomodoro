import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../theme/theme.dart';

class ActionBanner extends StatefulWidget {
  final String body;
  final Function clickOnAction;
  final Function? clickOnActionSecond;
  final FaIcon startIcon;
  final FaIcon actionIcon;
  final FaIcon? actionSecondIcon;

  const ActionBanner({
    super.key,
    required this.body,
    required this.clickOnAction,
    required this.startIcon,
    required this.actionIcon,
    this.actionSecondIcon,
    this.clickOnActionSecond,
  });

  @override
  State<ActionBanner> createState() => _ActionBannerState();
}

class _ActionBannerState extends State<ActionBanner> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: PomodoroTheme.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      leading: widget.startIcon,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.body,
            style: PomodoroTheme.title4White,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            GestureDetector(
              onTap: () {
                widget.clickOnAction(widget.body);
              },
              child: widget.actionIcon,
            ),
            () {
              if (widget.clickOnActionSecond != null) {
                return Padding(
                    padding: const EdgeInsets.all(2),
                    child: GestureDetector(
                      onTap: () {
                        widget.clickOnActionSecond!(widget.body);
                      },
                      child: widget.actionSecondIcon,
                    ));
              }
              return Container();
            }(),
          ]),
        ],
      ),
    );
  }
}
