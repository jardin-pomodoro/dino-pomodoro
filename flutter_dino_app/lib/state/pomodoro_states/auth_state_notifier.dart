import 'package:flutter_dino_app/domain/models/user_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/user.dart';

class AuthStateNotifier extends StateNotifier<UserAuth> {
  static final _initialUser = UserAuth(
    authModel: const {},
    token: '',
    user: User(
      collectionId: '1',
      collectionName: 'Users',
      created: DateTime.now(),
      id: '123',
      username: 'Unknown',
      email: 'email@example.com',
      avatar:
          'https://cdn3.iconfinder.com/data/icons/customer-service-glyphs-vol-1/55/customer__unknown__user__client-512.png',
      balance: 0,
      updated: DateTime.now(),
    ),
  );

  AuthStateNotifier() : super(_initialUser);

  void setUser(UserAuth user) {
    state = user;
  }

  void setAvatar(String avatar) {
    state = state.copyWith(avatar: avatar);
  }

  void setUsername(String username) {
    state = state.copyWith(username: username);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void clearUser() {
    state = _initialUser;
  }
}

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, UserAuth>((ref) {
  return AuthStateNotifier();
});
