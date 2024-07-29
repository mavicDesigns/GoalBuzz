import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck/src/bloc/authentication/auth_event.dart';
import '../bloc/authentication/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Login Screen'),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(LoggedIn());
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
