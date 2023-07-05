import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/entities.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();

    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final List<Movie> movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline_sharp,
              color: colors.primary,
              size: 60,
            ),
            Text(
              'Ohhh no!!',
              style: TextStyle(fontSize: 30, color: colors.primary),
            ),
            Text(
              'No tienes peliculas favoritas',
              style: TextStyle(
                fontSize: 20,
                color: colors.secondary,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => context.go('/home/0'),
              child: const Text('Comienza a buscar'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(
        movies: favoriteMovies,
        loadNextPage: loadNextPage,
      ),
    );
  }
}
