import 'package:flutter/material.dart';
import 'package:flutter_dino_app/domain/models/movie.dart';
import 'package:flutter_dino_app/presentation/state/movie_list/movie_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MovieListWidget extends ConsumerWidget {
  final AlwaysAliveProviderBase<Iterable<Film>> provider;

  const MovieListWidget({
    required this.provider,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final films = ref.watch(provider);
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: films.length,
        itemBuilder: (context, index) {
          final film = films.elementAt(index);
          return ListTile(
            title: Text(film.title),
            subtitle: Text(film.description),
            trailing: IconButton(
              icon: Icon(
                  film.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                final isFavorite = !film.isFavorite;
                ref.read(allFilmsProvider.notifier).update(film, isFavorite);
              },
            ),
          );
        },
      ),
    );
  }
}

class MovieFilterWidget extends StatelessWidget {
  const MovieFilterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return DropdownButton(
        value: ref.watch(favoriteStatusProvider),
        items: FavoriteStatus.values
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.toString().split('.').last),
                ))
            .toList(),
        onChanged: (FavoriteStatus? value) {
          ref.read(favoriteStatusProvider.notifier).state = value!;
        },
      );
    });
  }
}

class FavoriteMovieWidget extends StatelessWidget {
  const FavoriteMovieWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          const MovieFilterWidget(),
          Consumer(builder: (context, ref, child) {
            final status = ref.watch(favoriteStatusProvider);
            switch (status) {
              case FavoriteStatus.all:
                return MovieListWidget(provider: allFilmsProvider);
              case FavoriteStatus.favorite:
                return MovieListWidget(provider: favoriteFilmsProvider);
              case FavoriteStatus.notFavorite:
                return MovieListWidget(provider: notFavoriteFilmsProvider);
            }
          }),
        ],
      ),
    );
  }
}
