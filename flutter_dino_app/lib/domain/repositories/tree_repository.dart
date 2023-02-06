import '../../core/success.dart';
import '../../data/datasource/api/entity/tree_entity.dart';
import '../models/tree.dart';
import '../models/user.dart';

abstract class TreeRepository {
  Future<Success<List<Tree>>> retrieveTreeRepository(
      String userId, DateTime startDate, DateTime endDate);

  Future<Success<Tree>> addNewTree(User user, CreateTree createTree);
}
