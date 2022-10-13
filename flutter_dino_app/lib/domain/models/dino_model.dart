import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DinoId extends Equatable {
  final int id;

  const DinoId(this.id);

  @override
  List<Object?> get props => [id];
}

enum DinoEvolutionStep { egg, baby, adult }

class DinoModel extends Equatable {
  final DinoId id;
  final Color color;
  final DinoEvolutionStep step;
  final String name;
  final DateTime openningTime;

  const DinoModel({
    required this.id,
    required this.color,
    required this.step,
    required this.name,
    required this.openningTime,
  });

  @override
  List<Object?> get props => [id, color, step, name, openningTime];
}
