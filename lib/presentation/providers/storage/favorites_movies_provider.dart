import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/entities.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRep = ref.watch(localStorageProvider);
  return StorageMoviesNotifier(localStorageRepository: localStorageRep);
});

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({
    required this.localStorageRepository,
  }) : super({});

  Future<List<Movie>> loadNextPage() async {
    final List<Movie> movies =
        await localStorageRepository.loadMovies(offset: page * 10);
    page++;

    final loadedMoviesMap = <int, Movie>{};
    for (final Movie movie in movies) {
      loadedMoviesMap[movie.id] = movie;
    }

    state = {...state, ...loadedMoviesMap};

    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await localStorageRepository.toggleFavorite(movie);
    final bool isMovieFavorites = state[movie.id] != null;

    if (isMovieFavorites) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
