import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/widgets/custom_dialog.dart';
import 'package:habitool/widgets/custom_textfield.dart';

class AdressDialog extends StatefulWidget {
  String address;
  Function(String) edited;
  AdressDialog({Key key, this.address, this.edited}) : super(key: key);

  @override
  _AdressDialogState createState() => _AdressDialogState();
}

class _AdressDialogState extends State<AdressDialog> {
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addressController.text = widget.address;
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Địa chỉ',
      // content: CustomTextField(
      //   typeInput: TextInputType.streetAddress,
      //   textAlign: TextAlign.start,
      //   hintText: 'Nhập địa chỉ',
      // ),
      content: TextFormField(
        controller: _addressController,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: Colors.pinkAccent,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: 'Nhập địa chỉ',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.pinkAccent,
            ),
          ),
        ),
      ),
      edited: () {
        widget.edited(_addressController.text);
      },
    );
  }
}
