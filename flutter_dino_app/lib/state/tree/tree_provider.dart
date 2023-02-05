import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/datasource/local/repositories/local_tree_repository.dart';
import '../../../domain/models/tree.dart';
import '../../../domain/services/tree_service.dart';
import '../../../state/api_consumer/api_consumer.dart';
import '../../../state/pomodoro_states/auth_state_notifier.dart';
import '../../data/datasource/api/api_consumer.dart';
import '../../data/datasource/api/repositories/api_tree_repository.dart';
import '../../presentation/screen/forest_screen/forest_screen_widget.dart';
import '../../presentation/screen/forest_screen/swipe_calendar.dart';
import '../../utils/date.dart';

class TreeByTypeUI {
  final String imagePath;
  final int seedsUsed;

  TreeByTypeUI({
    required this.imagePath,
    required this.seedsUsed,
  });
}

final fetchTreeByTypeUI = FutureProvider<List<TreeByTypeUI>>((ref) async {
  final granularity = ref.watch(calendarGranularityProvider);
  final ApiConsumer consumer = ref.read(apiProvider);
  final userAuth = ref.watch(authStateNotifierProvider);
  final selectedDate = ref.watch(dateTimeSelectedProvider);
  final treeService = TreeService(
    remoteRepository: RemoteTreeRepository(consumer),
    localRepository: LocalTreeRepository(),
  );
  final retrieveTree = await treeService.retrieveTree(
      userAuth.user.id, selectedDate, granularity);
  if (!retrieveTree.isSuccess) {
    return Future.value([]);
  }
  final trees = retrieveTree.data;
  if(trees!.isEmpty) {
    return Future.value([]);
  }
  final seedTypeToSeedsUsed = trees!.fold({}, (previousValue, tree) {
    if (previousValue.containsKey(tree.expand.seedType.id)) {
      previousValue[tree.expand.seedType.id] += 1;
    } else {
      previousValue[tree.expand.seedType.id] = 1;
    }
    return previousValue;
  });
  final seedTypeToImage =
      seedTypeToSeedsUsed.keys.fold({}, (previousValue, key) {
    previousValue[key] = trees
        .firstWhere((tree) => tree.expand.seedType.id == key)
        .expand
        .seedType
        .image;
    return previousValue;
  });

  final result = seedTypeToSeedsUsed.keys
      .toList()
      .map(
        (seedTypeToSeedUsed) => TreeByTypeUI(
          imagePath: seedTypeToImage[seedTypeToSeedUsed],
          seedsUsed: seedTypeToSeedsUsed[seedTypeToSeedUsed],
        ),
      )
      .toList();
  return Future.value(result);
});

List<int> getDataForCalendar(List<Tree> trees,
    CalendarGranularity granularity, DateTime selectedDate) {
  const numberOfHoursInADay = 24;
  if (granularity == CalendarGranularity.day) {
    Map<DateTime, int> dateMap = List.generate(
            numberOfHoursInADay, (index) => null)
        .asMap()
        .map((key, value) => MapEntry(
            DateTime.utc(
                selectedDate.year, selectedDate.month, selectedDate.day, key),
            0));
    print("trees");
    print(trees.length);
    print(trees.map((e) => e.started));
    print(trees.map((e) => e.ended));
    trees.forEach((element) {
      var startDate = element.started;
      var endedDate = element.ended;
      if(selectedDate.day != startDate.day ) {
        startDate = DateTime.utc(
            selectedDate.year, selectedDate.month, selectedDate.day, 0, 0);
      } else if(selectedDate.day != endedDate.day) {
        endedDate = DateTime.utc(
            selectedDate.year, selectedDate.month, selectedDate.day, 23, 59);
      }

      var differenceInMinutes = endedDate.difference(startDate).inMinutes;
      var dateOfStart = startDate;
      while (dateOfStart.hour != endedDate.hour && dateOfStart.day == endedDate.day) {
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
    return dateMap.values.toList();
  } else if (granularity == CalendarGranularity.week) {
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
    return dateMapForAWeek.values.toList();
  } else if (granularity == CalendarGranularity.month) {
    final firstDayOfMonth = getFirstDayOfMonth(selectedDate);
    final lastDayOfMonth = getLastDayOfMonth(selectedDate);
    print('${lastDayOfMonth.difference(firstDayOfMonth).inDays}');
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
    return dateMapForAMonth.values.toList();
  } else if (granularity == CalendarGranularity.year) {
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
    return dateMapForAYear.values.toList();
  }
  return [];
}

final fetchTreeCalendar = FutureProvider((ref) async {
  final granularity = ref.watch(calendarGranularityProvider);
  final selectedDate = ref.watch(dateTimeSelectedProvider);
  final ApiConsumer consumer = ref.read(apiProvider);
  final userAuth = ref.watch(authStateNotifierProvider);
  final treeService = TreeService(
      remoteRepository: RemoteTreeRepository(consumer),
      localRepository: LocalTreeRepository());
  final retrieveTree = await treeService.retrieveTree(
      userAuth.user.id, selectedDate, granularity);
  return Future.value(getDataForCalendar(retrieveTree.data!, granularity, selectedDate));
});
