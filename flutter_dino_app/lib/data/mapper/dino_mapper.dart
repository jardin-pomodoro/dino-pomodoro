import 'package:flutter_dino_app/data/datasource/entities/dino_entity.dart';
import 'package:flutter_dino_app/domain/models/dino_model.dart';

class DinoMapper {
  static DinoModel mapEntityToDomain(DinoEnitity dinoEntity) {
    return DinoModel(
      id: DinoId(dinoEntity.id),
      color: dinoEntity.color,
      step: DinoEvolutionStep.values.firstWhere(
        (element) => element.name == dinoEntity.step,
      ),
      name: dinoEntity.name,
      openningTime: dinoEntity.openningTime,
    );
  }
}
