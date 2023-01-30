import 'package:dartz/dartz.dart';

import '../../../../domain/models/seed_type.dart';
import '../../../../domain/repositories/seed_type_repository.dart';
import '../../../../domain/usecases/retrieve_seed_type_usecase.dart';

class LocalSeedTypeRepository implements SeedTypeRepository {
  @override
  Future<Either<RetrieveSeedTypeFailure, List<SeedType>>> retrieveSeedType() {
    throw UnimplementedError();
  }
}
