import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) {
              return const HomeView();
            },
            routes: [
              GoRoute(
                path: 'movie/:id', //Parameters will be always Strings
                name: MovieScreen.name,
                builder: (context, state) {
                  final movieId = state.params['id'] ?? 'no-ID';
                  return MovieScreen(movieId: movieId);
                },
              ),
            ]),
        GoRoute(
          path: '/favorites',
          builder: (context, state) {
            return const FavoritesView();
          },
        ),
      ],
    ),

    //Routes Padre/Hijo
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (_, __) => const HomeScreen(childView: FavoritesView()),
    //   routes: [
    //     //Child routes of /
    //     GoRoute(
    //       path: 'movie/:id', //Parameters will be always Strings
    //       name: MovieScreen.name,
    //       builder: (context, state) {
    //         final movieId = state.params['id'] ?? 'no-ID';
    //         return MovieScreen(movieId: movieId);
    //       },
    //     ),
    //   ],
    // ),
  ],
);
