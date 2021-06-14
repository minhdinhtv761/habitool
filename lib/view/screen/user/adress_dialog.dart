import 'package:flutter/cupertino.dart';
import 'package:habitool/widgets/custom_dialog.dart';
import 'package:habitool/widgets/custom_textfield.dart';

class AdressDialog extends StatefulWidget {
  const AdressDialog({Key key}) : super(key: key);

  @override
  _AdressDialogState createState() => _AdressDialogState();
}

class _AdressDialogState extends State<AdressDialog> {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Địa chỉ',
      content: CustomTextField(
        typeInput: TextInputType.streetAddress,
        textAlign: TextAlign.start,
        hintText: 'Nhập địa chỉ',
      ),
    );
  }
}
