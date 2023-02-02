import 'package:flutter_dino_app/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_dino_app/core/usecase.dart';
import 'package:flutter_dino_app/domain/repositories/user_repository.dart';

class RegisterUseCase extends UseCase<RegisterResponse, RegisterParam> {
  final UserRepository _userRepository;

  RegisterUseCase(this._userRepository);

  @override
  Future<Either<RegisterFailure, RegisterResponse>> call(RegisterParam params) {
    throw UnimplementedError();
  }
}

class RegisterFailure implements Failure {
  final String message;

  RegisterFailure(this.message);

}
class RegisterParam {}
class RegisterResponse {}