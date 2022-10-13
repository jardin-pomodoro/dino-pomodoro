import '../models/dino_model.dart';

abstract class DinoRepository {
  Future<List<DinoModel>> getDinos();
  Future<void> addDino(DinoModel dino);
  Future<void> deleteDino(int id);
}
