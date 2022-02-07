import 'dart:collection';

import '../model/movie.dart';

abstract class MovieRepository {
  Future<UnmodifiableListView<Movie>> getFindMovies(String title);
}
