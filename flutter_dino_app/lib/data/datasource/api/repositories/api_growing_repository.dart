
import 'package:flutter_dino_app/core/success.dart';
import 'package:flutter_dino_app/data/datasource/api/mapper/growing_mapper.dart';

import 'package:flutter_dino_app/domain/models/growing.dart';

import '../../../../domain/models/seed.dart';
import '../../../../domain/repositories/growing_repository.dart';
import '../../../../utils/upgrade_functions.dart';
import '../api_consumer.dart';
import '../entity/growing_entity.dart';

class ApiGrowingRepository implements GrowingRepository {
  final ApiConsumer apiConsumer;

  ApiGrowingRepository(this.apiConsumer);

  @override
  Future<Success<Growing>> addNewGrowing(String userId, Seed seed) async {
    final createGrowing = CreateGrow(
      seedType: seed.seedType,
      user: userId,
      timeToGrow: getGrowTime(seed.seedTypeExpand.timeToGrow, seed.trunkLevel),
      reward: getIncome(seed.seedTypeExpand.reward, seed.leafLevel),
    );
    final record = await apiConsumer.addGrowing(createGrowing);
    final growingEntity = GrowingEntity.fromJson(record.toJson());
    return Success(data: GrowingMapper.fromEntity(growingEntity));
  }

  @override
  Future<Success<void>> clearGrowing(String userId) async {
    final growings = await retrieveGrowing(userId);
    if (!growings.isSuccess) {
      return Success.fromFailure(failureMessage: growings.failureMessage);
    }
    for (var growing in growings.data!) {
      await apiConsumer.deleteGrowing(growing.id);
    }
    return Success(data: null);
  }

  @override
  Future<Success<List<Growing>>> retrieveGrowing(String userId) async {
    final records = await apiConsumer.fetchGrowing(userId);
    final growings = records
        .map((e) => GrowingEntity.fromJson(e.toJson()))
        .map(GrowingMapper.fromEntity)
        .toList();
    return Success(data: growings);
  }

}