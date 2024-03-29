import 'dart:io';

import 'package:pocketbase/pocketbase.dart';

import '../../../../core/success.dart';
import '../../../../domain/models/user_auth.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../api_consumer.dart';
import '../entity/auth_entity.dart';
import '../mapper/auth_mapper.dart';

class ApiAuthRepository implements AuthRepository {
  final ApiConsumer client;

  ApiAuthRepository(this.client);

  @override
  Future<Success<UserAuth>> login(String email, String password) async {
    late final RecordAuth authData;
    try {
      authData = await client.authWithPassword(email, password);
    } on ClientException {
      return Success.fromFailure(failureMessage: 'Identifiant incorrect');
    } catch (_) {
      return Success.fromFailure(failureMessage: 'Erreur réseau');
    }

    final AuthEntity authEntity = AuthEntity.fromJson(authData.toJson());

    return Success(data: AuthMapper.fromEntity(authEntity));
  }

  @override
  Future<Success<UserAuth>> loginWithOAuth2(
      String provider, String code, String codeVerifier) async {
    late final RecordAuth authData;
    try {
      authData = await client.authWithOAuth2(provider, code, codeVerifier);
    } on ClientException {
      return Success.fromFailure(failureMessage: 'Erreur inconnu');
    } catch (_) {
      return Success.fromFailure(failureMessage: 'Erreur réseau');
    }

    final AuthEntity authEntity = AuthEntity.fromJson(authData.toJson());

    return Success(data: AuthMapper.fromEntity(authEntity));
  }

  @override
  Future<Success<UserAuth>> retrieveUserAuth() async {
    final refreshAuth = await client.authRefresh();
    final authEntity = AuthEntity.fromJson(refreshAuth.toJson());
    return Future.value(Success(data: AuthMapper.fromEntity(authEntity)));
  }

  @override
  Future<Success<void>> saveUserAuth(UserAuth userAuth) {
    client.pb.authStore.save(userAuth.token, userAuth.authModel);
    return Future.value(Success(data: null));
  }

  @override
  Future<Success<void>> logout() async {
    await client.logout();
    return Future.value(Success(data: null));
  }

  @override
  Future<Success<UserAuth>> updateUserInfo(UserAuth userAuth) async {
    final updateUser = userAuth.user.toUpdateUser();
    final record =
        await client.updateUserInfo(userAuth.user.id, updateUser.toMap());
    final authEntity = AuthEntity.fromJson(record.toJson());
    return Future.value(Success(data: AuthMapper.fromEntity(authEntity)));
  }

  @override
  Future<Success<UserAuth>> updateUserAvatar(
      UserAuth userAuth, File avatar) async {
    final record = await client.updateUserAvatar(userAuth.user.id, avatar);
    final authEntity = AuthEntity.fromJson(record.toJson());
    return Future.value(Success(data: AuthMapper.fromEntity(authEntity)));
  }

  @override
  Future<Success<bool>> register(
    String email,
    String password,
    String passwordConfirm,
    String username,
  ) async {
    try {
      final user = {
        'email': email,
        'password': password,
        'passwordConfirm': passwordConfirm,
        'username': username,
      };
      await client.pb.collection(Collection.users.name).create(body: user);
      return Future.value(Success(data: true));
    } catch (_) {
      return Future.value(
        Success.fromFailure(failureMessage: "erreur d'enregistrement"),
      );
    }
  }
}
