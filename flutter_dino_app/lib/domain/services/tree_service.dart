import '../../core/network.dart';
import '../../core/success.dart';
import '../../data/datasource/api/entity/tree_entity.dart';
import '../../presentation/screen/forest_screen/widget/canular_granularity.dart';
import '../models/growing.dart';
import '../models/tree.dart';
import '../models/user.dart';
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
        return Range(_getFirstMinuteOfDay(date), _getLastMinuteOfDay(date));
      case CalendarGranularity.week:
        return Range(
            _getFirstMinuteOfDay(
                date.subtract(Duration(days: date.weekday - 1))),
            _getLastMinuteOfDay(date.add(Duration(days: 7 - date.weekday))));
      case CalendarGranularity.month:
        return Range(_getFirstMinuteOfDay(DateTime(date.year, date.month, 1)),
            _getLastMinuteOfDay(DateTime(date.year, date.month + 1, 0)));
      case CalendarGranularity.year:
        return Range(_getFirstMinuteOfDay(DateTime(date.year, 1, 1)),
            _getLastMinuteOfDay(DateTime(date.year, 12, 31)));
    }
  }

  DateTime _getLastMinuteOfDay(DateTime date) {
    return new DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  DateTime _getFirstMinuteOfDay(DateTime date) {
    return new DateTime(date.year, date.month, date.day, 0, 0);
  }

  Future<Success<Tree>> addNewTree(User user, Growing growing) async {
    if (await NetworkChecker.hasConnection()) {
      final createTree = CreateTree(
        seedType: growing.seedType,
        user: user.id,
        started: growing.created,
        ended: DateTime.now(),
        reward: growing.reward,
        timeToGrow: growing.timeToGrow,
      );

      final tree = await remoteRepository.addNewTree(user, createTree);
      return tree;
    }

    return Success.fromFailure(failureMessage: 'No internet connection');
  }
}
