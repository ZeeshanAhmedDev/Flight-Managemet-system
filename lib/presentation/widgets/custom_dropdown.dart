import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../core/utils/color_constants.dart';

class CustomDropdown extends StatelessWidget {
  final String hintText;
  final List<String> items;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      items: items,
      popupProps: PopupProps.menu(
        showSearchBox: true,
        fit: FlexFit.loose,
        constraints: const BoxConstraints.tightFor(height: 300),
        menuProps: const MenuProps(
          backgroundColor: ColorConstants.appBarColor,
          elevation: 2,
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
          fillColor: ColorConstants.appBarColor,
          filled: true,
          contentPadding: const EdgeInsets.all(12),
          border: const OutlineInputBorder(),
        ),
      ),
      onChanged: print,
      selectedItem: items.isNotEmpty ? items[0] : null,
    );
  }
}
