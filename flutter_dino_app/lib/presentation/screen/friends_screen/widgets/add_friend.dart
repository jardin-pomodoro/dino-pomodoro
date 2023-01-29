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
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () => {
                    widget.controller.clear()
                  },
                  icon: const Icon(Icons.clear),
                )
              ),
              controller: widget.controller,
              onSubmitted: widget.addFriend,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MaterialButton(
                  onPressed: () {},
                  color: PomodoroTheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('envoyer la demande'),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}