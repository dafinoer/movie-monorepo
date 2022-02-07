import 'package:majootestcase/ui/home_bloc/home_bloc_screen.dart';
import 'package:majootestcase/ui/login/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:repository_services/third_party_service/dio_client.dart';
import 'bloc/auth_bloc/auth_bloc_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/home_bloc/home_bloc_cubit.dart';
import 'package:flutter/material.dart';

import 'utils/http_client_setup.dart';

void main() {
  final dioClient = DioClient.instance();
  final clientSetup = HttpClientSetup.dev();
  dioClient.optionSetup(clientSetup);


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => AuthBlocCubit()..getHistoryLogin(),
        child: MyHomePageScreen(),
      ),
    );
  }
}

class MyHomePageScreen extends StatelessWidget {
  const MyHomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBlocCubit, AuthBlocState>(builder: (context, state) {
      if (state is AuthBlocLoginState) {
        return LoginPage();
      } else if (state is AuthBlocLoggedInState) {
        return BlocProvider(
          create: (context) => HomeBlocCubit()..getMovies(),
          child: HomeBlocScreen(),
        );
      }

      return Center(
          child: Text(kDebugMode ? "state not implemented $state" : ""));
    });
  }
}
