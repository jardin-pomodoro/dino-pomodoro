import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/success.dart';
import '../../data/datasource/api/repositories/api_seed_repository.dart';
import '../../data/datasource/local/database/database_source.dart';
import '../../data/datasource/local/repositories/local_seed_repository.dart';
import '../../domain/models/seed.dart';
import '../../domain/services/seed_service.dart';
import '../api_consumer/api_consumer.dart';
import '../db/local_db_provider.dart';
import '../pomodoro_states/auth_state_notifier.dart';

final seedServiceProvider = Provider<SeedService>((ref) {
  final consumer = ref.read(apiProvider);
  final DatabaseSource db = ref.read(localDbProvider);
  final seedRepository = ApiSeedRepository(consumer);
  final localSeedRepository = LocalSeedRepository(db);

  return SeedService(seedRepository, localSeedRepository);
});

final fetchSeedsProvider = FutureProvider<Success<List<Seed>>>((ref) async {
  final userAuth = ref.watch(authStateNotifierProvider);
  final seedService = ref.read(seedServiceProvider);
  return await seedService.getSeeds(userAuth.user.id);
});
