import 'package:cinemapedia/domain/entities/movie.dart';

import '../models/models.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}'
          : 'https://imgs.search.brave.com/SBL0FH8eMiOWdYHjT1DskVC5Ax4Yg2ovW_dkitFEGMI/rs:fit:474:355:1/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vNDc0/eC9hZS84YS9jMi9h/ZThhYzJmYTIxN2Qy/M2FhZGNjOTEzOTg5/ZmNjMzRhMi0tLXBh/Z2UtZW1wdHktcGFn/ZS5qcGc',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      genres: [],
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}'
          : 'https://eapp.org/wp-content/uploads/2018/05/poster_placeholder.jpg',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount);

  static Movie movieDetailsToEntity(MovieDetail moviedb) => Movie(
        adult: moviedb.adult ?? false,
        backdropPath: (moviedb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}'
            : 'https://imgs.search.brave.com/SBL0FH8eMiOWdYHjT1DskVC5Ax4Yg2ovW_dkitFEGMI/rs:fit:474:355:1/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vNDc0/eC9hZS84YS9jMi9h/ZThhYzJmYTIxN2Qy/M2FhZGNjOTEzOTg5/ZmNjMzRhMi0tLXBh/Z2UtZW1wdHktcGFn/ZS5qcGc',
        genreIds: [],
        genres: moviedb.genres?.map((e) => e.name ?? '').toList() ?? [],
        id: moviedb.id ?? 0,
        originalLanguage: moviedb.originalLanguage ?? '',
        originalTitle: moviedb.originalTitle ?? '',
        overview: moviedb.overview ?? '',
        popularity: moviedb.popularity ?? 0.0,
        posterPath: (moviedb.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}'
            : 'https://eapp.org/wp-content/uploads/2018/05/poster_placeholder.jpg',
        releaseDate: moviedb.releaseDate ?? DateTime.now(),
        title: moviedb.title ?? '',
        video: moviedb.video ?? false,
        voteAverage: moviedb.voteAverage ?? 0.0,
        voteCount: moviedb.voteCount ?? 0,
      );
}
