import '../../core/success.dart';

import '../../core/network.dart';
import '../../presentation/screen/forest_screen/forest_screen_widget.dart';
import '../models/tree.dart';
import '../repositories/tree_repository.dart';

class Range {
  Range(this.startDate, this.endDate);
  final DateTime startDate;
  final DateTime endDate;
}

class TreeService {
  TreeService({
    required this.remoteRepository,
    required this.localRepository,
  });

  final TreeRepository remoteRepository;
  final TreeRepository localRepository;

  Future<Success<List<Tree>>> retrieveTree(
      String userId, DateTime date, CalendarGranularity granularity) async {
    final range = _getRangeFromGranularity(date, granularity);

    if (await NetworkChecker.hasConnection()) {
      print('rangeDate: ${range.startDate} ${range.endDate}');
      final tree = await remoteRepository.retrieveTreeRepository(
          userId, range.startDate, range.endDate);
      if (tree.isSuccess) {
        return tree;
      }
    }
    return await localRepository.retrieveTreeRepository(
        userId, range.startDate, range.endDate);
  }

  Range _getRangeFromGranularity(
      DateTime date, CalendarGranularity granularity) {
    switch (granularity) {
      case CalendarGranularity.day:
        return Range(date, _getLastMinuteOfDay(date));
      case CalendarGranularity.week:
        return Range(date.subtract(Duration(days: date.weekday - 1)),
            _getLastMinuteOfDay(date.add(Duration(days: 7 - date.weekday))));
      case CalendarGranularity.month:
        return Range(DateTime(date.year, date.month, 1),
            _getLastMinuteOfDay(DateTime(date.year, date.month + 1, 0)));
      case CalendarGranularity.year:
        return Range(DateTime(date.year, 1, 1),
            _getLastMinuteOfDay(DateTime(date.year, 12, 31)));
    }
  }

  DateTime _getLastMinuteOfDay(DateTime date) {
    var lastSecond = date.add(Duration(days: 1)).subtract(Duration(seconds: 1));

    return new DateTime(lastSecond.year, lastSecond.month, lastSecond.day,
        lastSecond.hour, lastSecond.minute);
  }
}
