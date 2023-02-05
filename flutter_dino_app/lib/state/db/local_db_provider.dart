import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/local/database/database_source.dart';

final localDbProvider = Provider<DatabaseSource>((ref) {
  return DatabaseSource();
});
