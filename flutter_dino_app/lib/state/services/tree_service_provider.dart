import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/api/api_consumer.dart';
import '../../data/datasource/api/repositories/api_tree_repository.dart';
import '../../data/datasource/local/repositories/local_tree_repository.dart';
import '../../domain/services/tree_service.dart';
import '../api_consumer/api_consumer.dart';

final treeServiceProvider = Provider<TreeService>((ref) {
  final ApiConsumer consumer = ref.read(apiProvider);
  return TreeService(
    remoteRepository: RemoteTreeRepository(consumer),
    localRepository: LocalTreeRepository(),
  );
});
