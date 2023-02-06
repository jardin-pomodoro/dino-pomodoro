import 'package:flutter_dino_app/domain/repositories/growing_repository.dart';

import '../../core/network.dart';
import '../../core/success.dart';
import '../models/growing.dart';
import '../models/seed.dart';

class GrowService {
  final GrowingRepository _repository;

  GrowService(this._repository);

  Future<Success<List<Growing>>> retrieveGrowing(String userId) async {
    if (await NetworkChecker.hasConnection()) {
      return await _repository.retrieveGrowing(userId);
    }
    return Success.fromFailure(failureMessage: 'No internet connection');
  }

  Future<Success<Growing>> addNewGrowing(String userId, Seed seed) async {
    if (await NetworkChecker.hasConnection()) {
      return await _repository.addNewGrowing(userId, seed);
    }
    return Success.fromFailure(failureMessage: 'No internet connection');
  }

  Future<Success<void>> clearGrowing(String userId) async {
    if (await NetworkChecker.hasConnection()) {
      return await _repository.clearGrowing(userId);
    }
    return Success.fromFailure(failureMessage: 'No internet connection');
  }
}
