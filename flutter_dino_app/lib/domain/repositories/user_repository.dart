import '../../core/success.dart';
import '../models/user.dart';

abstract class UserRepository {
  Future<Success<User>> retrieveUserByEmail(String email);

  Future<Success<User>> retrieveUserById(String userId);
}
