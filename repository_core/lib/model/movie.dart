import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  const Movie(this.title, this.poster, this.year);

  final String title;
  final String poster;
  final int year;

  @override
  List<Object?> get props => [title, poster, year];

}