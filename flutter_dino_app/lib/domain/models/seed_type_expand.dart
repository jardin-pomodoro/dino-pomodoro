import 'package:flutter/material.dart';
import 'seed_type.dart';

@immutable
class SeedTypeExpand {
  final SeedType seedType;

  const SeedTypeExpand({required this.seedType});

  factory SeedTypeExpand.fromJson(Map<String, dynamic> json) {
    return SeedTypeExpand(
      seedType: SeedType.fromJson(json['seedType'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seedType': seedType.toJson(),
    };
  }
}
