import '../entities/entities.dart';

abstract class ActorsDataSource {
  Future<List<Actor>> getActorsByMovieId(String movieId);
}
