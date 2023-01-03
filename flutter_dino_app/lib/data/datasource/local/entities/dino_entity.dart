import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TreeEnitity extends Equatable {
  final int treeId;
  final Color color;
  final int form;

  const TreeEnitity({
    required this.treeId,
    required this.color,
    required this.form,
  });

  @override
  List<Object?> get props => [treeId, color, form];
}
