import 'package:cinemapedia/infrastructure/datasources/isar_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/local_storage_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageProvider =
    Provider((ref) => LocalStorageImpl(IsarDatasource()));
