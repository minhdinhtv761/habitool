import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/widgets/custom_dialog.dart';
import 'package:habitool/widgets/custom_textfield.dart';

class EmailDialog extends StatefulWidget {
  String email;
  Function(String) edited;
  EmailDialog({Key key, this.email, this.edited}) : super(key: key);

  @override
  _EmailDialogState createState() => _EmailDialogState();
}

class _EmailDialogState extends State<EmailDialog> {
  TextEditingController _emailController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'E-mail',
      content: TextFormField(
        controller: _emailController,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: Colors.pinkAccent,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: 'Nhập email:',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.pinkAccent,
            ),
          ),
        ),
      ),
      edited: () {
        widget.edited(_emailController.text);
      },
    );
  }
}
