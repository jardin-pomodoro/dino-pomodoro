import 'package:supabase_flutter/supabase_flutter.dart';

import 'api.dart';

class Supabse implements Api {
  @override
  Future<void> connect() async {
    await Supabase.initialize(
      url: 'https://supabase.nospy.fr/',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICAgInJvbGUiOiAiYW5vbiIsCiAgICAiaXNzIjogInN1cGFiYXNlIiwKICAgICJpYXQiOiAxNjcyNjE0MDAwLAogICAgImV4cCI6IDE4MzAzODA0MDAKfQ.xt6fEkZEJcLBjAfU_CNY-I56JGOcTBZYgNJQ5aWH1mc',
    );
  }
}
