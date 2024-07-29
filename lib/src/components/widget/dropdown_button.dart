import 'package:flutter/material.dart';

class DropdownButtonComponent extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?>? onChanged;
  final IconData icon;
  final double iconSize;
  final Color iconColor;

  const DropdownButtonComponent({
    Key? key,
    required this.items,
    this.selectedItem,
    this.onChanged,
    this.icon = Icons.arrow_drop_down,
    this.iconSize = 24.0,
    this.iconColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedItem,
      icon: Icon(icon, size: iconSize, color: iconColor),
      onChanged: onChanged,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }
}
