import '../../core/success.dart';
import '../models/tree.dart';

abstract class TreeRepository {
  Future<Success<List<Tree>>> retrieveTreeRepository(
      String userId, DateTime startDate, DateTime endDate);
}
