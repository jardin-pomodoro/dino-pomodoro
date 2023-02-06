import 'package:flutter_dino_app/presentation/screen/friends_screen/widgets/friends_tab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/api/api_consumer.dart';
import '../../data/datasource/api/repositories/api_tree_repository.dart';
import '../../data/datasource/local/repositories/local_tree_repository.dart';
import '../../domain/services/tree_service.dart';
import '../../presentation/screen/forest_screen/swipe_calendar.dart';
import '../../presentation/screen/forest_screen/widget/canular_granularity.dart';
import '../api_consumer/api_consumer.dart';
import 'tree_provider.dart';
import 'tree_provider_utils/manipulate_trees_for_calendar.dart';

final fetchFriendTreeByTypeUI = FutureProvider<List<TreeByTypeUI>>((ref) async {
  final granularity = ref.watch(calendarGranularityProvider);
  final ApiConsumer consumer = ref.read(apiProvider);
  final friendId = ref.watch(friendDialogProvider);
  final selectedDate = ref.watch(dateTimeSelectedProvider);
  final treeService = TreeService(
    remoteRepository: RemoteTreeRepository(consumer),
    localRepository: LocalTreeRepository(),
  );
  if (friendId == null) {
    return Future.value([]);
  }
  final retrieveTree = await treeService.retrieveTree(
    friendId,
    selectedDate,
    granularity,
  );
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

final fetchFriendTreeCalendar = FutureProvider<List<int>>((ref) async {
  final granularity = ref.watch(calendarGranularityProvider);
  final selectedDate = ref.watch(dateTimeSelectedProvider);
  final ApiConsumer consumer = ref.read(apiProvider);
  final friendId = ref.watch(friendDialogProvider);
  final treeService = TreeService(
    remoteRepository: RemoteTreeRepository(consumer),
    localRepository: LocalTreeRepository(),
  );
  if (friendId == null) {
    return Future.value([]);
  }
  final retrieveTree = await treeService.retrieveTree(
    friendId,
    selectedDate,
    granularity,
  );
  return Future.value(
    getDataForCalendar(retrieveTree.data!, granularity, selectedDate),
  );
});
