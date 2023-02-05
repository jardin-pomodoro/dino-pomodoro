import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class AddFriendForm extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) addFriend;

  const AddFriendForm({
    super.key,
    required this.controller,
    required this.addFriend,
  });

  @override
  State<AddFriendForm> createState() => _AddFriendFormState();
}

class _AddFriendFormState extends State<AddFriendForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "username",
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: PomodoroTheme.secondary, width: 2),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: PomodoroTheme.secondary, width: 2),
            ),
            prefixIcon: const Icon(Icons.email),
            prefixIconColor: PomodoroTheme.secondary,
            suffixIcon: IconButton(
              onPressed: () => {widget.controller.clear()},
              icon: const Icon(Icons.clear, color: PomodoroTheme.secondary),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          controller: widget.controller,
          onSubmitted: widget.addFriend,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: MaterialButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(
                color: PomodoroTheme.secondary,
                width: 2,
              ),
            ),
            color: PomodoroTheme.secondary,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Envoyer la demande',
                style: PomodoroTheme.textWhite,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
