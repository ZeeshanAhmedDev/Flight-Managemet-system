import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  final String hintText;
  final DateTime? selectedDate;
  final ValueChanged<DateTime?>? onDateChanged;
  final Color borderColor;
  final Color textColor;
  final Color hintTextColor;
  final double borderRadius;

  const CustomDatePicker({
    super.key,
    required this.hintText,
    this.selectedDate,
    this.onDateChanged,
    this.borderColor = Colors.grey,
    this.textColor = Colors.black,
    this.hintTextColor = Colors.grey,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null && onDateChanged != null) {
          onDateChanged!(pickedDate);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate != null
                  ? DateFormat.yMd().format(selectedDate!)
                  : hintText,
              style: TextStyle(
                color: selectedDate != null ? textColor : hintTextColor,
                fontSize: 16,
              ),
            ),
            const Icon(
              Icons.calendar_today,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
