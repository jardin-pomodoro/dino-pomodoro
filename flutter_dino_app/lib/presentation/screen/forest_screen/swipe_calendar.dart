import 'package:flutter/cupertino.dart';
import 'package:flutter_dino_app/presentation/screen/forest_screen/widget/swipe_arrow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'forest_screen_widget.dart';

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
      text: ref.watch(dateTimeSelectedProvider).toString(),
      valueChanged: (value) =>
          ref.read(dateTimeSelectedProvider.notifier).state = value!,
    );
  }

  goToPreviousDate(WidgetRef ref) {
    final dateTime = ref.watch(dateTimeSelectedProvider);

  }

  goToNextDate(WidgetRef ref) {

  }

  formatDateTimeWithGranularity(DateTime date) {
    Intl.defaultLocale = 'fr_FR';
    switch (granularityDisplayed) {
      case CalendarGranularity.day:
        return DateFormat.yMMMMEEEEd().format(date);
      case CalendarGranularity.week:
        return "${DateFormat.yMMMd().format(date)} - ${DateFormat.yMMMd().format(date.)}";
      case CalendarGranularity.month:
        return date.toLocal();
      case CalendarGranularity.year:
        return date.toString();
    }
  }
}
