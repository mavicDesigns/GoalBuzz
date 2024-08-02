import 'package:flutter/material.dart';
import 'package:truck/assets/fonts/MavicIcons/mavic_i_cons_icons.dart';
import 'package:truck/src/components/widget/bottom_navigation_bar.dart';
import 'package:truck/src/components/widget/custom_progress_loading.dart';
import 'package:truck/src/components/widget/menu_button.dart';
import 'package:truck/src/components/widget/navigation_drawer.dart';
import 'package:truck/src/screens/pageview/live_screen.dart';
import 'package:truck/src/screens/pageview/settings_screen.dart';
import 'package:truck/src/screens/pageview/home_screen.dart';
import 'package:truck/src/screens/pageview/voiceCall_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    LiveMatchesScreen(),
    VoiceCallRoomsScreen(),
    ProfileSettingsScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          drawer: CustomNavigationDrawer(),
          body: _screens[_currentIndex],
        ),
        Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: BottomNavigationBarComponent(currentIndex: _currentIndex, onTap: _onTap,))),
      ],
    );
  }
}
