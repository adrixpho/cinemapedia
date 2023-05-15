import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/api/network_service.dart';

import '../models/models.dart';

class ActorsMovieDBDataSource extends ActorsDataSource {
  final network = NetworkService.instance.dio;

  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) async {
    final response = await network.get('/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(response.data);

    return (creditsResponse.cast ?? [])
        .map((e) => ActorMapper.actorFromCast(e))
        .toList();
  }
}
