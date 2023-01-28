import 'package:flutter_dino_app/domain/models/seed_type.dart';
import 'package:flutter_dino_app/presentation/state/pomodoro_states/seed_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final seedsType = [
  SeedType(
    collectionId: '1',
    collectionName: 'Collection 1',
    id: '1',
    name: 'Saul',
    image:
    'https://pocketbase.nospy.fr/api/files/lajospkke93eknf/klfch9yk075cmpq/canvas_removebg_preview_zRg2OoMJsv.png',
    timeToGrow: 10,
    price: 100,
    reward: 10,
    leafMaxUpgrades: 3,
    trunkMaxUpgrades: 3,
    created: DateTime.now(),
    updated: DateTime.now(),
  ),
  SeedType(
    collectionId: '1',
    collectionName: 'Collection 1',
    id: '2',
    name: 'Cerisier',
    image:
    'https://pocketbase.nospy.fr/api/files/lajospkke93eknf/q93aghxz9h1pl7u/canvas3_removebg_preview_AsHORCGEJN.png',
    timeToGrow: 60,
    price: 200,
    reward: 20,
    leafMaxUpgrades: 5,
    trunkMaxUpgrades: 5,
    created: DateTime.now(),
    updated: DateTime.now(),
  ),
  SeedType(
    collectionId: '1',
    collectionName: 'Collection 1',
    id: '3',
    name: 'Peuplier',
    image:
    'https://pocketbase.nospy.fr/api/files/lajospkke93eknf/fcli3v7obfhrwbt/canvas2_removebg_preview_MJsLsimfMy.png',
    timeToGrow: 120,
    price: 500,
    reward: 50,
    leafMaxUpgrades: 0,
    trunkMaxUpgrades: 50,
    created: DateTime.now(),
    updated: DateTime.now(),
  ),
];

class SeedTypeStateNotifier extends StateNotifier<List<SeedType>> {
  SeedTypeStateNotifier() : super(seedsType);

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
