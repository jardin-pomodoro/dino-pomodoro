import 'package:flutter_dino_app/domain/models/user_auth.dart';

import '../../core/success.dart';
import '../repositories/auth_repository.dart';

class AuthService {
  final AuthRepository _repository;

  AuthService(this._repository);

  Future<Success<UserAuth>> login(LoginParam params) async {
    return _repository.login(params.email, params.password);
  }

  Future<Success<UserAuth>> register(RegisterParam params) async {
    throw UnimplementedError();
  }
}

class LoginParam {
  final String email;
  final String password;

  LoginParam(this.email, this.password);
}

class RegisterParam {}