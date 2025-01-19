import 'package:flutter/material.dart';
import 'package:i_med_team/models/courses_list_model.dart';

class CustomDropdown extends StatelessWidget {
  final Data70 selectedValue;
  final List<Data70> items;
  final ValueChanged<Data70> onChanged;

  CustomDropdown({
    required this.selectedValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFFAD2D3), // Background color
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.redAccent, width: 1),
      ),
      child: DropdownButton<Data70>(
        value: selectedValue,
        isExpanded: true,
        underline: SizedBox(),
        // Removes default underline
        dropdownColor: Color(0xFFFAD2D3),
        // Dropdown menu background
        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
        style: TextStyle(color: Colors.black, fontSize: 18),
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
        items: items
            .map((Data70 item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item.name!,
                    maxLines: 1,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
