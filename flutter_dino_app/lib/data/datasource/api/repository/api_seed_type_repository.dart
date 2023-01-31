import 'package:dartz/dartz.dart';
import 'package:flutter_dino_app/data/datasource/api/api_consumer.dart';
import 'package:flutter_dino_app/data/datasource/api/entity/seed_type_entity.dart';
import 'package:flutter_dino_app/data/datasource/api/mapper/seed_type_mapper.dart';

import '../../../../domain/models/seed_type.dart';
import '../../../../domain/repositories/seed_type_repository.dart';
import '../../../../domain/usecases/retrieve_seed_type_usecase.dart';

class ApiSeedTypeRepository implements SeedTypeRepository {
  final ApiConsumer apiConsumer;

  ApiSeedTypeRepository(this.apiConsumer);

  @override
  Future<Either<RetrieveSeedTypeFailure, List<SeedType>>>
      retrieveSeedType() async {
    try {
      final seedTypes = await apiConsumer.fetchSeeds();
      final seeds = seedTypes
          .map((e) => SeedTypeEntity.fromJson(e.toJson()))
          .map(SeedTypeMapper.fromEntity)
          .toList();
      return right(seeds);
    } catch (e) {
      return left(RetrieveSeedTypeFailure());
    }
  }
}
