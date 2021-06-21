import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
    @required this.typeInput,
    @required this.textAlign,
    @required this.hintText,
    this.getText,
    this.initialValue,
  }) : super(key: key);

  final TextAlign textAlign;
  final TextInputType typeInput;
  final String hintText;
  final StringCallback getText;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: this.initialValue,
       onChanged: (text) {
        this.getText(text);
      },
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
