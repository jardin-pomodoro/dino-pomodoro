import 'package:intl/date_symbol_data_local.dart';

class DateConfig {
  static final localUsed = 'fr';

  Future<void> init() async {
    await initializeDateFormatting(DateConfig.localUsed, null);
  }
}
