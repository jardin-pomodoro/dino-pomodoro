import 'package:flutter_dino_app/data/datasource/local/repositories/local_weather_repository.dart';
import 'package:flutter_dino_app/domain/models/weather.dart';
import 'package:flutter_dino_app/domain/repositories/weather_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>(
  (ref) => LocalWeatherRepository(),
);

final currentCityProvider = StateProvider<City?>(
  (ref) => null,
);

final weatherProvider = FutureProvider<WeatherEmoji>((ref) {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  final city = ref.watch(currentCityProvider);
  if (city != null) {
    return weatherRepository.getWeather(city);
  }
  return WeatherEmojiString.unknown;
});
