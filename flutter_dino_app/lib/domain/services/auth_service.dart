import 'package:flutter_dino_app/domain/models/user_auth.dart';

import '../../core/success.dart';
import '../repositories/auth_repository.dart';

class AuthService {
  final AuthRepository _remoteRepository;
  final AuthRepository _localRepository;

  AuthService(this._remoteRepository, this._localRepository);

  Future<Success<UserAuth>> login(LoginParam params) async {
    return _remoteRepository.login(params.email, params.password);
  }

  Future<Success<UserAuth>> register(RegisterParam params) async {
    throw UnimplementedError();
  }

  Future<Success<UserAuth>> logout() async {
    throw UnimplementedError();
  }

  Future<Success<void>> userAuthSuccess(UserAuth userAuth) async {
    await _localRepository.saveUserAuth(userAuth);
    return Success(data: null);
  }

  Future<Success<UserAuth>> getUserAuth() async {
    return await _localRepository.retrieveUserAuth();
  }
}

class LoginParam {
  final String email;
  final String password;

  LoginParam(this.email, this.password);
}

class RegisterParam {}
