import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        path: '/',
        name: HomeScreen.name,
        builder: (_, __) => const HomeScreen(),
        routes: [
          //Child routes of /
          GoRoute(
            path: 'movie/:id', //Parameters will be always Strings
            name: MovieScreen.name,
            builder: (context, state) {
              final movieId = state.params['id'] ?? 'no-ID';
              return MovieScreen(movieId: movieId);
            },
          ),
        ]),
  ],
);
