import 'package:flutter/material.dart';

import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    @required this.typeInput,
    @required this.textAlign,
    @required this.hintText,
    this.onValueChanged,
  });

  final TextAlign textAlign;
  final TextInputType typeInput;
  final String hintText;
  final Function onValueChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: this.onValueChanged,
      textAlign: this.textAlign,
      keyboardType: this.typeInput,
      style: TextStyle(
        color: CustomColors.pink,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: this.hintText,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: CustomColors.pink,
          ),
        ),
      ),
    );
  }
}
