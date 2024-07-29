import 'package:flutter/material.dart';

enum NavigationBarType { icons, text, both }

class BottomNavigationBarComponent extends StatelessWidget {
  final int currentIndex;
  final List<String> items;
  final List<IconData>? icons;
  final NavigationBarType navigationBarType;
  final ValueChanged<int>? onTap;

  const BottomNavigationBarComponent({
    Key? key,
    required this.currentIndex,
    required this.items,
    this.icons,
    this.navigationBarType = NavigationBarType.both,
    this.onTap,
  })  : assert(navigationBarType != NavigationBarType.icons || icons != null, 
               'Icons must be provided if navigationBarType is icons'),
        assert(navigationBarType != NavigationBarType.text || icons == null, 
               'Icons should be null if navigationBarType is text'),
        assert(icons == null || icons.length == items.length, 
               'Icons length must be equal to items length'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedColor = theme.colorScheme.tertiary;
    final unselectedColor = Colors.grey;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: List.generate(items.length, (index) {
        final icon = icons?[index] ?? Icons.circle;
        return BottomNavigationBarItem(
          icon: navigationBarType == NavigationBarType.text
              ? SizedBox.shrink()
              : Icon(icon, color: index == currentIndex ? selectedColor : unselectedColor),
          label: navigationBarType == NavigationBarType.icons
              ? ''
              : items[index], // Provide label only if not using icons
          activeIcon: navigationBarType == NavigationBarType.text
              ? null
              : Icon(icon, color: selectedColor),
        );
      }),
      selectedItemColor: selectedColor,
      unselectedItemColor: unselectedColor,
      type: BottomNavigationBarType.fixed,
    );
  }
}
