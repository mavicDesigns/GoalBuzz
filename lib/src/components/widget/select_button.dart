import 'package:flutter/material.dart';

class SelectButtonComponent extends StatefulWidget {
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?>? onChanged;
  final IconData icon;
  final double iconSize;
  final Color iconColor;

  const SelectButtonComponent({
    Key? key,
    required this.items,
    this.selectedItem,
    this.onChanged,
    this.icon = Icons.arrow_drop_down,
    this.iconSize = 24.0,
    this.iconColor = Colors.black,
  }) : super(key: key);

  @override
  _SelectButtonComponentState createState() => _SelectButtonComponentState();
}

class _SelectButtonComponentState extends State<SelectButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.selectedItem,
      icon: Icon(widget.icon, size: widget.iconSize, color: widget.iconColor),
      onChanged: widget.onChanged,
      items: widget.items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      style: Theme.of(context).textTheme.bodyMedium,
      underline: SizedBox(), // Remove the underline
      isExpanded: true, // Make the button take full width
      hint: Text(
        widget.selectedItem ?? 'Select an option',
        style: TextStyle(color: Colors.black54),
      ),
    );
  }
}
