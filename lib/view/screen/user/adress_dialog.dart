import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/widgets/custom_dialog.dart';
import 'package:habitool/widgets/custom_textfield.dart';

class AdressDialog extends StatefulWidget {
  String address;
  StringCallback edited;
  AdressDialog({this.address, this.edited});
  @override
  _AdressDialogState createState() => _AdressDialogState();
}

class _AdressDialogState extends State<AdressDialog> {
  // TextEditingController _addressController = TextEditingController();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _addressController.text = widget.address;
  // }
  String _text;
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Địa chỉ',
      content: CustomTextField(
        initialValue: this.widget.address,
        typeInput: TextInputType.streetAddress,
        textAlign: TextAlign.start,
        hintText: 'Nhập địa chỉ',
        getText: (value) => _text = value,
      ),
      // content: TextFormField(
      //   controller: _addressController,
      //   textAlign: TextAlign.start,
      //   keyboardType: TextInputType.text,
      //   style: TextStyle(
      //     color: Colors.pinkAccent,
      //     fontSize: 16,
      //   ),
      //   decoration: InputDecoration(
      //     hintText: 'Nhập địa chỉ',
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
