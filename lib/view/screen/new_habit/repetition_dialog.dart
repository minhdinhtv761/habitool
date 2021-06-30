import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/functions/habit_functions.dart';
import 'package:habitool/view/screen/new_habit/widgets/dialog_datepicker.dart';
import 'package:habitool/widgets/custom_datepicker_button.dart';
import 'package:habitool/widgets/custom_dialog.dart';

import '../../../custom_values/custom_colors.dart';
import '../../../custom_values/custom_type.dart';
import '../../../custom_values/custom_type.dart';
import '../../../custom_values/custom_type.dart';
import 'widgets/dialog_menu.dart';

class RepetitionDialog extends StatefulWidget {
  List<int> repeat;
  ListBoolCallback getRepeat;
  RepetitionDialog({this.repeat, this.getRepeat});
  @override
  _RepetitionDialogState createState() => _RepetitionDialogState();
}

class _RepetitionDialogState extends State<RepetitionDialog> {
  List<bool> newRepeat = [];
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Lặp lại',
      content: DialogDatePicker(
        repeat: HabitFunctions.convertToBoolList(this.widget.repeat).toList(),
        getListRepeat: (listSelected) {
          this.newRepeat = listSelected.toList();
        },
      ),
      edited: () {
        if (newRepeat.isNotEmpty)
          this.widget.getRepeat(this.newRepeat);
        else
          this.widget.getRepeat(
              HabitFunctions.convertToBoolList(this.widget.repeat).toList());
      },
    );
  }
}
