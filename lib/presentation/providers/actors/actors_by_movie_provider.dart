import 'package:cinemapedia/domain/entities/entities.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final getActosFunction =
      ref.watch(actosRepositoryProvider).getActorsByMovieId;

  return ActorsByMovieNotifier(getActors: getActosFunction);
});

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActors({required String movieId}) async {
    if (state.containsKey(movieId)) return;

    final actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }
}
