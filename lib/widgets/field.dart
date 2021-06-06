import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';


Widget field(
    Size size, String hintText, TextEditingController cont) {
  return Container(
    height: size.height / 14,
    width: size.width / 1.1,
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
        suffixIcon: cont
            .text.isEmpty
            ? Container(
          width: 0.0,
        )
            : IconButton(
          icon: Icon(Icons.close),
          onPressed: () =>
              cont.clear(),
        ),

      ),
    ),
  );
}