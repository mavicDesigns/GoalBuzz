import 'package:flutter/material.dart';

class CustomCardComponent extends StatelessWidget {
  final Widget header;
  final Widget body;
  final Widget footer;
  final Color? headerColor;
  final double borderRadius;
  final BoxShadow? boxShadow;

  const CustomCardComponent({
    Key? key,
    required this.header,
    required this.body,
    required this.footer,
    this.headerColor, // Default light gray color
    this.borderRadius = 8.0,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: 4,
      shadowColor: boxShadow?.color,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: headerColor ?? Theme.of(context).cardTheme.color,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(borderRadius)),
            ),
            child: header,
          ),
          Container(
            child: body,
          ),
          Container(
            child: footer,
          ),
        ],
      ),
    );
  }
}
