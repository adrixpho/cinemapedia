import 'dart:developer';

import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_detail.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';

import '../models/api/network_service.dart';

class MovieDBDataSource extends MoviesDataSource {
  final dio = NetworkService.instance.dio;

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {
        'page': page,
      },
    );

    return _listFromDataResponse(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {
        'page': page,
      },
    );

    return _listFromDataResponse(response.data);
  }

  @override
  Future<List<Movie>> getMostRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {
        'page': page,
      },
    );

    return _listFromDataResponse(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {
        'page': page,
      },
    );

    return _listFromDataResponse(response.data);
  }

  List<Movie> _listFromDataResponse(Map<String, dynamic> data) {
    final movieDBResponse = MovieDbResponse.fromJson(data);
    final List<Movie> movies = movieDBResponse.results
        .where((element) => element.posterPath != 'no-poster')
        .map(MovieMapper.movieDBToEntity)
        .toList();

    return movies;
  }

  @override
  Future<Movie> getMovieById({required String id}) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) {
      throw Exception('Movie with id: $id not found');
    }

    final movieDetail = MovieDetail.fromJson(response.data);
    final movie = MovieMapper.movieDetailsToEntity(movieDetail);

    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];

    log('Request query: $query');

    final response = await dio.get(
      '/search/movie',
      queryParameters: {
        'query': query,
      },
    );

    return _listFromDataResponse(response.data);
  }
}
