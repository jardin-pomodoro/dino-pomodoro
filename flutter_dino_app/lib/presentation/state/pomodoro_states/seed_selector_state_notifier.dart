import 'package:flutter_dino_app/domain/models/seed.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
