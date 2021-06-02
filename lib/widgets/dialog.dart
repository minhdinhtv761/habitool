import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';

class Dialog extends StatefulWidget {
  const Dialog({Key key}) : super(key: key);

  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<Dialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Mục tiêu',
        style: TextStyle(
          color: CustomColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Row(
        children: <Widget>[],
      ),
    );
  }
}
