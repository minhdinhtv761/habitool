import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/widgets/custom_dialog.dart';
import 'package:habitool/widgets/custom_textfield.dart';

class EmailDialog extends StatefulWidget {
  String email;
  StringCallback edited;
  //EmailDialog({Key key, this.email, this.edited}) : super(key: key);
  EmailDialog({this.email, this.edited});
  @override
  _EmailDialogState createState() => _EmailDialogState();
}

class _EmailDialogState extends State<EmailDialog> {
  // TextEditingController _emailController = TextEditingController();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _emailController.text = widget.email;
  // }
  String _text;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'E-mail',
      content: CustomTextField(
        initialValue: this.widget.email,
        typeInput: TextInputType.emailAddress,
        textAlign: TextAlign.start,
        hintText: 'Nhập e-mail',
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
