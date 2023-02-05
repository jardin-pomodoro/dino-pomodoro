import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/api/api_consumer.dart';
import '../../data/datasource/api/repositories/api_user_repository.dart';
import '../../domain/services/user_service.dart';
import '../api_consumer/api_consumer.dart';

final userServiceProvider = Provider<UserService>((ref) {
  final ApiConsumer consumer = ref.read(apiProvider);
  final remoteRepository = ApiUserRepository(consumer);

  return UserService(
    remoteRepository: remoteRepository,
  );
});
