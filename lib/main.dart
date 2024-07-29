import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck/src/themes/dartk_theme.dart';
import 'src/bloc/authentication/auth_bloc.dart';
import 'src/themes/light_theme.dart';
import 'src/routes/app_routes.dart';

void main() {
  runApp(AppTemplate());
}

class AppTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Template',
         theme: lightTheme,
      darkTheme: darkTheme,
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: '/',
      ),
    );
  }
}
