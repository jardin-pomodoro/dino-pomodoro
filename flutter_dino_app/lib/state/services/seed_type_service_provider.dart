import '../../core/success.dart';
import '../../domain/services/seed_type_service.dart';

import '../../../data/datasource/api/repositories/api_seed_type_repository.dart';
import '../../../data/datasource/local/repositories/local_seed_type_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/datasource/api/api_consumer.dart';
import '../../../domain/models/seed_type.dart';
import '../api_consumer/api_consumer.dart';

final seedTypeServiceProvider = Provider<SeedTypeService>((ref) {
  final ApiConsumer consumer = ref.read(apiProvider);
  final localRepository = LocalSeedTypeRepository();
  final remoteRepository = ApiSeedTypeRepository(consumer);

  return SeedTypeService(
      localRepository: localRepository, remoteRepository: remoteRepository);
});

final fetchSeedTypesProvider =
    FutureProvider<Success<List<SeedType>>>((ref) async {
  final seedTypeService = ref.watch(seedTypeServiceProvider);

  return seedTypeService.retrieveSeedTypes();
});
