import 'dart:io';

import '../../core/success.dart';

import '../models/user_auth.dart';

abstract class AuthRepository {
  Future<Success<UserAuth>> login(String email, String password);

  Future<Success<bool>> register(
    String email,
    String password,
    String passwordConfirm,
    String username,
  );

  Future<Success<UserAuth>> retrieveUserAuth();

  Future<Success<void>> saveUserAuth(UserAuth userAuth);

  Future<Success<void>> logout();

  Future<Success<UserAuth>> updateUserInfo(UserAuth userAuth);

  Future<Success<UserAuth>> updateUserAvatar(UserAuth userAuth, File avatar);
}
