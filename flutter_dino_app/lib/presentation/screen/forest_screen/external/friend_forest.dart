import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dino_app/state/tree/tree_friend_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/models/user.dart';
import '../../../theme/theme.dart';
import '../swipe_calendar.dart';
import '../widget/canular_granularity.dart';
import '../widget/focus_card.dart';
import '../widget/list-horizontal-slide.dart';

class FriendForest extends ConsumerWidget {
  final User friend;
  const FriendForest({
    Key? key,
    required this.friend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final treesByTypeUi = ref.watch(fetchFriendTreeByTypeUI);
    final calendarStats = ref.watch(fetchFriendTreeCalendar);

    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          friend.username.toUpperCase(),
          style: PomodoroTheme.title2,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: CupertinoSlidingSegmentedControl<CalendarGranularity>(
            backgroundColor: PomodoroTheme.secondary,
            thumbColor: PomodoroTheme.yellow,
            groupValue: ref.watch(calendarGranularityProvider),
            onValueChanged: (value) =>
                ref.read(calendarGranularityProvider.notifier).state = value!,
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
            granularityDisplayed: ref.watch(calendarGranularityProvider),
          ),
        ),
        treesByTypeUi.when(
          data: (trees) => ListHorizontalSlide(
            treesStatsUi: trees
                .map((tree) => TreeStatsUi(
                      image: tree.imagePath,
                      number: tree.seedsUsed,
                    ))
                .toList(),
          ),
          error: (error, stackTrace) => Text('error ref $error'),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
        const SizedBox(height: 30),
        calendarStats.when(
          data: (stats) => FocusCard(stats: stats),
          error: (error, stackTrace) => const CupertinoAlertDialog(
            title: Text("une erreur est survenue réessayez plus tard"),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}
