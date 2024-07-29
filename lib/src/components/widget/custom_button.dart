import 'package:flutter/material.dart';
import 'package:truck/src/themes/light_theme.dart';

enum ButtonType { elevated, text, outlined, icon }

class CustomButton extends StatelessWidget {
  final ButtonType buttonType;
  final VoidCallback onPressed;
  final IconData? icon;
  final String? text;
  final bool trailingIcon;
  final double borderRadius;
  final bool showShadow;
  final Color? backgroundColor;
  final Color? textColor;
  final double? elevation;

  CustomButton({
    required this.buttonType,
    required this.onPressed,
    this.icon,
    this.text,
    this.trailingIcon = false,
    this.borderRadius = 10.0,
    this.showShadow = false,
    this.backgroundColor,
    this.textColor,
    this.elevation = 4.0,
  });

  ButtonStyle _buttonStyle(BuildContext context) {
    switch (buttonType) {
      case ButtonType.elevated:
        return ElevatedButton.styleFrom(
          foregroundColor: textColor ?? Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 28),
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: showShadow ? elevation : 0.0,
        );
      case ButtonType.text:
        return TextButton.styleFrom(
          foregroundColor: textColor ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        );
      case ButtonType.outlined:
        return OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 28),
          backgroundColor: WidgetStateColor.resolveWith((states) => AppColors.offwhite,),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0
        );
      default:
        return ElevatedButton.styleFrom(
          foregroundColor: textColor ?? Colors.white,
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: showShadow ? elevation : 0.0,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _buttonStyle(context);

    if (buttonType == ButtonType.icon) {
      return IconButton(
        icon: Icon(icon),
        color: backgroundColor ?? Theme.of(context).primaryColor,
        onPressed: onPressed,
      );
    }

    if (icon != null) {
      if (trailingIcon) {
        return ElevatedButton.icon(
          style: buttonStyle,
          onPressed: onPressed,
          icon: Text(text ?? ''),
          label: Icon(icon),
        );
      } else {
        return ElevatedButton.icon(
          style: buttonStyle,
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(text ?? ''),
        );
      }
    } else {
      return ElevatedButton(
        style: buttonStyle,
        onPressed: onPressed,
        child: Text(text ?? 'Button'),
      );
    }
  }
}
