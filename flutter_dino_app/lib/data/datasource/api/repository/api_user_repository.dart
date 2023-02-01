import 'package:dartz/dartz.dart';
import 'package:flutter_dino_app/domain/models/user.dart';
import 'package:flutter_dino_app/domain/repositories/user_repository.dart';
import 'package:flutter_dino_app/domain/usecases/login_use_case.dart';
import 'package:pocketbase/pocketbase.dart';

import '../api_consumer.dart';

class ApiUserRepository implements UserRepository {
  final ApiConsumer pb;

  ApiUserRepository(this.pb);

  @override
  Future<Either<LoginFailure, LoginResponse>> login(String email, String password) async {
    late final dynamic authData;
    try {
      authData = await pb.authWithPassword(email, password);
    } on ClientException {
        return left(LoginFailure('Identifiant incorrect'));
    } catch (_) {
      return left(LoginFailure('erreur reseau essayé avec internet'));
    }
    final User user = User(authData.model.email);
    return right(LoginResponse(user));
  }

}