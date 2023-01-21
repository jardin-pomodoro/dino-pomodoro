import 'package:flutter/material.dart';

@immutable
class Film {
  final int id;
  final String title;
  final String description;
  final bool isFavorite;

  const Film({
    required this.id,
    required this.title,
    required this.description,
    required this.isFavorite,
  });

  Film copy({
    required bool isFavorite,
  }) {
    return Film(
      id: id,
      title: title,
      description: description,
      isFavorite: isFavorite,
    );
  }

  @override
  String toString() {
    return 'Film('
        'id: $id, '
        'title: $title, '
        'description: $description, '
        'isFavorite: $isFavorite'
        ')';
  }

  @override
  bool operator ==(covariant Film other) {
    return id == other.id && isFavorite == other.isFavorite;
  }

  @override
  int get hashCode => Object.hash(id, isFavorite);
}

enum FavoriteStatus {
  all,
  favorite,
  notFavorite
}