import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/growing_screen/growing_screen_widget.dart';
import 'package:flutter_dino_app/presentation/widgets/navigation_drawer.dart';

class PomodoroScreenWidget extends StatelessWidget {
  const PomodoroScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Garden Pomodoro'),
      ),
      drawer: const NavigationDrawerWidget(),
      body: const Center(child: GrowingScreenWidget()),
    );
  }
}
