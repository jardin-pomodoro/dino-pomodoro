import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';

class AddFriend  extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) addFriend;

  const AddFriend({
    super.key,
    required this.controller,
    required this.addFriend,
  });

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "email",
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: PomodoroTheme.secondary,
                      style: BorderStyle.none,
                      width: 10.0
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: PomodoroTheme.secondary,
                      style: BorderStyle.none,
                      width: 10.0
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () => {
                    widget.controller.clear()
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: PomodoroTheme.secondary
                  ),
                )
              ),
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
                      width: 0,
                    ),
                  ),
                  color: PomodoroTheme.secondary,
                  child: const Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        'envoyer la demande',
                        style: PomodoroTheme.text,
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}