import 'package:flutter_dino_app/data/datasource/api/entity/tree_entity.dart';

import '../../core/success.dart';
import '../models/growing.dart';
import '../models/tree.dart';
import '../models/user.dart';

abstract class TreeRepository {
  Future<Success<List<Tree>>> retrieveTreeRepository(
      String userId, DateTime startDate, DateTime endDate);

  Future<Success<Tree>> addNewTree(User user, CreateTree createTree);
}
