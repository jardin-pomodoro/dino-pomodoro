import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../config/date_config.dart';
import '../../../../utils/date.dart';
import 'canular_granularity.dart';
import 'swipe_arrow.dart';

final dateTimeSelectedProvider =
    StateProvider<DateTime>((ref) => DateTime.now());

class SwipeCalendar extends ConsumerWidget {
  final CalendarGranularity granularityDisplayed;

  const SwipeCalendar({
    Key? key,
    required this.granularityDisplayed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwipeArrow(
      text: formatDateTimeWithGranularity(ref.watch(dateTimeSelectedProvider)),
      clickLeft: () => goToPreviousDate(ref),
      clickRight: () => goToNextDate(ref),
    );
  }

  goToPreviousDate(WidgetRef ref) {
    final dateTime = ref.watch(dateTimeSelectedProvider);
    switch (granularityDisplayed) {
      case CalendarGranularity.day:
        ref.read(dateTimeSelectedProvider.notifier).state =
            dateTime.subtract(const Duration(days: 1));
        break;
      case CalendarGranularity.week:
        ref.read(dateTimeSelectedProvider.notifier).state =
            dateTime.subtract(const Duration(days: 7));
        break;
      case CalendarGranularity.month:
        ref.read(dateTimeSelectedProvider.notifier).state =
            DateTime(dateTime.year, dateTime.month - 1, dateTime.day, 0);
        break;
      case CalendarGranularity.year:
        ref.read(dateTimeSelectedProvider.notifier).state =
            DateTime(dateTime.year - 1, dateTime.month, dateTime.day, 0);
        break;
    }
  }

  goToNextDate(WidgetRef ref) {
    final dateTime = ref.watch(dateTimeSelectedProvider);
    switch (granularityDisplayed) {
      case CalendarGranularity.day:
        ref.read(dateTimeSelectedProvider.notifier).state =
            dateTime.add(const Duration(days: 1));
        break;
      case CalendarGranularity.week:
        ref.read(dateTimeSelectedProvider.notifier).state =
            dateTime.add(const Duration(days: 7));
        break;
      case CalendarGranularity.month:
        ref.read(dateTimeSelectedProvider.notifier).state =
            DateTime(dateTime.year, dateTime.month + 1, dateTime.day, 0);
        break;
      case CalendarGranularity.year:
        ref.read(dateTimeSelectedProvider.notifier).state =
            DateTime(dateTime.year + 1, dateTime.month, dateTime.day, 0);
        break;
    }
  }

  String formatDateTimeWithGranularity(DateTime date) {
    switch (granularityDisplayed) {
      case CalendarGranularity.day:
        return DateFormat.yMMMMEEEEd(DateConfig.localUsed).format(date);
      case CalendarGranularity.week:
        return "${DateFormat.yMMMd(DateConfig.localUsed).format(getFirstDayOfWeek(date))} - ${DateFormat.yMMMd('fr').format(getLastDayOfWeek(date))}";
      case CalendarGranularity.month:
        return DateFormat.yMMMM(DateConfig.localUsed).format(date);
      case CalendarGranularity.year:
        return DateFormat.y(DateConfig.localUsed).format(date);
    }
  }
}
