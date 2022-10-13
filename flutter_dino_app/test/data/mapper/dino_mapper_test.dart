import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dino_app/data/datasource/entities/dino_entity.dart';
import 'package:flutter_dino_app/data/mapper/dino_mapper.dart';
import 'package:flutter_dino_app/domain/models/dino_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test map entity to domain model', () {
    final dinoEntity = DinoEnitity(
      id: 1,
      color: Colors.amber,
      step: 'egg',
      name: 'flappy',
      openningTime: DateTime(2021, 1, 1),
    );
    final expected = DinoModel(
      id: DinoId(1),
      color: Colors.amber,
      step: DinoEvolutionStep.egg,
      name: 'flappy',
      openningTime: DateTime(2021, 1, 1),
    );
    expect(expected, DinoMapper.mapEntityToDomain(dinoEntity));
  });
}
