import 'package:flutter_dino_app/domain/models/seed_type.dart';
import 'package:flutter_dino_app/presentation/state/pomodoro_states/seed_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SeedTypeStateNotifier extends StateNotifier<List<SeedType>> {
  SeedTypeStateNotifier() : super([]);

  void addSeedType(SeedType seedType) {
    state = [...state, seedType];
  }

  void removeSeedType(SeedType seedType) {
    state = state.where((element) => element != seedType).toList();
  }

  void clearSeedTypes() {
    state = [];
  }

  void addSeedTypes(List<SeedType> seedTypes) {
    state = [...state, ...seedTypes];
  }
}

final seedTypeStateNotifierProvider =
    StateNotifierProvider<SeedTypeStateNotifier, List<SeedType>>((ref) {
  return SeedTypeStateNotifier();
});

final notBoughtSeedTypeStateNotifierProvider = Provider<List<SeedType>>((ref) {
  final possessedSeeds = ref.watch(seedStateNotifierProvider);
  final seedTypes = ref.watch(seedTypeStateNotifierProvider);

  return seedTypes.where((seedType) {
    return !possessedSeeds.any(
      (seed) => seed.seedTypeExpand.id == seedType.id,
    );
  }).toList();
});

final boughtSeedTypeStateNotifierProvider = Provider<List<SeedType>>((ref) {
  final possessedSeeds = ref.watch(seedStateNotifierProvider);
  final seedTypes = ref.watch(seedTypeStateNotifierProvider);

  return seedTypes.where((seedType) {
    return possessedSeeds.any(
      (seed) => seed.seedTypeExpand.id == seedType.id,
    );
  }).toList();
});
