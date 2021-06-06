import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';

import '../custom_values/custom_type.dart';
import 'custom_dropdown_button.dart';

class CustomDialog extends StatefulWidget {
  CustomDialog({
    Key key,
    @required this.title,
    @required this.listDropdownItems,
    @required this.dropdownValue,
    @required this.value,
    this.week,
    this.callback,
  }) : super(key: key);

  String title;
  List<String> listDropdownItems;
  String dropdownValue;
  Widget value;
  Widget week;

  StringCallback callback;

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
        width: size.width * 0.5,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomDropdownButton(
              listDropdownItems: this.widget.listDropdownItems,
              dropdownValue: this.widget.dropdownValue,
              callback: this.widget.callback,
            ),
            Expanded(child: this.widget.value),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text(
            'Hủy',
            style: TextStyle(
              color: CustomColors.pink,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
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
