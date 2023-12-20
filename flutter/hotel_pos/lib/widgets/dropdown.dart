// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_field, prefer_final_fields
import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatefulWidget {
  final List dropList;
  TextEditingController controller;

  CustomDropdownMenu({
    Key? key,
    required this.controller,
    required this.dropList,
  }) : super(key: key);

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  late List _dropDownOption;
  late String _defaultOption;
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    _dropDownOption = widget.dropList;
    _defaultOption = widget.dropList.first;
     dropdownValue = _defaultOption;
  }

 // Assuming this is the selected value

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.controller.text = dropdownValue;
        });
      },
      items: widget.dropList.map<DropdownMenuItem<String>>((dynamic value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}


