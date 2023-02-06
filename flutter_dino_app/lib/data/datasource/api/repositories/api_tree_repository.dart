import 'package:flutter_dino_app/domain/models/growing.dart';

import '../../../../core/success.dart';
import '../../../../domain/models/tree.dart';
import '../../../../domain/models/user.dart';
import '../../../../domain/repositories/tree_repository.dart';
import '../api_consumer.dart';
import '../entity/tree_entity.dart';
import '../mapper/tree_mapper.dart';

class RemoteTreeRepository implements TreeRepository {
  final ApiConsumer apiConsumer;

  RemoteTreeRepository(this.apiConsumer);

  @override
  Future<Success<List<Tree>>> retrieveTreeRepository(
      String userId, DateTime startDate, DateTime endDate) async {
    try {
      final String startDateUtc = startDate.toString();
      final String endDateUtc = endDate.toString();
      print('before request: $startDateUtc $endDateUtc');
      final treesFromRequest =
          await apiConsumer.pb.collection(Collection.tree.name).getFullList(
                batch: 200,
                filter:
                    "user = '$userId' && ended >= '$startDateUtc' && ended <= '$endDateUtc'",
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

  @override
  Future<Success<Tree>> addNewTree(User user, CreateTree createTree) async {
    final record = await apiConsumer.addTree(createTree);
    await apiConsumer.updateUserBalance(user.id, user.balance + createTree.reward);
    final treeEntity = TreeEntity.fromJson(record.toJson());
    return Success(data: TreeMapper.fromEntity(treeEntity));
  }
}
