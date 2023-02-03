import 'package:flutter_dino_app/data/datasource/api/repositories/api_auth_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/datasource/api/api_consumer.dart';
import '../../domain/services/auth_service.dart';
import '../api_consumer/api_consumer.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  final ApiConsumer consumer = ref.read(apiProvider);

  final authRepository = ApiAuthRepository(consumer);

  return AuthService(authRepository);
});
