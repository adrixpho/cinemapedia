import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovieCallback;
  List<Movie> initialMovies;
  String previousQuery;

  final StreamController<List<Movie>> _debounceMovies =
      StreamController.broadcast();
  final StreamController<bool> _isLoading = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovieCallback,
    this.initialMovies = const [],
    this.previousQuery = '',
  });

  @override
  String get searchFieldLabel => 'Buscar pelicula...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder<bool>(
        stream: _isLoading.stream,
        initialData: false,
        builder: (ctx, snapshot) {
          return (snapshot.data ?? false)
              ? SpinPerfect(
                  duration: const Duration(seconds: 20),
                  spins: 10,
                  infinite: true,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.refresh_rounded),
                  ),
                )
              : FadeIn(
                  animate: query.isNotEmpty,
                  duration: const Duration(milliseconds: 200),
                  child: IconButton(
                    onPressed: () => query = '',
                    icon: const Icon(Icons.clear),
                  ),
                );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        _clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return _buildResults();
  }

  Widget _buildResults() {
    return StreamBuilder<List<Movie>>(
      stream: _debounceMovies.stream,
      initialData: initialMovies,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) => _MovieSearchItem(
            movie: movies[index],
            onMovieSelected: (BuildContext ctx, Movie? movie) {
              _clearStreams();
              close(ctx, movie);
            },
          ),
        );
      },
    );
  }

  void _onQueryChanged(String query) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 900), () async {
      if (query != previousQuery) {
        previousQuery = query;

        _isLoading.add(true);

        final movies = await searchMovieCallback(query);
        initialMovies = movies;
        _isLoading.add(false);
        _debounceMovies.add(movies);
      }
    });
  }

  void _clearStreams() {
    _debounceMovies.close();
  }
}

class _MovieSearchItem extends StatelessWidget {
  final Movie movie;
  final Function(BuildContext, Movie?) onMovieSelected;

  const _MovieSearchItem({
    required this.movie,
    required this.onMovieSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            //Image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return FadeIn(child: child);
                    return SizedBox(
                      height: 130,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(width: 10),

            //Description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),
                  (movie.overview.length > 100)
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.trimNumber(
                            value: movie.voteAverage, toDecimals: 1),
                        style: textStyles.bodyMedium!
                            .copyWith(color: Colors.yellow.shade900),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
