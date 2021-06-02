import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_values/custom_colors.dart';

class BodyMenu extends StatelessWidget {
  const BodyMenu({
    Key key,
    this.icon,
    this.title,
    this.content,
    this.press,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String content;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      onPressed: press,
      child: Row(
        children: [
          Visibility(
            visible: icon != null,
            child: Icon(
              icon,
              color: CustomColors.grey,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              '$title',
              style: TextStyle(
                fontSize: 16,
                color: CustomColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            '$content',
            style: TextStyle(
              color: CustomColors.pink,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: CustomColors.pink,
          )
        ],
      ),
    );
  }
}
