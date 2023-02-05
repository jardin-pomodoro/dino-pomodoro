import 'package:flutter_dino_app/core/success.dart';
import 'package:flutter_dino_app/data/datasource/api/api_consumer.dart';
import 'package:flutter_dino_app/data/datasource/api/entity/seed_entity.dart';
import 'package:flutter_dino_app/data/datasource/api/mapper/seed_mapper.dart';
import 'package:flutter_dino_app/domain/models/seed.dart';
import 'package:flutter_dino_app/domain/models/seed_type.dart';

import '../../../../domain/models/user.dart';
import '../../../../domain/repositories/seed_repository.dart';

class ApiSeedRepository implements SeedRepository {
  final ApiConsumer pb;

  ApiSeedRepository(this.pb);

  @override
  Future<Success<Seed>> buySeed(User user, SeedType seedType) async {
    final seed = CreateSeed(
      seedType: seedType.id,
      user: user.id,
      leafLevel: 0,
      trunkLevel: 0,
    );
    final record = await pb.addNewSeed(seed);
    await pb.updateUserBalance(user.id, user.balance - seedType.price);
    final seedEntity = SeedEntity.fromJson(record.toJson());
    return Success(data: SeedMapper.fromEntity(seedEntity));
  }

  @override
  Future<Success<Seed>> clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }

  @override
  Future<Success<List<Seed>>> getSeeds(String userId) {
    // TODO: implement getSeeds
    throw UnimplementedError();
  }

  @override
  Future<Success<void>> saveSeed(User user, Seed seed) {
    // TODO: implement saveSeed
    throw UnimplementedError();
  }

  @override
  Future<Success<void>> saveSeeds(List<Seed> seeds) {
    // TODO: implement saveSeeds
    throw UnimplementedError();
  }
}
