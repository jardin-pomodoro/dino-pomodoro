import 'package:flutter_dino_app/core/success.dart';

import '../models/user_auth.dart';

abstract class AuthRepository {
  Future<Success<UserAuth>> login(String email, String password);
}