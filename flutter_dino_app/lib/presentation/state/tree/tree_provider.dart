import 'dart:async';

import 'package:flutter_dino_app/core/success.dart';
import 'package:flutter_dino_app/domain/services/tree_service.dart';

import '../../../data/datasource/local/repositories/local_tree_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/tree.dart';
import '../../screen/forest_screen/forest_screen_widget.dart';

class TreeByTypeUI {
  final String imagePath;
  final int seedsUsed;

  TreeByTypeUI({
    required this.imagePath,
    required this.seedsUsed,
  });
}


final fetchTreeByTypeUI = FutureProvider<List<TreeByTypeUI>>((ref) async {
  final slider = ref.watch(calendarGranularityProvider);
  final treeService = TreeService(
      localRepository: LocalTreeRepository(), granularity: slider);
  final retrieveTree = await treeService.retrieveTree();
  if (!retrieveTree.isSuccess) {
    return Future.value([]);
  }

  final trees = retrieveTree.data;
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

final fetchTreeCalendar = FutureProvider((ref) async {

  final calendarGranularity = ref.watch(calendarGranularityProvider);
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
  if(calendarGranularity == CalendarGranularity.day) {
    dataPast = dataByGranularity.sublist(0, 24);
  } else if (calendarGranularity == CalendarGranularity.week) {
    dataPast = dataByGranularity.sublist(0, 7);
  } else if (calendarGranularity == CalendarGranularity.month) {
    dataPast = dataByGranularity.sublist(0, 30);
  } else if (calendarGranularity == CalendarGranularity.year) {
    dataPast = dataByGranularity.sublist(0, 12);
  }
  return Future.value(dataPast);
});

final fetchTreeProvider = FutureProvider<Success<List<Tree>>>((ref) async {
  //final ApiConsumer consumer = ref.read(apiProvider);
  final slider = ref.watch(calendarGranularityProvider);
  final treeService = TreeService(
      localRepository: LocalTreeRepository(), granularity: slider);
  return treeService.retrieveTree();
});
