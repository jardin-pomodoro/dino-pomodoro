import '../../core/success.dart';

import '../../core/network.dart';
import '../models/seed_type.dart';
import '../repositories/seed_type_repository.dart';

class SeedTypeService {
  SeedTypeService({
    required this.localRepository,
    required this.remoteRepository,
  });

  final SeedTypeRepository localRepository;
  final SeedTypeRepository remoteRepository;

  Future<Success<List<SeedType>>> retrieveSeedTypes() async {
    if (await NetworkChecker.hasConnection()) {
      final seeds = await remoteRepository.retrieveSeedType();
      if (seeds.isSuccess) {
        return seeds;
      }
    }
    return await localRepository.retrieveSeedType();
  }
}
