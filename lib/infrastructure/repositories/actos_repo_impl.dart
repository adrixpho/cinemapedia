import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorsRepositoryImp extends ActorsRepository {
  final ActorsDataSource dataSource;

  ActorsRepositoryImp({
    required this.dataSource,
  });

  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) async =>
      await dataSource.getActorsByMovieId(movieId);
}
