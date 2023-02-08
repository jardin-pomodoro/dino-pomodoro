import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garden_pomodoro/state/tree/tree_provider_utils/manipulate_trees_for_calendar.dart';

import '../../../data/datasource/local/repositories/local_tree_repository.dart';
import '../../../domain/services/tree_service.dart';
import '../../../state/api_consumer/api_consumer.dart';
import '../../../state/pomodoro_states/auth_state_notifier.dart';
import '../../data/datasource/api/api_consumer.dart';
import '../../data/datasource/api/repositories/api_tree_repository.dart';
import '../../presentation/screen/forest_screen/widget/swipe_calendar.dart';
import '../../presentation/screen/forest_screen/widget/canular_granularity.dart';

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
  if (trees!.isEmpty) {
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
  return Future.value(
    getDataForCalendar(retrieveTree.data!, granularity, selectedDate),
  );
});
