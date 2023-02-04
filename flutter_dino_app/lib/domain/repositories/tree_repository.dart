import 'package:dartz/dartz.dart';
import 'package:flutter_dino_app/core/success.dart';
import '../models/tree.dart';

abstract class TreeRepository {
  Future<Success<List<Tree>>> retrieveTreeRepository(String userId, DateTime startDate, DateTime endDate);
}