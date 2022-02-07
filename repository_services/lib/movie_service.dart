import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:repository_core/model/movie.dart';
import 'package:repository_services/repository_services.dart';
import 'package:repository_core/repository_core.dart';
import 'package:repository_services/serializers/movie_serializer.dart';

class MovieService extends MovieRepository {
  final DioClient _dioClient;

  MovieService(this._dioClient);

  @override
  Future<UnmodifiableListView<Movie>> getFindMovies(String title) async {
    final result = await _dioClient.dio.get(
      '/title/find',
      queryParameters: {'q': title},
    );

    final toMap = Map.from(result.data);
    if (!toMap.containsKey('results')) throw ArgumentError();
    final listOfSerializer = List.from(toMap['results']).map(
      (e) => MovieSerializer.fromJson(e),
    );

    final toModel = listOfSerializer
        .map((e) => Movie(e.title, e.imageSerializer?.url ?? '', e.yearCreated))
        .toList();

    return UnmodifiableListView(toModel);
  }
}
