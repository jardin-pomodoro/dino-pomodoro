import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/screen/forest_screen/swipe_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../state/tree/tree_provider.dart';
import '../../router.dart';
import '../../theme/theme.dart';
import '../../widgets/snackbar.dart';
import 'no_tree_card.dart';
import 'widget/calendar_chart.dart';
import 'widget/list-horizontal-slide.dart';

enum CalendarGranularity {
  day,
  week,
  month,
  year,
}

final calendarGranularityProvider = StateProvider<CalendarGranularity>(
  (ref) => CalendarGranularity.day,
);

class ForestScreenWidget extends ConsumerWidget {
  static void navigateTo(BuildContext context) {
    context.go(RouteNames.forest);
  }

  static String slidingChoice = "Jour";
  static String granularity = "day";

  const ForestScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final treesByTypeUi = ref.watch(fetchTreeByTypeUI);
    final calendarStats = ref.watch(fetchTreeCalendar);

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
                  child: CupertinoSlidingSegmentedControl<CalendarGranularity>(
                    backgroundColor: PomodoroTheme.secondary,
                    thumbColor: PomodoroTheme.yellow,
                    groupValue: ref.watch(calendarGranularityProvider),
                    onValueChanged: (value) => ref
                        .read(calendarGranularityProvider.notifier)
                        .state = value!,
                    children: const <CalendarGranularity, Widget>{
                      CalendarGranularity.day: Text('jour'),
                      CalendarGranularity.week: Text('semaine'),
                      CalendarGranularity.month: Text('mois'),
                      CalendarGranularity.year: Text('année'),
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: SwipeCalendar(
                    granularityDisplayed:
                        ref.watch(calendarGranularityProvider),
                  ),
                ),
                treesByTypeUi.when(
                  data: (trees) {
                    print('length');
                    print(trees.length);
                    if (trees.isEmpty) {
                      return NoTreeCard();
                    }
                    return ListHorizontalSlide(
                      treesStatsUi: trees
                          .map((tree) => TreeStatsUi(
                                image: tree.imagePath,
                                number: tree.seedsUsed,
                              ))
                          .toList(),
                    );
                  },
                  error: (error, stackTrace) => const CupertinoAlertDialog(
                      title:
                          Text("une erreur est survenue réessayez plus tard")),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: calendarStats.when(
              data: (stats) {
                if (!stats.every((element) => element == 0)) {
                  return CalendarChart(
                    granularity: ref.watch(calendarGranularityProvider),
                    dataByGranularity: stats,
                  );
                }
              },
              error: (error, stackTrace) => const CupertinoAlertDialog(
                  title: Text("une erreur est survenue réessayez plus tard")),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
