import '../../core/network.dart';
import '../../core/success.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class UserService {
  UserService({
    required this.remoteRepository,
  });

  final UserRepository remoteRepository;

  Future<Success<User>> fetchUserById(String userId) async {
    if (await NetworkChecker.hasConnection()) {
      final user = await remoteRepository.retrieveUserById(userId);
      if (user.isSuccess) {
        return user;
      }
    }
    return Success.fromFailure(failureMessage: "Network connectivity required");
  }

  Future<Success<User>> fetchUserByEmail(String email) async {
    if (await NetworkChecker.hasConnection()) {
      final user = await remoteRepository.retrieveUserByEmail(email);
      if (user.isSuccess) {
        return user;
      }
    }
    return Success.fromFailure(failureMessage: "Network connectivity required");
  }
}
