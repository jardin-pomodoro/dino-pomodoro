import '../../../../domain/models/tree_model.dart';

import '../../../../domain/repositories/tree_repository.dart';

class TreeRepositorySqlite implements TreeRepository {
  @override
  Future<void> addTree(TreeModel tree) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTree(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<TreeModel>> getAllTree() {
    throw UnimplementedError();
  }
}
