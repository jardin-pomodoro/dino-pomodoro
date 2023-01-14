import 'package:flutter/material.dart';

class RiverPodMainScreen extends StatelessWidget {
  const RiverPodMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod'),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
