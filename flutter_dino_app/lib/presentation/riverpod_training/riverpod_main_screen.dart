import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/riverpod_training/example_4.dart';

class RiverPodMainScreen extends StatelessWidget {
  const RiverPodMainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              // DateWidget(),
              // SizedBox(height: 20),
              // CounterWidget(),
              // SizedBox(height: 20),
              // WeatherWidget(),
              // SizedBox(height: 20),
              Example4()
            ],
          ),
        ),
      ),
    );
  }
}
