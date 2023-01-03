import 'package:flutter_dino_app/data/datasource/local/entities/tree_entity.dart';
import 'package:flutter_dino_app/domain/models/tree_model.dart';

class TreeMapper {
  static TreeModel mapEntityToDomain(TreeEnitity enitity) {
    return TreeModel(enitity.treeId, enitity.form, enitity.color);
  }
}