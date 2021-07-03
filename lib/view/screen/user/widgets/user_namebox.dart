import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/widgets/custom_card.dart';

class UserNameBox extends StatelessWidget {
  UserNameBox({
    Key key,
    this.displayName,
  }) : super(key: key);
  String displayName;
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        initialValue: this.displayName,
        style: TextStyle(
            color: CustomColors.pink,
            fontSize: 18,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Tên người dùng',
          hintStyle: TextStyle(
              color: CustomColors.grey,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
