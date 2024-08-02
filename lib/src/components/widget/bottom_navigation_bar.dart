import 'package:flutter/material.dart';
import 'package:truck/assets/fonts/MavicIcons/mavic_i_cons_icons.dart';
import 'package:truck/src/components/widget/glass_card.dart';

enum NavigationBarType { icons, text, both }

class BottomNavigationBarComponent extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const BottomNavigationBarComponent({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.only(bottom: 30, right: 20, left: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.transparent),
      child: GlassCard(
        sigmaX: 20,
        sigmaY: 20,
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(MavicICons.planet, 0, context),
              _buildNavItem(MavicICons.calendar_week, 1, context),
              _buildNavItem(MavicICons.phone, 2, context),
              _buildNavItem(MavicICons.user_02, 3, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, BuildContext context) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color:
                isSelected ? Theme.of(context).primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(30)),
        child: IconButton(
          onPressed: () => onTap!(index),
          color: Theme.of(context).textTheme.bodyMedium!.color,
          icon: Icon(icon, size: 26),
        ),
      ),
    );
  }
}
