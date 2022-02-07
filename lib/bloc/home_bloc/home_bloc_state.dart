part of 'home_bloc_cubit.dart';

abstract class HomeBlocState extends Equatable {
  const HomeBlocState();

  @override
  List<Object> get props => [];
}

class HomeBlocInitialState extends HomeBlocState {}

class HomeBlocLoadingState extends HomeBlocState {}

class HomeBlocLoadedState extends HomeBlocState {
  final List<Movie> movies;

  HomeBlocLoadedState(this.movies);

  @override
  List<Object> get props => [movies];
}

class HomeBlocErrorState extends HomeBlocState {
  final String error;

  const HomeBlocErrorState({this.error = 'opps.. something wrong'});

  @override
  List<Object> get props => [error];
}
