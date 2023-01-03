import 'package:flutter_dino_app/data/datasource/entities/dino_entity.dart';
import 'package:flutter_dino_app/domain/models/tree_model.dart';

class TreeMapper {
  static TreeModel mapEntityToDomain(TreeEnitity enitity) {
    return TreeModel(enitity.treeId, entity.form, entity.color);
  }
}