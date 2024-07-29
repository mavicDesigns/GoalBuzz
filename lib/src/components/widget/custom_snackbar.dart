import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    final snackbar = SnackBar(
      content: Row(
        children: [
          if (icon != null) Icon(icon, color: textColor ?? Colors.white),
          if (icon != null) SizedBox(width: 8),
          Expanded(child: Text(message, style: TextStyle(color: textColor ?? Colors.white))),
        ],
      ),
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      duration: duration,
      action: action,
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
