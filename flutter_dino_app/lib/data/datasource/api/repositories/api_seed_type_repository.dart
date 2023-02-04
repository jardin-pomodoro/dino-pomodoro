import '../../../../core/success.dart';
import '../../../../domain/models/seed_type.dart';
import '../../../../domain/repositories/seed_type_repository.dart';
import '../api_consumer.dart';
import '../entity/seed_type_entity.dart';
import '../mapper/seed_type_mapper.dart';


class ApiSeedTypeRepository implements SeedTypeRepository {
  final ApiConsumer apiConsumer;

  ApiSeedTypeRepository(this.apiConsumer);

  @override
  Future<Success<List<SeedType>>> retrieveSeedType() async {
    try {
      final seedTypes = await apiConsumer.fetchSeeds();
      final seeds = seedTypes
          .map((e) => SeedTypeEntity.fromJson(e.toJson()))
          .map(SeedTypeMapper.fromEntity)
          .toList();
      return Success(data: seeds);
    } catch (e) {
      return Success.fromFailure(failureMessage: e.toString());
    }
  }
}
