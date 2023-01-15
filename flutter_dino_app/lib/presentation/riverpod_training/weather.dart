import 'package:flutter/material.dart';
import 'package:flutter_dino_app/domain/models/weather.dart';
import 'package:flutter_dino_app/presentation/state/weather/Weather.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WeatherWidget extends ConsumerWidget {
  const WeatherWidget({
    Key? key,
  }) : super(key: key);

  Widget weather(
      AsyncValue<WeatherEmoji> currentWeather, BuildContext context) {
    return currentWeather.when(
      data: (weather) => Text(
        style: Theme.of(context).textTheme.headline6,
        "Current weather: $weather",
      ),
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text(error.toString()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(weatherProvider);
    return Expanded(
      child: Column(
        children: [
          Text(
            "Weather",
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 10),
          weather(currentWeather, context),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: City.values.length,
              itemBuilder: (context, index) {
                final city = City.values[index];
                final isSelected = ref.watch(currentCityProvider) == city;
                return ListTile(
                    title: Text(
                      city.toString().split('.').last,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    trailing: isSelected ? const Icon(Icons.check) : null,
                    onTap: () =>
                        ref.read(currentCityProvider.notifier).state = city);
              },
            ),
          ),
        ],
      ),
    );
  }
}
