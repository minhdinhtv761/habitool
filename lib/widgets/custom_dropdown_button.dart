import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_type.dart';

import '../custom_values/custom_colors.dart';

class CustomDropdownButton extends StatefulWidget {
  CustomDropdownButton({
    Key key,
    @required this.listDropdownItems,
    @required this.dropdownValue,
    this.callback,
  }) : super(key: key);

  List<String> listDropdownItems;
  String dropdownValue;
  StringCallback callback;

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: this.widget.dropdownValue,
      icon: Icon(Icons.keyboard_arrow_down_rounded),
      iconSize: 16.0,
      style: const TextStyle(
        color: CustomColors.pink,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
      underline: Container(
        color: Colors.transparent,
      ),
      onChanged: (String newValue) {
        setState(() {
          this.widget.dropdownValue = newValue;
          this.widget.callback(newValue);
        });
      },
      items: this
          .widget
          .listDropdownItems
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
