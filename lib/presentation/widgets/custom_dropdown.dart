import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.hintText,
  });
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      items: List.generate(6, (index) => "$index"),
      popupProps: PopupProps.menu(
        showSearchBox: true,
        fit: FlexFit.loose,
        constraints: const BoxConstraints.tightFor(height: 300),
        menuProps: const MenuProps(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        containerBuilder: (context, popupWidget) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: popupWidget,
          );
        },
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: hintText,
          contentPadding: const EdgeInsets.all(12),
          border: const OutlineInputBorder(),
        ),
      ),
      onChanged: print,
      selectedItem: "0",
    );
  }
}
