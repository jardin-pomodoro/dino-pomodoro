import 'package:flutter_dino_app/domain/models/weather.dart';

abstract class WeatherRepository {
  Future<WeatherEmoji> getWeather(City city);
}
