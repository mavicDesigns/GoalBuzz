import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck/src/bloc/authentication/auth_event.dart';
import 'package:truck/src/components/widget/custom_button.dart';
import '../../bloc/authentication/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Home Screen'),
            CustomButton(
              buttonType: ButtonType.elevated,
              onPressed: () {},
              icon: Icons.arrow_forward,
              text: 'Trailing Icon',
            ),
          ],
        ),
      ),
    );
  }
}
