import '../../core/either.dart';
import '../../core/network.dart';
import '../../core/usecase.dart';
import '../models/seed_type.dart';

import '../repositories/seed_type_repository.dart';

class RetrieveSeedTypeUseCase extends NoParamsUseCase<List<SeedType>> {
  RetrieveSeedTypeUseCase({
    required this.localRepository,
    required this.remoteRepository,
  });

  final SeedTypeRepository localRepository;
  final SeedTypeRepository remoteRepository;

  @override
  Future<List<SeedType>> call() async {
    if (await NetworkChecker.hasConnection()) {
      final seeds = await remoteRepository.retrieveSeedType();
      if (seeds.isRight()) {
        return seeds.asRight();
      }
    }
    return takeLocal();
  }

  Future<List<SeedType>> takeLocal() async {
    final seeds = await localRepository.retrieveSeedType();
    return seeds.asRight();
  }
}

class RetrieveSeedTypeFailure {}
