import '../../domain/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserStateNotifier extends StateNotifier<List<User>> {
  UserStateNotifier() : super([]);

  void addUser(User user) {
    state = [...state, user];
  }

  void removeUser(User user) {
    state = state.where((element) => element != user).toList();
  }

  void clearUsers() {
    state = [];
  }

  void addUsers(List<User> users) {
    state = [...state, ...users];
  }
}

final userStateNotifierProvider =
    StateNotifierProvider<UserStateNotifier, List<User>>((ref) {
  return UserStateNotifier();
});

final getUserByIdStateNotifierProvider =
    Provider.family<User, String>((ref, userId) {
  final users = ref.watch(userStateNotifierProvider);

  return users.where((user) => user.id == userId).single;
});
