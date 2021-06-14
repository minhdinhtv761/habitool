import 'package:flutter/cupertino.dart';
import 'package:habitool/widgets/custom_dialog.dart';
import 'package:habitool/widgets/custom_textfield.dart';

class PhoneDialog extends StatefulWidget {
  const PhoneDialog({Key key}) : super(key: key);

  @override
  _PhoneDialogState createState() => _PhoneDialogState();
}

class _PhoneDialogState extends State<PhoneDialog> {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Số điện thoại',
      content: CustomTextField(
        typeInput: TextInputType.phone,
        textAlign: TextAlign.start,
        hintText: 'Nhập số điện thoại',
      ),
    );
  }
}
