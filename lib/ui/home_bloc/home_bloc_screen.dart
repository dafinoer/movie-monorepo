import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/home_bloc/home_bloc_cubit.dart';
import 'home_bloc_loaded_screen.dart';
import '../extra/loading.dart';
import '../extra/error_screen.dart';

class HomeBlocScreen extends StatelessWidget {
  const HomeBlocScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
          BlocBuilder<HomeBlocCubit, HomeBlocState>(builder: (context, state) {
        if (state is HomeBlocLoadedState) {
          return const HomeBlocLoadedScreen();
        } else if (state is HomeBlocLoadingState) {
          return LoadingIndicator();
        } else if (state is HomeBlocInitialState) {
          return const SizedBox.shrink();
        } else if (state is HomeBlocErrorState) {
          return ErrorScreen(message: state.error);
        }

        return Center(
          child: Text(
            kDebugMode ? "state not implemented $state" : "",
          ),
        );
      }),
    );
  }
}
