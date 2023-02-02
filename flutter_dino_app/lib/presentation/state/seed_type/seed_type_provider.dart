import '../../../data/datasource/api/repository/api_seed_type_repository.dart';
import '../../../data/datasource/local/repositories/local_seed_type_repository.dart';
import '../../../domain/usecases/retrieve_seed_type_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/datasource/api/api_consumer.dart';
import '../../../domain/models/seed_type.dart';
import '../api_consumer/api_consumer.dart';

final fetchSeedTypesProvider = FutureProvider<List<SeedType>>((ref) async {
  final ApiConsumer consumer = ref.read(apiProvider);
  final retrieveSeedTypeUseCase = RetrieveSeedTypeUseCase(
    localRepository: LocalSeedTypeRepository(),
    remoteRepository: ApiSeedTypeRepository(consumer),
  );
  return retrieveSeedTypeUseCase();
});
