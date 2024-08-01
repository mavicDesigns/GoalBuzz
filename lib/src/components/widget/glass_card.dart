import 'dart:ui';

import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final Widget? image;
  final double sigmaX;
  final double sigmaY;

  const GlassCard(
      {super.key,
      required this.child,
      this.image,
      required this.sigmaX,
      required this.sigmaY});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (image != null) image!,
        Center(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
              ),
            ),
          ),
        ),
        child
      ],
    );
  }
}
