import '../../core/success.dart';
import '../models/growing.dart';
import '../models/tree.dart';

abstract class TreeRepository {
  Future<Success<List<Tree>>> retrieveTreeRepository(
      String userId, DateTime startDate, DateTime endDate);

  Future<Success<Tree>> addNewTree(String userId, Growing growing);
}
