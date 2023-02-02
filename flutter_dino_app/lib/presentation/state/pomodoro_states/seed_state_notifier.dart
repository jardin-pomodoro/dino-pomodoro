import '../../../domain/models/seed.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SeedStateNotifier extends StateNotifier<List<Seed>> {
  SeedStateNotifier() : super([]);

  Seed? selectedSeed;

  void addSeed(Seed seed) {
    state = [...state, seed];
  }

  void removeSeed(Seed seed) {
    state = state.where((element) => element != seed).toList();
  }

  void clearSeeds() {
    state = [];
  }

  void addSeeds(List<Seed> seeds) {
    state = [...state, ...seeds];
  }

  updateSeed(Seed seed) {
    state = state.map((element) {
      if (element.id == seed.id) {
        return seed;
      }
      return element;
    }).toList();
  }
}

class SelectedSeedStateNotifier extends StateNotifier<Seed?> {
  SelectedSeedStateNotifier() : super(null);

  void selectSeed(Seed seed) {
    state = seed;
  }
}

final seedStateNotifierProvider =
    StateNotifierProvider<SeedStateNotifier, List<Seed>>((ref) {
  return SeedStateNotifier();
});

final selectedSeedStateNotifierProvider =
    StateNotifierProvider<SelectedSeedStateNotifier, Seed?>((ref) {
  return SelectedSeedStateNotifier();
});
