import 'dart:math';

import 'package:flutter_dino_app/data/datasource/api/entity/tree_entity.dart';
import 'package:flutter_dino_app/domain/models/growing.dart';

import '../../../../core/success.dart';
import '../../../../domain/models/seed_type_expand.dart';
import '../../../../domain/models/tree.dart';
import '../../../../domain/models/user.dart';
import '../../../../domain/repositories/tree_repository.dart';
import '../../../../state/pomodoro_states/forest_state.dart';

class LocalTreeRepository implements TreeRepository {
  @override
  Future<Success<List<Tree>>> retrieveTreeRepository(
      String userId, DateTime startDate, DateTime endDate) {
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
    return Future.delayed(const Duration(seconds: 2))
        .then((value) => Success(data: forest));
  }

  @override
  Future<Success<Tree>> addNewTree(User user, CreateTree createTree ) {
    return Future.value(Success.fromFailure(failureMessage: 'Not implemented'));
  }
}
