import '../datasource/local/entities/tree_entity.dart';
import '../../domain/models/tree_model.dart';

class TreeMapper {
  static TreeModel mapEntityToDomain(TreeEnitity enitity) {
    return TreeModel(enitity.treeId, enitity.form, enitity.color);
  }
}
