import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/widgets/custom_dialog.dart';
import 'package:radio_grouped_buttons/radio_grouped_buttons.dart';

class GenderDialog extends StatefulWidget {
  String gender;
  final StringCallback getGender;

  GenderDialog(this.gender, {this.getGender});
  @override
  _GenderDialogState createState() => _GenderDialogState();
}

class _GenderDialogState extends State<GenderDialog> {
  String _gender;
  List<String> buttonList = ['Nam', 'Nữ', 'Khác'];
  @override
  void initState() {
    print(buttonList.indexOf(this.widget.gender));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
        title: 'Giới tính',
        content: CustomRadioButton(
          initialSelection: buttonList.indexOf(this.widget.gender),
          buttonLables: buttonList,
          buttonValues: buttonList,
          radioButtonValue: (value, index) {
            _gender = value;
          },
          horizontal: true,
          enableShape: true,
          buttonSpace: 10,
          buttonColor: Colors.white,
          selectedColor: CustomColors.pink,
          elevation: 0,
        ),
        edited: () {
          if (_gender != null)
            this.widget.getGender(_gender);
          else
            this.widget.getGender(this.widget.gender);
        });
  }
}
