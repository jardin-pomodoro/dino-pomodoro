import 'package:flutter_dino_app/core/success.dart';
import 'package:flutter_dino_app/data/datasource/api/mapper/tree_mapper.dart';

import 'package:flutter_dino_app/domain/models/tree.dart';

import '../../../../domain/repositories/tree_repository.dart';
import '../api_consumer.dart';
import '../entity/tree_entity.dart';

class RemoteTreeRepository implements TreeRepository {
  final ApiConsumer apiConsumer;

  RemoteTreeRepository(this.apiConsumer);

  @override
  Future<Success<List<Tree>>> retrieveTreeRepository(String userId, DateTime startDate, DateTime endDate) async {
    try {
      print('appel au repository');
      print(apiConsumer.pb);
      print('userId: $userId');
      //final String startDateUtc = DateTime(date.year, date.month, 1).toIso8601String();
      //final String endDateUtc = DateTime(date.year, date.month + 1, 0).toIso8601String();
      final String startDateUtc = startDate.toIso8601String();
      final String endDateUtc = endDate.toIso8601String();
      print(startDateUtc);
      print(endDateUtc);
      final treesFromRequest =
          await apiConsumer.pb.collection(Collection.tree.name).getFullList(
                batch: 200,
                filter: "user = '$userId' && ended >= '$startDateUtc' && ended <= '$endDateUtc'",
                expand: 'seed_type',
              );
      print(treesFromRequest.length);
      print('treesFromRequest: $treesFromRequest');
      print('appel au treesFromRequest');
      final trees = treesFromRequest
          .map((e) => TreeEntity.fromJson(e.toJson()))
          .map(TreeMapper.fromEntity)
          .toList();
      print('trees: $trees');
      return Success(data: trees);
    } catch (e) {
      print('e: $e');
      return Success.fromFailure(failureMessage: e.toString());
    }
  }
}
