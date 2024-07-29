import 'package:flutter/material.dart';
import 'package:truck/src/components/widget/dropdown_button.dart';

class DropdownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown Button Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonComponent(
              items: ['Option 1', 'Option 2', 'Option 3'],
              selectedItem: 'Option 1',
              onChanged: (value) {
                print('Selected: $value');
              },
              icon: Icons.arrow_drop_down,
              iconSize: 30.0,
              iconColor: Colors.blue,
            ),
            DropdownButtonComponent(
              items: ['Option 1', 'Option 2', 'Option 3'],
              selectedItem: 'Option 2',
              onChanged: (value) {
                print('Selected: $value');
              },
              icon: Icons.arrow_drop_down,
              iconSize: 30.0,
              iconColor: Colors.blue,
            ),
            // Add more DropdownButtonComponent instances if needed
          ],
        ),
      ),
    );
  }
}
