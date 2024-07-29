import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pushReplacementNamed('/home');
      });
    });

    return Scaffold(
      backgroundColor: Colors.white, // Background color or image
      body: Center(
        child: Text(
          "GOALBUZZ",
          style:
              TextStyle(
                color: Theme.of(context).textTheme.titleLarge!.color,
                fontSize: 45,
                fontFamily: 'Nunitosans',
                fontWeight: FontWeight.bold
                ),
        ), // Splash screen image
      ),
    );
  }
}
