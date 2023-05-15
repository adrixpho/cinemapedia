//Repositorio provider inmutable
import 'package:cinemapedia/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/actos_repo_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actosRepositoryProvider = Provider(
    (ref) => ActorsRepositoryImp(dataSource: ActorsMovieDBDataSource()));
