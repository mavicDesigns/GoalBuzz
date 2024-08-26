import 'package:flutter/material.dart';
import 'package:truck/src/screens/main_screen.dart';
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
