import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();

      return await Isar.open(
        [MovieSchema],
        inspector: true, //Service to analyze db internally for developers.
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isFavoriteMovie(int idMovie) async {
    final isar = await db;

    final Movie? movie =
        await isar.movies.filter().idEqualTo(idMovie).findFirst();

    return movie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 30, int offset = 0}) async {
    final isar = await db;

    return isar.movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final Movie? favoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();
    if (favoriteMovie != null) {
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
    } else {
      isar.writeTxnSync(() => isar.movies.putSync(movie));
    }
  }
}
