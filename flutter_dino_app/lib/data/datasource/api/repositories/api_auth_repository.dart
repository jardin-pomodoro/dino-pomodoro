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
}
