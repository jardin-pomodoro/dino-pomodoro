import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentDate = Provider<DateTime>(
  (ref) => DateTime.now(),
);
