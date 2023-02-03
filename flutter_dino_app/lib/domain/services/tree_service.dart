
import 'package:flutter_dino_app/core/success.dart';

import '../../core/network.dart';
import '../../presentation/screen/forest_screen/forest_screen_widget.dart';
import '../models/tree.dart';
import '../repositories/remy_tree_repository.dart';

class TreeService {
  TreeService({
    required this.localRepository,
    required this.granularity
  });

  final RemyTreeRepository localRepository;
  final CalendarGranularity granularity;

  Future<Success<List<Tree>>> retrieveTree() async {
    if (await NetworkChecker.hasConnection()) {
      final tree = await localRepository.retrieveRemyTreeRepository();
      if (tree.isSuccess) {
        return tree;
      }
    }
    return await localRepository.retrieveRemyTreeRepository();
  }
}