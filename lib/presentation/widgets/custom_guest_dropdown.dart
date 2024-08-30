import 'package:flutter/material.dart';

class CustomGuestDropdown extends StatefulWidget {
  final String label;
  final int initialCount;
  final ValueChanged<int>? onChanged;

  const CustomGuestDropdown({
    super.key,
    required this.label,
    this.initialCount = 1,
    this.onChanged,
  });

  @override
  _CustomGuestDropdownState createState() => _CustomGuestDropdownState();
}

class _CustomGuestDropdownState extends State<CustomGuestDropdown> {
  late int count;

  @override
  void initState() {
    super.initState();
    count = widget.initialCount;
  }

  void _incrementCount() {
    setState(() {
      count++;
      if (widget.onChanged != null) {
        widget.onChanged!(count);
      }
    });
  }

  void _decrementCount() {
    if (count > 1) {
      setState(() {
        count--;
        if (widget.onChanged != null) {
          widget.onChanged!(count);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.label, style: const TextStyle(fontSize: 16)),
              Text(
                widget.label == 'Adults' ? 'Age 18+' : 'Age 0-17',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: _decrementCount,
                icon: const Icon(Icons.remove_circle_outline),
                color: Colors.blue,
              ),
              Text(
                '$count',
                style: const TextStyle(fontSize: 16),
              ),
              IconButton(
                onPressed: _incrementCount,
                icon: const Icon(Icons.add_circle_outline),
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
