import '../../../domain/models/tree.dart';
import '../../../presentation/screen/forest_screen/widget/canular_granularity.dart';
import '../../../utils/date.dart';

Map<DateTime, int> treesToDayMap(List<Tree> trees, DateTime selectedDate) {
  const numberOfHoursInADay = 24;
  Map<DateTime, int> dateMap =
      List.generate(numberOfHoursInADay, (index) => null).asMap().map(
          (key, value) => MapEntry(
              DateTime.utc(
                  selectedDate.year, selectedDate.month, selectedDate.day, key),
              0));
  trees.forEach((element) {
    var startDate = element.started;
    var endedDate = element.ended;
    if (selectedDate.day != startDate.day) {
      startDate = DateTime.utc(
          selectedDate.year, selectedDate.month, selectedDate.day, 0, 0);
    } else if (selectedDate.day != endedDate.day) {
      endedDate = DateTime.utc(
          selectedDate.year, selectedDate.month, selectedDate.day, 23, 59);
    }

    var differenceInMinutes = endedDate.difference(startDate).inMinutes;
    var dateOfStart = startDate;
    while (dateOfStart.hour != endedDate.hour &&
        dateOfStart.day == endedDate.day) {
      var dateAfter = DateTime.utc(dateOfStart.year, dateOfStart.month,
          dateOfStart.day, dateOfStart.hour + 1, 0);
      var valueToAdd = dateAfter.difference(dateOfStart).inMinutes;
      dateMap.update(
          DateTime.utc(dateOfStart.year, dateOfStart.month, dateOfStart.day,
              dateOfStart.hour, 0),
          (value) => value + valueToAdd);
      differenceInMinutes -= valueToAdd;
      dateOfStart = dateAfter;
    }
    dateMap.update(dateOfStart, (value) => value + differenceInMinutes);
  });

  return dateMap;
}

Map<DateTime, int> treesToWeekMap(List<Tree> trees, DateTime selectedDate) {
  final firstDayOfTheWeek = getFirstDayOfWeek(selectedDate);
  const numberOfDaysInAWeek = 7;
  final Map<DateTime, int> dateMapForAWeek =
      List.generate(numberOfDaysInAWeek, (index) => null).asMap().map(
          (key, value) => MapEntry(
              DateTime.utc(firstDayOfTheWeek.year, firstDayOfTheWeek.month,
                  firstDayOfTheWeek.day + key),
              0));
  trees.forEach((element) {
    if (element.started.day == element.ended.day) {
      dateMapForAWeek.update(
          DateTime.utc(element.started.year, element.started.month,
              element.started.day, 0),
          (value) =>
              value + element.ended.difference(element.started).inMinutes);
    }
  });
  return dateMapForAWeek;
}

Map<DateTime, int> treesToMonthMap(List<Tree> trees, DateTime selectedDate) {
  final firstDayOfMonth = getFirstDayOfMonth(selectedDate);
  final lastDayOfMonth = getLastDayOfMonth(selectedDate);
  final Map<DateTime, int> dateMapForAMonth = List.generate(
          lastDayOfMonth.difference(firstDayOfMonth).inDays + 1,
          (index) => null)
      .asMap()
      .map((key, value) => MapEntry(
          DateTime.utc(firstDayOfMonth.year, firstDayOfMonth.month,
              firstDayOfMonth.day + key, 0),
          0));
  trees.forEach((element) {
    if (element.started.day == element.ended.day) {
      dateMapForAMonth.update(
          DateTime.utc(element.started.year, element.started.month,
              element.started.day, 0),
          (value) =>
              value + element.ended.difference(element.started).inMinutes);
    }
  });
  return dateMapForAMonth;
}

Map<DateTime, int> treesToYearMap(List<Tree> trees, DateTime selectedDate) {
  final firstDayOfYear = getFirstDayOfYear(selectedDate);
  const numberOfMonthInAYear = 12;
  final Map<DateTime, int> dateMapForAYear = List.generate(
          numberOfMonthInAYear, (index) => null)
      .asMap()
      .map((key, value) => MapEntry(
          DateTime.utc(firstDayOfYear.year, firstDayOfYear.month + key, 1, 0),
          0));
  trees.forEach((element) {
    if (element.started.month == element.ended.month) {
      dateMapForAYear.update(
          DateTime.utc(element.ended.year, element.ended.month, 1, 0, 0),
          (value) =>
              value + element.ended.difference(element.started).inMinutes);
    }
  });
  return dateMapForAYear;
}

List<int> getDataForCalendar(
    List<Tree> trees, CalendarGranularity granularity, DateTime selectedDate) {
  if (granularity == CalendarGranularity.day) {
    return treesToDayMap(trees, selectedDate).values.toList();
  } else if (granularity == CalendarGranularity.week) {
    return treesToWeekMap(trees, selectedDate).values.toList();
  } else if (granularity == CalendarGranularity.month) {
    return treesToMonthMap(trees, selectedDate).values.toList();
  } else if (granularity == CalendarGranularity.year) {
    return treesToYearMap(trees, selectedDate).values.toList();
  }

  return [];
}
