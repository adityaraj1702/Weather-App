import 'package:flutter/material.dart';

class DropDownListWidget extends StatefulWidget {
  final List<String> items; // List of items to display in the popup menu
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
    return PopupMenuButton<String>(
      child: Icon(Icons.arrow_drop_down), // Display dropdown arrow
      onSelected: (String? newValue) {
        if (newValue != null) {
          final newIndex = widget.items.indexOf(newValue);
          setState(() {
            _selectedItemIndex = newIndex;
          });
          widget.onItemSelected(newIndex); // Call the callback function
        }
      },
      itemBuilder: (context) => widget.items
          .map((item) => PopupMenuItem(
                value: item,
                child: Text(item),
              ))
          .toList(),
    );
  }
}
