import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CalendarGranularity {
  day,
  week,
  month,
  year,
}

final calendarGranularityProvider = StateProvider<CalendarGranularity>(
  (ref) => CalendarGranularity.day,
);
