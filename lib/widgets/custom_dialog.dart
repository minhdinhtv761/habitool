import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';

import '../custom_values/custom_type.dart';
import 'custom_dropdown_button.dart';

class CustomDialog extends StatefulWidget {
  Function edited;
  CustomDialog({
    @required this.title,
    @required this.content,
    this.edited,
  });

  final String title;
  Widget content;

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(
        this.widget.title,
        style: TextStyle(
          color: CustomColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Container(
        width: size.width * 0.68,
        child: this.widget.content,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(
            'Hủy',
            style: TextStyle(
              color: CustomColors.pink,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
            widget.edited();
          },
          child: const Text(
            'Đồng ý',
            style: TextStyle(
              color: CustomColors.pink,
            ),
          ),
        ),
      ],
    );
  }
}
