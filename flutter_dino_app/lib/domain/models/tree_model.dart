import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class TreeModel extends Equatable {
  final String treeId;
  final int form;
  final Color color;

  const TreeModel(this.treeId, this.form, this.color);
  
  @override
  List<Object?> get props => [treeId, form, color];
}