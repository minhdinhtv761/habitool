import 'package:flutter/material.dart';

import '../custom_values/custom_colors.dart';

class NameBox extends StatefulWidget {
  @override
  _NameBoxState createState() => _NameBoxState();
}

class _NameBoxState extends State<NameBox> {
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    bool _isObscure = false;

    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.only(top: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
            color: CustomColors.pink,
            fontSize: 18,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Tên thói quen',
          hintStyle: TextStyle(
              color: CustomColors.grey,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          prefixIcon: IconButton(
            icon: !_isObscure ? Icon(Icons.star_border) : Icon(Icons.star),
            color: !_isObscure ? CustomColors.grey : Colors.yellow,
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5, right: 18),
            child: Material(
              type: MaterialType.transparency,
              child: Ink(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: CustomColors.pink,
                    width: 1,
                  ),
                ),
                child: IconButton(
                  icon: Icon(Icons.ac_unit),
                  color: CustomColors.pink,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
