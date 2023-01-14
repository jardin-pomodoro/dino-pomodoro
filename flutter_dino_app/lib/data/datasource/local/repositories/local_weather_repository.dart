import 'package:flutter_dino_app/domain/models/weather.dart';
import 'package:flutter_dino_app/domain/repositories/weather_repository.dart';

class LocalWeatherRepository implements WeatherRepository {
  @override
  Future<WeatherEmoji> getWeather(City city) {
    // Switch case to get the weather emoji
    return Future.delayed(
      const Duration(seconds: 1),
      () =>
          {
            City.london: WeatherEmojiString.cloudy,
            City.paris: WeatherEmojiString.sunny,
            City.newYork: WeatherEmojiString.rainy,
            City.tokyo: WeatherEmojiString.snowy,
          }[city] ??
          "?",
    );
  }
}
