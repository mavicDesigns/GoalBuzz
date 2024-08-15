import 'package:flutter/material.dart';
import 'package:truck/src/screens/card_screen.dart';
import 'package:truck/src/screens/dialog_screen.dart';
import 'package:truck/src/screens/dropdown_screen.dart';
import 'package:truck/src/screens/form_Screen.dart';
import 'package:truck/src/screens/main_screen.dart';
import 'package:truck/src/screens/matchDetails/match_details_screen.dart';
import 'package:truck/src/screens/select_button_screen.dart';
import 'package:truck/src/screens/splash_screen.dart';
import '../screens/login_screen.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        return MaterialPageRoute(builder: (_) => MainScreen());
    }
  }
}
