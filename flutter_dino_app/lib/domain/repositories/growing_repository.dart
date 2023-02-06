import 'package:flutter_dino_app/domain/models/seed.dart';

import '../../core/success.dart';
import '../models/growing.dart';

abstract class GrowingRepository {
  Future<Success<List<Growing>>> retrieveGrowing(String userId);

  Future<Success<Growing>> addNewGrowing(String userId, Seed seed);

  Future<Success<void>> clearGrowing(String userId);
}
