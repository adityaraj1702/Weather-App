import 'package:flutter/material.dart';

class DropDownListWidget extends StatefulWidget {
  final List<String> items; // List of items to display in the dropdown
  final Function(int) onItemSelected; // Callback function to handle selection

  const DropDownListWidget(
      {super.key, required this.items, required this.onItemSelected});

  @override
  State<DropDownListWidget> createState() => _DropDownListWidgetState();
}

class _DropDownListWidgetState extends State<DropDownListWidget> {
  int _selectedItemIndex = 0; // Currently selected item index

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.items[_selectedItemIndex], // Set initial value
      items: widget.items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          final newIndex = widget.items.indexOf(newValue);
          setState(() {
            _selectedItemIndex = newIndex;
          });
          widget.onItemSelected(newIndex); // Call the callback function
        }
      },
    );
  }
}
