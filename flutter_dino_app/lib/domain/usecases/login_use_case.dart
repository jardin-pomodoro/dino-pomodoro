import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';
import '../../../core/usecase.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class LoginUseCase extends UseCase<LoginResponse, LoginParam> {
  final UserRepository _repository;

  LoginUseCase(this._repository);
  @override
  Future<Either<LoginFailure, LoginResponse>> call(LoginParam params) async {
    return _repository.login(params.email, params.password);
  }
}

class LoginResponse {
  final UserTest user;
  LoginResponse(this.user);
}

class LoginFailure extends Failure {
  final String message;

  LoginFailure(this.message);
}

class LoginParam {
  final String email;
  final String password;

  LoginParam(this.email, this.password);
}
