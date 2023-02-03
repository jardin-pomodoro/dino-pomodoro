import 'package:dartz/dartz.dart';
import 'package:flutter_dino_app/core/success.dart';
import '../models/tree.dart';

abstract class RemyTreeRepository {
  Future<Success<List<Tree>>> retrieveRemyTreeRepository();
}

class RetrieveRemyTreeRepositoryFailure {}