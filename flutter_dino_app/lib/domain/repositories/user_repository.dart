import 'package:dartz/dartz.dart';

import '../usecases/login_use_case.dart';

abstract class UserRepository {
  Future<Either<LoginFailure, LoginResponse>> login(String email, String password);
}