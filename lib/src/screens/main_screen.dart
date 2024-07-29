import 'package:flutter/material.dart';
import 'package:truck/assets/fonts/MavicIcons/mavic_i_cons_icons.dart';
import 'package:truck/src/components/widget/bottom_navigation_bar.dart';
import 'package:truck/src/components/widget/custom_progress_loading.dart';
import 'package:truck/src/components/widget/menu_button.dart';
import 'package:truck/src/components/widget/navigation_drawer.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
        leading: Builder(builder: (context) {
          return MenuButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      drawer: CustomNavigationDrawer(),
      body: Center(
          // child: CustomProgressIndicator(),
          ),
      bottomNavigationBar: Container(
        height: 70,
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [],
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                onPressed: () => {},
                color: Theme.of(context).textTheme.bodyMedium!.color,
                icon: Icon(
                  Icons.live_tv_sharp,
                  size: 26,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30)),
              child: IconButton(
                onPressed: () => {},
                color: Theme.of(context).primaryColorDark,
                icon: Icon(MavicICons.calendar_week, size: 26),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                onPressed: () => {},
                color: Theme.of(context).textTheme.bodyMedium!.color,
                icon: Icon(MavicICons.phone, size: 26),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                onPressed: () => {},
                color: Theme.of(context).textTheme.bodyMedium!.color,
                icon: Icon(MavicICons.user_02, size: 26),
              ),
            )
          ],
        ),
      ),
    );
  }
}
