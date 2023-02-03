import 'package:flutter_dino_app/data/datasource/local/database/database_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final localDbProvider = Provider<DatabaseSource>((ref) {
  return DatabaseSource();
});
