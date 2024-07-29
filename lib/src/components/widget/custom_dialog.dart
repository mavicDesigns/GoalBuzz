import 'package:flutter/material.dart';
import 'package:truck/src/themes/light_theme.dart';

enum DialogType { alert, simple }

class CustomDialog extends StatelessWidget {
  final DialogType dialogType;
  final String title;
  final Widget body;
  final List<Widget> actions;
  final Widget? icon;
  final Color? backgroundColor;
  final double borderRadius;

  const CustomDialog({
    required this.dialogType,
    required this.title,
    required this.body,
    required this.actions,
    this.icon,
    this.backgroundColor,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor:
          backgroundColor ?? Theme.of(context).dialogBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppColors.offwhite,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            if (icon != null)
              Center(
                  child: Container(
                      width: 70,
                      alignment: Alignment.center,
                      height: 70,
                      decoration: BoxDecoration(
                          color: AppColors.primary3,
                          borderRadius: BorderRadius.circular(100)),
                      child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              color: AppColors.primary2,
                              borderRadius: BorderRadius.circular(100)),
                          child: icon!))),
            SizedBox(
              height: 30,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8.0),
            body,
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: actions,
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
