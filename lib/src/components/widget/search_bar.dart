import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String placeholder;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingIconPressed;
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({
    Key? key,
    required this.placeholder,
    this.leadingIcon,
    this.trailingIcon,
    this.onTrailingIconPressed,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: placeholder,
        prefixIcon: leadingIcon != null ? Icon(leadingIcon) : null,
        suffixIcon: trailingIcon != null
            ? IconButton(
                icon: Icon(trailingIcon),
                onPressed: onTrailingIconPressed,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
    );
  }
}
