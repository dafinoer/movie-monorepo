import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repository_core/model/movie.dart';
import 'package:repository_core/repository_core.dart';
import 'package:repository_services/movie_service.dart';
import 'package:repository_services/repository_services.dart';

import '../../utils/error_helper.dart';

part 'home_bloc_state.dart';

class HomeBlocCubit extends Cubit<HomeBlocState> {
  final MovieRepository _movieRepository;

  HomeBlocCubit(this._movieRepository) : super(HomeBlocInitialState());

  static HomeBlocCubit create(BuildContext context) {
    final dioClient = DioClient.instance();
    final movieRepo = MovieService(dioClient);
    return HomeBlocCubit(movieRepo);
  }

  void getMovies(String title) async {
    try {
      final result = await _movieRepository.getFindMovies(title);
      emit(HomeBlocLoadedState(result));
    } on DioError catch (error){
      final errorMessage = ErrorHelper.extractApiError(error);
      emit(HomeBlocErrorState(error: errorMessage));
    } catch (e) {
      emit(const HomeBlocErrorState());
    }
  }
}
