import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/seed.dart';

class SeedSelectorStateNotifier extends StateNotifier<Seed?> {
  SeedSelectorStateNotifier() : super(null);

  void selectSeed(Seed seed) {
    state = seed;
  }
}

final seedSelectorStateNotifierProvider =
    StateNotifierProvider<SeedSelectorStateNotifier, Seed?>((ref) {
  return SeedSelectorStateNotifier();
});
