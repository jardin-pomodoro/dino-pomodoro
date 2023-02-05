import 'package:flutter_dino_app/core/success.dart';
import 'package:flutter_dino_app/domain/models/seed.dart';
import 'package:flutter_dino_app/domain/models/seed_type.dart';

import '../models/user.dart';

abstract class SeedRepository {
  Future<Success<List<Seed>>> getSeeds(String userId);

  Future<Success<Seed>> buySeed(User user, SeedType seedType);

  Future<Success<void>> saveSeed(User user, Seed seed,{int? price});

  Future<Success<void>> clear();

  Future<Success<void>> saveSeeds(List<Seed> seeds);
}
