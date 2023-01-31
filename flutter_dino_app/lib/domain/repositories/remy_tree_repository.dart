import 'package:dartz/dartz.dart';
import 'package:flutter_dino_app/domain/models/tree.dart';

abstract class RemyTreeRepository {
  Future<Either<RetrieveRemyTreeRepositoryFailure, List<Tree>>> retrieveRemyTreeRepository();
}

class RetrieveRemyTreeRepositoryFailure {}