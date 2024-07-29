import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double width;
  final double height;

  const CustomProgressIndicator({
    this.width = 250.0,
    this.height = 250.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        addRepaintBoundary: false,
        'lib/assets/lottie/mavicLoader.json',
        width: width,
        height: height,
        repeat: true,
      ),
    );
  }
}
