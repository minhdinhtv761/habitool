import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/widgets/custom_dialog.dart';
import 'package:habitool/widgets/custom_textfield.dart';

class PhoneDialog extends StatefulWidget {
  String phone;
  Function(String) edited;
   PhoneDialog({Key key,this.phone,this.edited}) : super(key: key);

  @override
  _PhoneDialogState createState() => _PhoneDialogState();
}

class _PhoneDialogState extends State<PhoneDialog> {
  TextEditingController _phoneController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneController.text = widget.phone;
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Số điện thoại',
      // content: CustomTextField(
      //   typeInput: TextInputType.phone,
      //   textAlign: TextAlign.start,
      //   hintText: 'Nhập số điện thoại',
      // ),
      content: TextFormField(
        controller: _phoneController,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: Colors.pinkAccent,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: 'Nhập số điện thoại',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.pinkAccent,
            ),
          ),
        ),
      ),
      edited: () {
        widget.edited(_phoneController.text);
      },
    );
  }
}
