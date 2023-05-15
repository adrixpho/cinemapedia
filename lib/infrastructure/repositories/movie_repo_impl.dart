import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepositry {
  final MoviesDataSource datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) =>
      datasource.getNowPlaying(page: page);

  @override
  Future<List<Movie>> getPopular({int page = 1}) =>
      datasource.getPopular(page: page);

  @override
  Future<List<Movie>> getMostRated({int page = 1}) =>
      datasource.getMostRated(page: page);

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) =>
      datasource.getUpcoming(page: page);

  @override
  Future<Movie> getMovieById({required String id}) =>
      datasource.getMovieById(id: id);

  @override
  Future<List<Movie>> searchMovies(String query) =>
      datasource.searchMovies(query);
}
