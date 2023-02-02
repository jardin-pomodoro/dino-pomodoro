import 'package:dartz/dartz.dart';
import '../models/tree.dart';

abstract class RemyTreeRepository {
  Future<Either<RetrieveRemyTreeRepositoryFailure, List<Tree>>> retrieveRemyTreeRepository();
}

class RetrieveRemyTreeRepositoryFailure {}