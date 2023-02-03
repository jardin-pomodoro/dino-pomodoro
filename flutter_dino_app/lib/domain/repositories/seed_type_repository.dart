import '../../core/success.dart';

import '../models/seed_type.dart';

abstract class SeedTypeRepository {
  Future<Success<List<SeedType>>> retrieveSeedType();
}
