import '../../core/either.dart';
import '../models/tree.dart';
import '../../presentation/screen/forest_screen/forest_screen_widget.dart';
import '../../core/network.dart';
import '../../core/usecase.dart';
import '../repositories/remy_tree_repository.dart';

class RetrieveTreeUseCase extends NoParamsUseCase<List<Tree>> {

  RetrieveTreeUseCase({
    required this.localRepository,
    required this.granularity
  });

  final RemyTreeRepository localRepository;
  final CalendarGranularity granularity;

  @override
  Future<List<Tree>> call() async {
    if (await NetworkChecker.hasConnection()) {
      return takeLocal();
    }
    return takeLocal();
  }

  Future<List<Tree>> takeLocal() async {
    final tree = await localRepository.retrieveRemyTreeRepository();
    return tree.asRight();
  }
}