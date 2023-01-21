import 'package:flutter_dino_app/domain/models/movie.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FilmNotifier extends StateNotifier<List<Film>> {
  FilmNotifier() : super(allFilms);

  void update(Film film, bool isFavorite) {
    state = state.map((f) {
      if (f.id == film.id) {
        return f.copy(isFavorite: isFavorite);
      }
      return f;
    }).toList();
  }
}

final favoriteStatusProvider =
    StateProvider<FavoriteStatus>((_) => FavoriteStatus.all);

final allFilmsProvider = StateNotifierProvider<FilmNotifier, List<Film>>((_) {
  return FilmNotifier();
});

final favoriteFilmsProvider = Provider<List<Film>>((ref) {
  final films = ref.watch(allFilmsProvider);
  return films.where((film) => film.isFavorite).toList();
});

final notFavoriteFilmsProvider = Provider<List<Film>>((ref) {
  final films = ref.watch(allFilmsProvider);
  return films.where((film) => !film.isFavorite).toList();
});

const allFilms = [
  Film(
    id: 1,
    title: 'The Shawshank Redemption',
    description: 'Two imprisoned persons bond over a number of years, ...',
    isFavorite: false,
  ),
  Film(
    id: 2,
    title: 'The Godfather',
    description:
    'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',
    isFavorite: false,
  ),
  Film(
    id: 3,
    title: 'The Godfather: Part II',
    description:
    'The early life and career of Vito Corleone in 1920s New York City is portrayed, while his son, Michael, expands and tightens his grip on the family crime syndicate.',
    isFavorite: false,
  ),
  Film(
    id: 4,
    title: 'The Dark Knight',
    description:
    'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, the caped crusader must come to terms with one of the greatest psychological tests of his ability to fight injustice.',
    isFavorite: false,
  ),
  Film(
    id: 5,
    title: '12 Angry',
    description:
    'A jury holdout attempts to prevent a miscarriage of justice by forcing his colleagues to reconsider the evidence.',
    isFavorite: false,
  ),
  Film(
    id: 6,
    title: 'Schindler\'s List',
    description:
    'In German-occupied Poland during World War II, Oskar Schindler gradually becomes concerned for his Jewish workforce after witnessing their',
    isFavorite: false,
  ),
  Film(
    id: 7,
    title: 'The Lord of the Rings: The Return of the King',
    description: 'Gandalf and Aragorn lead the World',
    isFavorite: false,
  ),
];
