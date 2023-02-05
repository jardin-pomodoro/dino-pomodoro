import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/success.dart';
import '../../../data/datasource/local/repositories/local_tree_repository.dart';
import '../../../domain/models/tree.dart';
import '../../../domain/services/tree_service.dart';
import '../../../state/api_consumer/api_consumer.dart';
import '../../../state/pomodoro_states/auth_state_notifier.dart';
import '../../data/datasource/api/api_consumer.dart';
import '../../data/datasource/api/repositories/api_tree_repository.dart';
import '../../presentation/screen/forest_screen/forest_screen_widget.dart';

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
  final treeService = TreeService(
    remoteRepository: RemoteTreeRepository(consumer),
    localRepository: LocalTreeRepository(),
  );
  final retrieveTree = await treeService.retrieveTree(
      userAuth.user.id, DateTime.utc(2022, 11, 8), granularity);
  print('retrieveTree: $retrieveTree');
  print(retrieveTree.data);
  if (!retrieveTree.isSuccess) {
    return Future.value([]);
  }

  final trees = retrieveTree.data;
  print('trees: $trees');
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

Future<List<int>> getDataForCalendar(List<Tree> trees,
    CalendarGranularity granularity, DateTime selectedDate) async {
  print('calendar');
  print('trees');
  print(trees.length);
  print('granularity');
  print(granularity);
  print('selectedDate');
  print(selectedDate);
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
  if (granularity == CalendarGranularity.day) {
    dataPast = dataByGranularity.sublist(0, 24);
    final Map<DateTime, int> dateMap = dataPast.asMap().map((key, value) =>
        MapEntry(
            DateTime.utc(
                selectedDate.year, selectedDate.month, selectedDate.day, key),
            0));
    // si heure différente alors écart de minute entre l'heure d'après et l'heure d'avant
    trees.forEach((element) {
      final startDate = element.started;
      final endedDate = element.ended;
      // si c'est la même heure on ajoute dans l'heure des deux
      var differenceInMinutes = endedDate.difference(startDate).inMinutes;
      var dateOfStart = startDate;
      while (differenceInMinutes > 60) {
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
    print('dateMap');
    print(dateMap);
    return Future.value(dateMap.values.toList());
  } else if (granularity == CalendarGranularity.week) {
    print('ici mon reuf');
    dataPast = dataByGranularity.sublist(0, 7);
    final firstDayOfTheWeek = getFirstDayOfWeek(selectedDate);
    final lastDayOfTheWeek = getLastDayOfWeek(selectedDate);
    final Map<DateTime, int> dateMapForAWeek = dataPast.asMap().map(
        (key, value) => MapEntry(
            DateTime.utc(firstDayOfTheWeek.year, firstDayOfTheWeek.month,
                firstDayOfTheWeek.day + key),
            0));
    // si heure différente alors écart de minute entre l'heure d'après et l'heure d'avant
    trees.forEach((element) {
      if (element.started.day == element.ended.day) {
        print('element.started == element.ended');
        print(element.started);
        print(element.ended);

        dateMapForAWeek.update(
            DateTime.utc(element.started.year, element.started.month,
                element.started.day, 0),
            (value) =>
                value + element.ended.difference(element.started).inMinutes);
      }
    });
    print('dateMap');
    print(dateMapForAWeek);
    return Future.value(dateMapForAWeek.values.toList());
  } else if (granularity == CalendarGranularity.month) {
    dataPast = dataByGranularity.sublist(0, 31);
    final firstDayOfMonth =
        DateTime.utc(selectedDate.year, selectedDate.month, 1, 0);
    final lastDayOfMonth =
        DateTime.utc(selectedDate.year, selectedDate.month + 1, 0, 0);
    final Map<DateTime, int> dateMapForAWeek = dataPast.asMap().map(
        (key, value) => MapEntry(
            DateTime.utc(firstDayOfMonth.year, firstDayOfMonth.month,
                firstDayOfMonth.day + key, 0),
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
    return Future.value(dateMapForAWeek.values.toList());
  } else if (granularity == CalendarGranularity.year) {
    dataPast = dataByGranularity.sublist(0, 12);
    final firstDayOfYear = DateTime.utc(selectedDate.year, 1, 1, 0);
    final Map<DateTime, int> dateMapForAYear = dataPast.asMap().map(
        (key, value) => MapEntry(
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
    return Future.value(dateMapForAYear.values.toList());
  }
  return Future.value([]);
}

DateTime getFirstDayOfWeek(DateTime date) {
  int dayOfWeek = date.weekday;

  return date.subtract(Duration(days: dayOfWeek - 1));
}

DateTime getLastDayOfWeek(DateTime date) {
  int dayOfWeek = date.weekday;
  return date
      .add(Duration(days: 7 - dayOfWeek))
      .subtract(const Duration(days: 1));
}

final fetchTreeCalendar = FutureProvider((ref) async {
  final granularity = ref.watch(calendarGranularityProvider);
  final ApiConsumer consumer = ref.read(apiProvider);
  final userAuth = ref.watch(authStateNotifierProvider);
  final treeService = TreeService(
      remoteRepository: RemoteTreeRepository(consumer),
      localRepository: LocalTreeRepository());
  final selectedDate = DateTime.utc(2022, 11, 8);
  final retrieveTree = await treeService.retrieveTree(
      userAuth.user.id, selectedDate, granularity);
  final calendarValues =
      await getDataForCalendar(retrieveTree.data!, granularity, selectedDate);
  return Future.value(calendarValues);
});

final fetchTreeProvider = FutureProvider<Success<List<Tree>>>((ref) async {
  //final ApiConsumer consumer = ref.read(apiProvider);
  final granularity = ref.watch(calendarGranularityProvider);
  final ApiConsumer consumer = ref.read(apiProvider);
  final userAuth = ref.watch(authStateNotifierProvider);
  final treeService = TreeService(
    remoteRepository: RemoteTreeRepository(consumer),
    localRepository: LocalTreeRepository(),
  );
  return treeService.retrieveTree(
      userAuth.user.id, DateTime.utc(2022, 11, 8), granularity);
});
