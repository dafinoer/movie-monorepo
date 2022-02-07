import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository_core/model/movie.dart';

import '../../bloc/home_bloc/home_bloc_cubit.dart';

class HomeBlocLoadedScreen extends StatelessWidget {
  const HomeBlocLoadedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = _getMovies(context);

    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => _MovieItemWidget(movie: items[index]),
      ),
    );
  }

  List<Movie> _getMovies(BuildContext context) {
    final state = context.read<HomeBlocCubit>().state;
    if (state is HomeBlocLoadedState) return UnmodifiableListView(state.movies);
    return <Movie>[];
  }
}

class _MovieItemWidget extends StatelessWidget {
  const _MovieItemWidget({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(25),
            child: Image.network(movie.poster),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Text(movie.title, textDirection: TextDirection.ltr),
          )
        ],
      ),
    );
  }
}
