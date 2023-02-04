import 'package:flutter_dino_app/core/success.dart';
import 'package:flutter_dino_app/data/datasource/api/entity/auth_entity.dart';
import 'package:flutter_dino_app/data/datasource/api/mapper/auth_mapper.dart';
import 'package:flutter_dino_app/domain/models/user_auth.dart';
import 'package:flutter_dino_app/domain/repositories/auth_repository.dart';
import 'package:pocketbase/pocketbase.dart';

import '../api_consumer.dart';

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
  Future<Success<bool>> register(
    String email,
    String password,
    String username,
  ) async {
    try {
      final user = {
        'email': email,
        'password': password,
        'username': username,
      };
      final create =
          await client.pb.collection(Collection.users.name).create(body: user);
      return Future.value(Success(data: true));
    } catch (_) {
      return Future.value(
        Success.fromFailure(failureMessage: "erreur d'enregistrement"),
      );
    }
  }
}
