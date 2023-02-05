import 'package:flutter_dino_app/core/success.dart';
import 'package:flutter_dino_app/data/datasource/api/repositories/api_friendship_repository.dart';
import 'package:flutter_dino_app/data/datasource/local/repositories/local_friendship_repository.dart';
import 'package:flutter_dino_app/domain/models/friendship.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/datasource/api/api_consumer.dart';
import '../../data/datasource/api/repositories/api_user_repository.dart';
import '../../domain/models/user.dart';
import '../../domain/services/friendship_service.dart';
import '../../domain/services/user_service.dart';
import '../api_consumer/api_consumer.dart';
import '../pomodoro_states/auth_state_notifier.dart';

final userServiceProvider = Provider<UserService>((ref) {
  final ApiConsumer consumer = ref.read(apiProvider);
  final remoteRepository = ApiUserRepository(consumer);

  return UserService(
      remoteRepository: remoteRepository);
});
