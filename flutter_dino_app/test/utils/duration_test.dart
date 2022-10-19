import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dino_app/utils/duration.dart';

void main() {
  test('Duration should be 25 minutes', () {
    const twentyFiveMinutes = Duration(minutes: 25);
    expect(twentyFiveMinutes.inSecondsWithMinutes(), "25:00");
  });
  test('Duration should be 1 hours and 25 minutes', () {
    const oneHourAndTwentyFiveMinutes = Duration(hours: 1, minutes: 25);
    expect(oneHourAndTwentyFiveMinutes.inSecondsWithMinutes(), "1:25:00");
  });
  test('test with only seconds', () {
    const twentyFiveSeconds = Duration(seconds: 25);
    expect(twentyFiveSeconds.inSecondsWithMinutes(), "00:25");
  });
  test('test hours and switch', () {
    Duration duration = const Duration(hours: 1);
    expect(duration.inSecondsWithMinutes(), "1:00:00");
    duration = duration - const Duration(seconds: 1);
    expect(duration.inSecondsWithMinutes(), "59:59");
  });
}
