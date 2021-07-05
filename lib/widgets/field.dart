import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';

Widget field(Size size, String hintText, TextEditingController cont) {
  return Container(
    height: size.height / 14,
    width: size.width /1.0,
    child: TextField(
      controller: cont,
      decoration: InputDecoration(
        labelText: 'Tài khoản',
        labelStyle: TextStyle(
          color: CustomColors.grey,
          fontSize: 15,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        suffixIcon: IconButton(
          onPressed: () => cont.clear(),
          icon: Icon(Icons.clear),
        ),

      ),
    ),
  );
}
