import 'package:flutter/material.dart';
import 'package:flutter_dino_app/data/datasource/local/entities/tree_entity.dart';
import 'package:flutter_dino_app/data/mapper/tree_mapper.dart';
import 'package:flutter_dino_app/domain/models/tree_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test map entity to domain model', () {
    const treeEntity = TreeEnitity(treeId: "1", color: Colors.amber, form: 12);
    const expected = TreeModel(
      "1",
      12,
      Colors.amber
    );
    expect(expected, TreeMapper.mapEntityToDomain(treeEntity));
  });
}
