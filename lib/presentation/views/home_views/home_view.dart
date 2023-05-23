import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(mostRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcommingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final mostRatedMovies = ref.watch(mostRatedMoviesProvider);
    final upcommingMovies = ref.watch(upcommingMoviesProvider);
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppBar(),
          titlePadding: EdgeInsets.zero,
          centerTitle: false,
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: 1,
          (context, index) {
            return Column(
              children: [
                MoviesSlideshow(movies: moviesSlideshow),
                MovieHorizontalListView(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subtitle: 'Lunes 20',
                  loadNextPage:
                      ref.read(nowPlayingMoviesProvider.notifier).loadNextPage,
                ),
                const SizedBox(height: 20),
                MovieHorizontalListView(
                  movies: popularMovies,
                  title: 'Populares',
                  subtitle: 'Lunes 20',
                  loadNextPage:
                      ref.read(popularMoviesProvider.notifier).loadNextPage,
                ),
                const SizedBox(height: 20),
                MovieHorizontalListView(
                  movies: upcommingMovies,
                  title: 'Upcomming',
                  subtitle: 'Lunes 20',
                  loadNextPage:
                      ref.read(upcommingMoviesProvider.notifier).loadNextPage,
                ),
                const SizedBox(height: 20),
                MovieHorizontalListView(
                  movies: mostRatedMovies,
                  title: 'Mejor calificadas',
                  subtitle: 'Lunes 20',
                  loadNextPage:
                      ref.read(mostRatedMoviesProvider.notifier).loadNextPage,
                ),
                const SizedBox(height: 20)
              ],
            );
          },
        ),
      )
    ]);
  }
}
