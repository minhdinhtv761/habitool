import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/widgets/custom_dialog.dart';
import 'package:habitool/widgets/custom_textfield.dart';

class PhoneDialog extends StatefulWidget {
  String phone;
  StringCallback edited;
  //PhoneDialog({Key key, this.phone, this.edited});
  PhoneDialog({this.phone, this.edited});

  @override
  _PhoneDialogState createState() => _PhoneDialogState();
}

class _PhoneDialogState extends State<PhoneDialog> {
  String _text;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Số điện thoại',
      content: CustomTextField(
        initialValue: this.widget.phone,
        typeInput: TextInputType.phone,
        textAlign: TextAlign.start,
        hintText: 'Nhập số điện thoại',
        getText: (value) => _text = value,
      ),
      // content: TextFormField(
      //   controller: _phoneController,
      //   textAlign: TextAlign.start,
      //   keyboardType: TextInputType.number,
      //   style: TextStyle(
      //     color: Colors.pinkAccent,
      //     fontSize: 16,
      //   ),
      //   decoration: InputDecoration(
      //     hintText: 'Nhập số điện thoại',
      //     enabledBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(
      //         color: Colors.pinkAccent,
      //       ),
      //     ),
      //   ),
      // ),
      edited: () {
        widget.edited(_text);
      },
    );
  }
}
