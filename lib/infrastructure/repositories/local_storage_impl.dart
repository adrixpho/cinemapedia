import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';

class LocalStorageImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorageImpl(this.datasource);

  @override
  Future<bool> isFavoriteMovie(int idMovie) =>
      datasource.isFavoriteMovie(idMovie);

  @override
  Future<List<Movie>> loadMovies({int limit = 30, int offset = 0}) =>
      datasource.loadMovies(limit: limit, offset: offset);

  @override
  Future<void> toggleFavorite(Movie movie) => datasource.toggleFavorite(movie);
}
