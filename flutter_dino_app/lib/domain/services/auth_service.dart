import 'dart:io';
import 'package:mime/mime.dart';
import '../models/user_auth.dart';

import '../../core/success.dart';
import '../repositories/auth_repository.dart';

class AuthService {
  final AuthRepository _remoteRepository;
  final AuthRepository _localRepository;

  AuthService(this._remoteRepository, this._localRepository);

  Future<Success<UserAuth>> login(LoginParam params) async {
    return _remoteRepository.login(params.email, params.password);
  }

  Future<Success<bool>> register(RegisterParam params) async {
    return _remoteRepository.register(
      params.email,
      params.password,
      params.passwordConfirm,
      params.username,
    );
  }

  Future<Success<void>> logout() async {
    await _localRepository.logout();
    await _remoteRepository.logout();
    return Success(data: null);
  }

  Future<Success<void>> userAuthSuccess(UserAuth userAuth) async {
    await _localRepository.saveUserAuth(userAuth);
    return Success(data: null);
  }

  Future<Success<UserAuth>> getUserAuth() async {
    final userAuthSuccess = await _localRepository.retrieveUserAuth();
    if (userAuthSuccess.isSuccess) {
      await _remoteRepository.saveUserAuth(userAuthSuccess.data!);
      final refreshedUserAuth = await _remoteRepository.retrieveUserAuth();
      return refreshedUserAuth;
    }

    return userAuthSuccess;
  }

  Future<Success<void>> updateUserInfo(UserAuth userAuth) async {
    final remoteResult = await _remoteRepository.updateUserInfo(userAuth);
    final localResult =
        await _localRepository.updateUserInfo(remoteResult.data!);
    if (localResult.isSuccess && remoteResult.isSuccess) {
      return Success(data: null);
    }
    return Success.fromFailure(failureMessage: "Failed to update user auth");
  }

  Future<Success<UserAuth>> updateUserAvatar(
      UserAuth userAuth, File avatar) async {
    final mimeType = lookupMimeType(avatar.path);
    if (mimeType == null || !mimeType.startsWith("image")) {
      return Success.fromFailure(failureMessage: "Invalid image type");
    }
    final updatedUserAuth =
        await _remoteRepository.updateUserAvatar(userAuth, avatar);
    if (updatedUserAuth.isSuccess) {
      await _localRepository.updateUserInfo(updatedUserAuth.data!);
    }
    return updatedUserAuth;
  }
}

class LoginParam {
  final String email;
  final String password;

  LoginParam(this.email, this.password);
}

class RegisterParam {
  final String email;
  final String password;
  final String passwordConfirm;
  final String username;

  RegisterParam(this.email, this.password, this.passwordConfirm, this.username);
}
