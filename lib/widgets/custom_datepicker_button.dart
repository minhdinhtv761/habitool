import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';

class CustomDatePickerButton extends StatefulWidget {
  CustomDatePickerButton({this.selected, this.text, this.onSelected});
  bool selected;
  final String text;
  BoolCallback onSelected;
  @override
  _CustomDatePickerButtonState createState() =>
      _CustomDatePickerButtonState(this.selected);
}

class _CustomDatePickerButtonState extends State<CustomDatePickerButton> {
  bool isPressed;
  _CustomDatePickerButtonState(this.isPressed);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        setState(() {
          isPressed = !isPressed;
          this.widget.onSelected(isPressed);
        });
      },
      fillColor: isPressed ? CustomColors.pink : Colors.white,
      elevation: 0,
      shape: CircleBorder(),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.all(8),
      constraints: BoxConstraints(minWidth: 0),
      child: Text(
        this.widget.text,
        style: TextStyle(
          fontSize: 16,
          color: isPressed ? Colors.white : CustomColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
