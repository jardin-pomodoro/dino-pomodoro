import 'dart:math';

import 'package:dartz/dartz.dart';

import 'package:flutter_dino_app/domain/models/tree.dart';

import '../../../../domain/models/seed_type_expand.dart';
import '../../../../domain/repositories/remy_tree_repository.dart';
import '../../../../presentation/state/pomodoro_states/forest_state.dart';

class LocalRemyTreeRepository implements RemyTreeRepository {
  @override
  Future<Either<RetrieveRemyTreeRepositoryFailure, List<Tree>>> retrieveRemyTreeRepository() {
    final forest = List<Tree>.generate(
      50,
          (index) {
        final started = DateTime.now().subtract(Duration(
          days: Random().nextInt(20),
          hours: Random().nextInt(24),
          minutes: Random().nextInt(60),
        ));
        final ended = started.add(Duration(
          days: Random().nextInt(20),
          hours: Random().nextInt(24),
          minutes: Random().nextInt(60),
        ));
        final seedType = seedsType[Random().nextInt(seedsType.length)];
        return Tree(
          created: DateTime.now(),
          updated: DateTime.now(),
          started: started,
          ended: ended,
          reward: Random().nextInt(100),
          timeToGrow: started.difference(ended).inMinutes,
          expand: SeedTypeExpand(seedType: seedType),
          seedType: seedType.id,
          user: Random().nextBool() ? userId1 : userId2,
          id: index.toString(),
          collectionId: "1",
          collectionName: "Tree collection",
        );
      },
    );
    return Future.delayed(const Duration(seconds: 2)).then((value) => right(forest));
  }
}