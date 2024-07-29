import 'package:flutter/material.dart';
import 'package:truck/src/components/widget/select_button.dart';

class SelectButtonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Button Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectButtonComponent(
              items: ['Option 1', 'Option 2', 'Option 3'],
              selectedItem: 'Option 1',
              onChanged: (value) {
                print('Selected: $value');
              },
              icon: Icons.arrow_drop_down,
              iconSize: 30.0,
              iconColor: Colors.blue,
            ),
            // Add more SelectButtonComponent instances if needed
          ],
        ),
      ),
    );
  }
}
