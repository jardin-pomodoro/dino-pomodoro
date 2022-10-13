import 'package:flutter_dino_app/domain/models/dino_model.dart';

import '../../../domain/repositories/dino_repository.dart';

class DinoRepositorySqlite implements DinoRepository {
  @override
  Future<void> addDino(DinoModel dino) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteDino(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<DinoModel>> getDinos() {
    throw UnimplementedError();
  }
}
