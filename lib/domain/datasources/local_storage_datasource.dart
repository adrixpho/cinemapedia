import '../entities/entities.dart';

abstract class LocalStorageDatasource {
  Future<void> toggleFavorite(Movie movie);
  Future<bool> isFavoriteMovie(int idMovie);
  Future<List<Movie>> loadMovies({int limit = 30, int offset = 0});
}
