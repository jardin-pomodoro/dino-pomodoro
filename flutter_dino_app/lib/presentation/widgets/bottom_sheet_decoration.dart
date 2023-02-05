import 'package:flutter/material.dart';

Decoration bottomSheetDecoration() {
  return const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(25.0),
      topRight: Radius.circular(25.0),
    ),
  );
}
