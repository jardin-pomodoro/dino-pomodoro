import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DinoEnitity extends Equatable {
  final int id;
  final Color color;
  final String step;
  final String name;
  final DateTime openningTime;

  const DinoEnitity({
    required this.id,
    required this.color,
    required this.step,
    required this.name,
    required this.openningTime,
  });

  @override
  List<Object?> get props => [id, color, step, name, openningTime];
}
