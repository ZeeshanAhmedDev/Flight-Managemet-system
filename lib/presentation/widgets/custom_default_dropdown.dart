import 'package:flutter/material.dart';

class CustomDefaultDropdown extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final ValueChanged<String?>? onChanged;
  final String? selectedItem;
  final Color borderColor;
  final Color dropdownColor;
  final Color textColor;
  final Color hintTextColor;
  final double borderRadius;
  final double elevation;

  const CustomDefaultDropdown({
    super.key,
    required this.items,
    required this.hintText,
    this.onChanged,
    this.selectedItem,
    this.borderColor = Colors.grey,
    this.dropdownColor = Colors.white,
    this.textColor = Colors.black,
    this.hintTextColor = Colors.grey,
    this.borderRadius = 8.0,
    this.elevation = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedItem,
          hint: Text(
            hintText,
            style: TextStyle(color: hintTextColor),
          ),
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: elevation.toInt(),
          dropdownColor: dropdownColor,
          style: TextStyle(color: textColor, fontSize: 16),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
