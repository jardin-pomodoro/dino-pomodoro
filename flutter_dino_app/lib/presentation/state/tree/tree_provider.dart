import 'dart:async';

import 'package:flutter_dino_app/data/datasource/local/repositories/local_remy_tree_repository.dart';
import 'package:flutter_dino_app/domain/usecases/retrieve_tree_usecase.dart';
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
  print("yoyoyo");
  final retrieveTreeUseCase = RetrieveTreeUseCase(
      localRepository: LocalRemyTreeRepository(), granularity: slider);
  final trees = await retrieveTreeUseCase();
  final seedTypeToSeedsUsed = trees.fold({}, (previousValue, tree) {
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


/*final fetchTreeByTypeUI2 = FutureProvider.family<List<TreeByTypeUI>, CalendarGranularity>((ref, calendarGranularity) async {
  print("un appel");
  final retrieveTreeUseCase = RetrieveTreeUseCase(
      localRepository: LocalRemyTreeRepository(), granularity: calendarGranularity);
  final trees = await retrieveTreeUseCase();
  final seedTypeToSeedsUsed = trees.fold({}, (previousValue, tree) {
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
});*/

final fetchTreeProvider = FutureProvider<List<Tree>>((ref) async {
  //final ApiConsumer consumer = ref.read(apiProvider);
  final slider = ref.watch(calendarGranularityProvider);
  final retrieveSeedTypeUseCase = RetrieveTreeUseCase(
      localRepository: LocalRemyTreeRepository(), granularity: slider);
  return retrieveSeedTypeUseCase();
});
