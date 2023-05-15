import 'package:cinemapedia/config/constants/environment.dart';
import 'package:dio/dio.dart';

class NetworkService {
  late Dio dio;

  NetworkService._privateConstructor() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        queryParameters: {
          'api_key': Environment.movieDbKey,
          'language': 'es-MX',
        },
      ),
    );
  }

  static final NetworkService _instance = NetworkService._privateConstructor();

  static NetworkService get instance => _instance;
}
