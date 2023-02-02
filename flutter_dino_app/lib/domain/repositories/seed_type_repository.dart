import 'package:dartz/dartz.dart';
import '../usecases/retrieve_seed_type_usecase.dart';

import '../models/seed_type.dart';

abstract class SeedTypeRepository {
  Future<Either<RetrieveSeedTypeFailure, List<SeedType>>> retrieveSeedType();
}
