import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/entities.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final getMovieInfoFunction = ref.watch(movieRepositoryProvider).getMovieById;

  return MovieMapNotifier(getMovieById: getMovieInfoFunction);
});

typedef GetMovieCallback = Future<Movie> Function({required String id});

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovieById;

  MovieMapNotifier({required this.getMovieById}) : super({});

  Future<void> loadMovie({required String movieId}) async {
    if (state.containsKey(movieId)) return;

    final movie = await getMovieById(id: movieId);
    state = {...state, movieId: movie};
  }
}
