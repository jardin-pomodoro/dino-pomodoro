import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:flutter_dino_app/presentation/screen/forest_screen/widget/calendar_chart.dart';
import 'package:flutter_dino_app/presentation/screen/forest_screen/widget/list-horizontal-slide.dart';
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
          ListHorizontalSlide(
            treesStatsUi: [
              TreeStatsUi(image: 'https://pocketbase.nospy.fr/api/files/lajospkke93eknf/klfch9yk075cmpq/canvas_removebg_preview_zRg2OoMJsv.png', number: 10),
              TreeStatsUi(image: 'https://pocketbase.nospy.fr/api/files/lajospkke93eknf/q93aghxz9h1pl7u/canvas3_removebg_preview_AsHORCGEJN.png', number: 5),
              TreeStatsUi(image: 'https://pocketbase.nospy.fr/api/files/lajospkke93eknf/klfch9yk075cmpq/canvas_removebg_preview_zRg2OoMJsv.png', number: 8),
              TreeStatsUi(image: 'https://pocketbase.nospy.fr/api/files/lajospkke93eknf/q93aghxz9h1pl7u/canvas3_removebg_preview_AsHORCGEJN.png', number: 9),
            ],
          ),
          CalendarChart(),
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
