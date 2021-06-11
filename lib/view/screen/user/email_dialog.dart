import 'package:flutter/cupertino.dart';
import 'package:habitool/widgets/custom_dialog.dart';
import 'package:habitool/widgets/custom_textfield.dart';

class EmailDialog extends StatefulWidget {
  const EmailDialog({Key key}) : super(key: key);

  @override
  _EmailDialogState createState() => _EmailDialogState();
}

class _EmailDialogState extends State<EmailDialog> {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'E-mail',
      content: CustomTextField(
        typeInput: TextInputType.emailAddress,
        textAlign: TextAlign.start,
        hintText: 'Nhập địa chỉ e-mail',
      ),
    );
  }
}
