import '../../../../core/success.dart';
import '../../../../domain/models/seed_type.dart';
import '../../../../domain/repositories/seed_type_repository.dart';

class LocalSeedTypeRepository implements SeedTypeRepository {
  @override
  Future<Success<List<SeedType>>> retrieveSeedType() {
    throw UnimplementedError();
  }
}
