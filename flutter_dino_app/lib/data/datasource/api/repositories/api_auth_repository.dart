import 'dart:io';

import 'package:flutter_dino_app/core/success.dart';
import 'package:flutter_dino_app/data/datasource/api/entity/auth_entity.dart';
import 'package:flutter_dino_app/data/datasource/api/mapper/auth_mapper.dart';
import 'package:flutter_dino_app/domain/models/user_auth.dart';
import 'package:flutter_dino_app/domain/repositories/auth_repository.dart';
import 'package:pocketbase/pocketbase.dart';

import '../api_consumer.dart';

class ApiAuthRepository implements AuthRepository {
  final ApiConsumer pb;

  ApiAuthRepository(this.pb);

  @override
  Future<Success<UserAuth>> login(String email, String password) async {
    late final RecordAuth authData;
    try {
      authData = await pb.authWithPassword(email, password);
    } on ClientException {
      return Success.fromFailure(failureMessage: 'Identifiant incorrect');
    } catch (_) {
      return Success.fromFailure(failureMessage: 'Erreur réseau');
    }

    final AuthEntity authEntity = AuthEntity.fromJson(authData.toJson());

    return Success(data: AuthMapper.fromEntity(authEntity));
  }

  @override
  Future<Success<UserAuth>> retrieveUserAuth() async {
    final refreshAuth = await pb.authRefresh();
    final authEntity = AuthEntity.fromJson(refreshAuth.toJson());
    return Future.value(Success(data: AuthMapper.fromEntity(authEntity)));
  }

  @override
  Future<Success<void>> saveUserAuth(UserAuth userAuth) {
    pb.pb.authStore.save(userAuth.token, userAuth.authModel);
    return Future.value(Success(data: null));
  }

  @override
  Future<Success<void>> logout() async {
    await pb.logout();
    return Future.value(Success(data: null));
  }

  @override
  Future<Success<UserAuth>> updateUserInfo(UserAuth userAuth) async {
    final updateUser = userAuth.user.toUpdateUser();
    final record =
        await pb.updateUserInfo(userAuth.user.id, updateUser.toMap());
    final authEntity = AuthEntity.fromJson(record.toJson());
    return Future.value(Success(data: AuthMapper.fromEntity(authEntity)));
  }
}
