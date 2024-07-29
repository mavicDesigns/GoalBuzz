import 'package:flutter/material.dart';

enum FormStatus { neutral, done, error }

class CustomFormField extends StatelessWidget {
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final String? label;
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final Color? backgroundColor;
  final double borderRadius;
  final Color borderColor;
  final FormStatus formStatus;
  final BoxShadow? boxShadow;
  final String? errorTagline;

  const CustomFormField({
    Key? key,
    this.leadingIcon,
    this.trailingIcon,
    this.label,
    this.placeholder,
    this.onChanged,
    this.validator,
    this.backgroundColor,
    this.borderRadius = 8.0,
    this.borderColor = Colors.grey,
    this.formStatus = FormStatus.neutral,
    this.boxShadow,
    this.errorTagline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color borderColorForStatus;

    switch (formStatus) {
      case FormStatus.done:
        borderColorForStatus = Colors.green;
        break;
      case FormStatus.error:
        borderColorForStatus = Colors.red;
        break;
      default:
        borderColorForStatus = borderColor;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            labelText: label,
            hintText: placeholder,
            prefixIcon: leadingIcon != null ? Icon(leadingIcon) : null,
            suffixIcon: trailingIcon != null
                ? IconButton(
                    icon: Icon(trailingIcon),
                    onPressed: () {
                      // Handle trailing icon press
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColorForStatus),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColorForStatus),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColorForStatus),
            ),
            filled: true,
            fillColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
            contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          ),
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        if (formStatus == FormStatus.error && errorTagline != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              errorTagline!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12.0,
              ),
            ),
          ),
      ],
    );
  }
}
