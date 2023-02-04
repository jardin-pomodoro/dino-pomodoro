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
      final String startDateUtc = startDate.toString();
      final String endDateUtc = endDate.toString();
      print('before request: $startDateUtc $endDateUtc');
      final treesFromRequest =
          await apiConsumer.pb.collection(Collection.tree.name).getFullList(
                batch: 200,
                filter: "user = '$userId' && ended >= '$startDateUtc' && ended <= '$endDateUtc'",
                expand: 'seed_type',
              );
      print(treesFromRequest.length);
      final trees = treesFromRequest
          .map((e) => TreeEntity.fromJson(e.toJson()))
          .map(TreeMapper.fromEntity)
          .toList();
      return Success(data: trees);
    } catch (e) {
      print('e: $e');
      return Success.fromFailure(failureMessage: e.toString());
    }
  }
}
