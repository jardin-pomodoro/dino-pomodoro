import '../models/tree_model.dart';

abstract class TreeRepository {
  Future<void> addTree(TreeModel tree);

  Future<void> deleteTree(int id);

  Future<List<TreeModel>> getAllTree();
}
