import 'package:flutter_dino_app/data/datasource/local/repositories/local_remy_tree_repository.dart';
import 'package:flutter_dino_app/domain/usecases/retrieve_tree_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/tree.dart';

final fetchTreeProvider = FutureProvider<List<Tree>>((ref) async {
  //final ApiConsumer consumer = ref.read(apiProvider);
  final retrieveSeedTypeUseCase = RetrieveTreeUseCase(
    localRepository: LocalRemyTreeRepository(),
  );
  return retrieveSeedTypeUseCase();
});