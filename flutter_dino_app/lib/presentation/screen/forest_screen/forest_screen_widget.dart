import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../router.dart';
import 'widget/calendar_chart.dart';
import 'widget/list-horizontal-slide.dart';
import 'widget/swipe_arrow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../state/tree/tree_provider.dart';
import '../../theme/theme.dart';

enum CalendarGranularity {
  day,
  week,
  month,
  year,
}

final calendarGranularityProvider = StateProvider<CalendarGranularity>(
      (ref) => CalendarGranularity.day,
);

/*final productsProvider = Provider<List<Tree>>((ref) async {
  final sortType = ref.watch(calendarGranularityProvider);
  switch (sortType) {
    case CalendarGranularity.day:
    case CalendarGranularity.week:
    case CalendarGranularity.month:
    case CalendarGranularity.year:
  }
});*/

class ForestScreenWidget extends ConsumerWidget {
  static void navigateTo(BuildContext context) {
    context.go(RouteNames.forest);
  }

  String slidingChoice = "Jour";
  String granularity = "day";
  List<int> dataByGranularity = [
    10,
    14,
    8,
    2,
    19,
    39,
    09,
    19,
    29,
    63,
    05,
    72,
    27,
    28,
    28,
    27,
    29,
    63,
    05,
    72,
    27,
    28,
    28,
    27,
    29,
    63,
    05,
    72,
    27,
    28,
    28,
    27
  ];
  late List<int> dataPast = [
    10,
    14,
    8,
    2,
    19,
    39,
    09,
    19,
    29,
    63,
    05,
    72,
    27,
    28,
    28,
    27,
    29,
    63,
    05,
    72,
    27,
    28,
    28,
    27,
    29,
    63,
    05,
    72,
    27,
    28,
    28,
    27
  ];

  ForestScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final treesByTypeUi = ref.watch(fetchTreeByTypeUI);

    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: treesByTypeUi.when(
                  data: (trees) => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                            child: CupertinoSlidingSegmentedControl<CalendarGranularity>(
                              backgroundColor: PomodoroTheme.secondary,
                              thumbColor: PomodoroTheme.yellow,
                              groupValue: ref.watch(calendarGranularityProvider),
                              onValueChanged: (value) => ref.read(calendarGranularityProvider.notifier).state = value!,
                              children: const <CalendarGranularity, Widget>{
                                CalendarGranularity.day: Text('jour'),
                                CalendarGranularity.week: Text('semaine'),
                                CalendarGranularity.month: Text('mois'),
                                CalendarGranularity.year: Text('année'),
                              },
                            ),
                            /*child: SliderChoice(
                              items: const [
                                "Jour",
                                "Semaine",
                                "Mois",
                                "Année",
                              ],
                              changeSlidingChoice: _changeSlidingChoice,*/
                            ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: SwipeArrow(),
                          ),
                          ListHorizontalSlide(
                            treesStatsUi:
                              trees.map((tree) =>
                                TreeStatsUi(
                                  image: tree.imagePath,
                                  number: tree.seedsUsed,
                                )
                              ).toList(),
                          ),
                        ],
                      ),
                error: (error, stackTrace) => Text('error ref $error'),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: CalendarChart(
              granularity: granularity,
              dataByGranularity: dataPast,
            ),
          ),
        ],
      ),
    );
  }

  void _changeSlidingChoice(String choice) {

  }
}

/*class ForestScreenWidget extends StatefulWidget {
  static void navigateTo(BuildContext context) {
    context.go(RouteNames.forest);
  }

  const ForestScreenWidget({Key? key}) : super(key: key);

  @override
  State<ForestScreenWidget> createState() => _ForestScreenWidgetState();
}

class _ForestScreenWidgetState extends State<ForestScreenWidget> {
  String slidingChoice = "Jour";
  String granularity = "day";
  List<int> dataByGranularity = [
    10, 14, 8, 2, 19, 39, 09, 19, 29, 63, 05, 72, 27, 28, 28, 27, 29, 63, 05, 72, 27, 28, 28, 27, 29, 63, 05, 72, 27, 28, 28, 27
  ];
  late List<int> dataPast = [
    10, 14, 8, 2, 19, 39, 09, 19, 29, 63, 05, 72, 27, 28, 28, 27, 29, 63, 05, 72, 27, 28, 28, 27, 29, 63, 05, 72, 27, 28, 28, 27
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
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
                Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: SwipeArrow()
                ),
                ListHorizontalSlide(
                  treesStatsUi: [
                    TreeStatsUi(
                        image:
                            'https://pocketbase.nospy.fr/api/files/lajospkke93eknf/klfch9yk075cmpq/canvas_removebg_preview_zRg2OoMJsv.png',
                        number: 10),
                    TreeStatsUi(
                        image:
                            'https://pocketbase.nospy.fr/api/files/lajospkke93eknf/q93aghxz9h1pl7u/canvas3_removebg_preview_AsHORCGEJN.png',
                        number: 5),
                    TreeStatsUi(
                        image:
                            'https://pocketbase.nospy.fr/api/files/lajospkke93eknf/klfch9yk075cmpq/canvas_removebg_preview_zRg2OoMJsv.png',
                        number: 8),
                    TreeStatsUi(
                        image:
                            'https://pocketbase.nospy.fr/api/files/lajospkke93eknf/q93aghxz9h1pl7u/canvas3_removebg_preview_AsHORCGEJN.png',
                        number: 9),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: CalendarChart(
              granularity: granularity,
              dataByGranularity: dataPast,
            ),
          ),
        ],
      ),
    );
  }

  void _changeSlidingChoice(String choice) {
    setState(() {
      slidingChoice = choice;
      if(slidingChoice == "Jour") {
        granularity = "day";
        dataPast = dataByGranularity.sublist(0, 24);
      } else if (slidingChoice == "Semaine") {
        granularity = "week";
        dataPast = dataByGranularity.sublist(0, 7);

      } else if (slidingChoice == "Mois") {
        granularity = "month";
        dataPast = dataByGranularity.sublist(0, 30);
      } else if (slidingChoice == "Année") {
        granularity = "year";
        dataPast = dataByGranularity.sublist(0, 12);
      }
    });
  }
}*/