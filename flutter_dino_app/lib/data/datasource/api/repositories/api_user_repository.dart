import 'package:flutter_dino_app/core/success.dart';
import 'package:flutter_dino_app/data/datasource/api/mapper/user_mapper.dart';
import 'package:flutter_dino_app/domain/models/user.dart';

import '../../../../domain/repositories/user_repository.dart';
import '../api_consumer.dart';
import '../entity/user_entity.dart';

class ApiUserRepository implements UserRepository {
  final ApiConsumer apiConsumer;

  ApiUserRepository(this.apiConsumer);

  @override
  Future<Success<User>> retrieveUserByEmail(String email) async {
    try {
      final user = await apiConsumer.fetchUserByEmail(email);
      return Success(
          data: UserMapper.fromEntity(UserEntity.fromJson(user.toJson())));
    } catch (e) {
      return Success.fromFailure(failureMessage: e.toString());
    }
  }

  @override
  Future<Success<User>> retrieveUserById(String userId) async {
    try {
      final user = await apiConsumer.fetchUser(userId);
      return Success(
          data: UserMapper.fromEntity(UserEntity.fromJson(user.toJson())));
    } catch (e) {
      return Success.fromFailure(failureMessage: e.toString());
    }
  }
}
