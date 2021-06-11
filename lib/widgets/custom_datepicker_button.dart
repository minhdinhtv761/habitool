import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';

class CustomDatePickerButton extends StatefulWidget {
  const CustomDatePickerButton({Key key, this.text}) : super(key: key);

  final String text;
  @override
  _CustomDatePickerButtonState createState() => _CustomDatePickerButtonState();
}

class _CustomDatePickerButtonState extends State<CustomDatePickerButton> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        setState(() {
          _isPressed = !_isPressed;
        });
      },
      fillColor: _isPressed ? CustomColors.pink : Colors.white,
      elevation: 0,
      shape: CircleBorder(),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.all(8),
      constraints: BoxConstraints(minWidth: 0),
      child: Text(
        this.widget.text,
        style: TextStyle(
          fontSize: 16,
          color: _isPressed ? Colors.white : CustomColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
