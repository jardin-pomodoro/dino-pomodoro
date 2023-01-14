enum City {
  london,
  newYork,
  tokyo,
  paris,
}

abstract class WeatherEmojiString {
  static const sunny = "☀";
  static const cloudy = "☁";
  static const rainy = "⛈";
  static const snowy = "❄";
  static const unknown = "🤷‍";
}

typedef WeatherEmoji = String;
