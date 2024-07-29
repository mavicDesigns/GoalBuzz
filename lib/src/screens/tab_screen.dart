import 'package:flutter/material.dart';
import 'package:truck/src/components/widget/tab_component.dart';

class TabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabComponent(
      tabCount: 3,
      tabTitles: ['Home', 'Profile', 'Settings'],
      tabViews: [
        Center(child: Text('Content for Home Tab')),
        Center(child: Text('Content for Profile Tab')),
        Center(child: Text('Content for Settings Tab')),
      ],
      title: 'My Tabs',
    );
  }
}
