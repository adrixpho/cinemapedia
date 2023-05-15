import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesRepositry {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<List<Movie>> getMostRated({int page = 1});
  Future<Movie> getMovieById({required String id});
  Future<List<Movie>> searchMovies(String query);
}