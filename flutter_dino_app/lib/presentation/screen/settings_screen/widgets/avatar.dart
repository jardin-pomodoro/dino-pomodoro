import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../domain/models/user_auth.dart';
import '../../../../domain/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../domain/models/user.dart';
import '../../../../state/services/auth_service_provider.dart';
import '../../../../state/pomodoro_states/auth_state_notifier.dart';
import '../../../theme/theme.dart';

class Avatar extends ConsumerWidget {
  const Avatar({Key? key, required this.connectedUser}) : super(key: key);

  final User connectedUser;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.read(authServiceProvider);
    final userAuth = ref.watch(authStateNotifierProvider);
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 155,
            backgroundColor: PomodoroTheme.white,
            child: CircleAvatar(
              radius: 150,
              backgroundColor: PomodoroTheme.primary,
              backgroundImage: NetworkImage(connectedUser.avatar),
            ),
          ),
        ),
        Container(
          height: 300,
          width: 320,
          alignment: Alignment.bottomRight,
          child: CircleAvatar(
            radius: 23,
            backgroundColor: PomodoroTheme.white,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: PomodoroTheme.primary,
              child: IconButton(
                icon: const Icon(
                  size: 25,
                  Icons.edit,
                  color: PomodoroTheme.white,
                ),
                onPressed: () {
                  _updateAvatar(authService, userAuth, ref);
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  void _updateAvatar(
      AuthService authService, UserAuth userAuth, WidgetRef ref) {
    _pickImage().then((value) {
      if (value != null) {
        authService.updateUserAvatar(userAuth, value).then((value) {
          if (value.isSuccess) {
            ref.read(authStateNotifierProvider.notifier).setUser(value.data!);
          }
        });
      }
    });
  }

  Future<File?> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }
}
