import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:flutter_dino_app/presentation/screen/forest_screen/widget/swipe_arrow.dart';
import 'package:go_router/go_router.dart';

import '../friends_screen/widgets/slider_choice.dart';

class ForestScreenWidget extends StatefulWidget {
  static void navigateTo(BuildContext context) {
    context.go(RouteNames.forest);
  }

  const ForestScreenWidget({Key? key}) : super(key: key);

  @override
  State<ForestScreenWidget> createState() => _ForestScreenWidgetState();
}

class _ForestScreenWidgetState extends State<ForestScreenWidget> {
  String slidingChoice = "Jour";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: SliderChoice(
              items: const [
                "Jour",
                "Semaine",
                "Mois",
                "Année",
              ],
              changeSlidingChoice: _changeSlidingChoice,
            ),
          ),
          SwipeArrow(),
        ],
      ),
    );
  }

  void _changeSlidingChoice(String choice) {
    setState(() {
      slidingChoice = choice;
    });
  }
}
