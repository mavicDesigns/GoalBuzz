import 'package:flutter/material.dart';
import 'package:truck/src/components/widget/custom_button.dart';
import 'package:truck/src/components/widget/custom_dialog.dart';
import 'package:truck/src/components/widget/custom_snackbar.dart';
import 'package:truck/src/themes/light_theme.dart';

class DialogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Dialogs'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => CustomDialog(
                    dialogType: DialogType.alert,
                    title: 'Alert',
                    body: Text('This is an alert dialog.'),
                    actions: [
                      CustomButton(
                        buttonType: ButtonType.outlined,
                        onPressed: () => Navigator.of(context).pop(),
                        text: 'Cancel',
                      ),
                      SizedBox(width: 20,),
                       CustomButton(
                        buttonType: ButtonType.elevated,
                        backgroundColor: AppColors.primary2,
                        onPressed: () => Navigator.of(context).pop(),
                        text: 'Ok',
                      ),
                    ],
                    icon: Icon(Icons.warning, size: 30, color: Colors.white),
                  ),
                );
              },
              child: Text('Show Alert Dialog'),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => CustomDialog(
                    dialogType: DialogType.simple,
                    title: 'Simple Dialog',
                    body: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SimpleDialogOption(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Option 1'),
                        ),
                        SimpleDialogOption(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Option 2'),
                        ),
                        SimpleDialogOption(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Option 3'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Show Simple Dialog'),
            ),
         
          ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => CustomDialog(
                    dialogType: DialogType.simple,
                    title: 'Simple Dialog',
                    body: Text('Were used to dealing with annoying permission requests ', textAlign: TextAlign.center,) ,
                     actions: [
                      CustomButton(
                        buttonType: ButtonType.outlined,
                        backgroundColor: AppColors.primary2,
                        onPressed: () => Navigator.of(context).pop(),
                        text: 'Cancel',
                      ),
                      SizedBox(width: 20,),
                      CustomButton(
                        buttonType: ButtonType.elevated,
                        backgroundColor: AppColors.primary2,
                        onPressed: () => Navigator.of(context).pop(),
                        text: 'Confirm',
                      ),
                    ],
                  ),
                );
              },
              child: Text('Show Content Dialog'),
            ),
            ElevatedButton(
              onPressed: () {
                CustomSnackbar.show(
                  context: context,
                  message: 'This is a custom snackbar!',
                  textColor: Colors.white,
                  icon: Icons.info,
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      // Perform some action
                    },
                  ),
                );
              },
              child: Text('Show Custom Snackbar'),
            ),
          ],
        ),
      ),
    );
  }
}
