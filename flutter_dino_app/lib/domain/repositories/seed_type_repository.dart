import 'package:dartz/dartz.dart';

import '../models/seed_type.dart';
import '../usecases/retrieve_seed_type_usecase.dart';

abstract class SeedTypeRepository {
  Future<Either<RetrieveSeedTypeFailure, List<SeedType>>> retrieveSeedType();
}
