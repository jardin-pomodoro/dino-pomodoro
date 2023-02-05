import 'package:flutter_dino_app/domain/repositories/seed_repository.dart';

import '../../core/network.dart';
import '../../core/success.dart';
import '../models/seed.dart';
import '../models/seed_type.dart';
import '../models/user.dart';

class SeedService {
  final SeedRepository _remoteRepository;
  final SeedRepository _localRepository;

  SeedService(this._remoteRepository, this._localRepository);

  Future<Success<List<Seed>>> getSeeds(String userId) async {
    if (await NetworkChecker.hasConnection()) {
      final seeds = await _remoteRepository.getSeeds(userId);
      if (seeds.isSuccess) {
        await _localRepository.saveSeeds(seeds.data!);
        return seeds;
      }
    }
    return await _localRepository.getSeeds(userId);
  }

  Future<Success<Seed>> buySeed(User user, SeedType seedType) async {
    if (!(await NetworkChecker.hasConnection())) {
      return Success.fromFailure(failureMessage: 'No internet connection');
    }
    final seed = await _remoteRepository.buySeed(user, seedType);
    if (seed.isSuccess) {
      await _localRepository.saveSeed(user, seed.data!);
    }
    return seed;
  }

  Future<Success<void>> saveSeed(User user, Seed seed, {int? price}) async {
    if (!(await NetworkChecker.hasConnection())) {
      return Success.fromFailure(failureMessage: 'No internet connection');
    }
    final result = await _remoteRepository.saveSeed(user, seed, price: price);
    if (result.isSuccess) {
      await _localRepository.saveSeed(user, seed);
    }
    return result;
  }
}
