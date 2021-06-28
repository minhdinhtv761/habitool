import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/view/screen/new_habit/widgets/dialog_menu.dart';
import 'package:habitool/widgets/custom_dialog.dart';
import 'package:habitool/widgets/custom_textfield.dart';

import '../../../custom_values/custom_colors.dart';

class GoalDialog extends StatefulWidget {
  GoalDialog({
    this.getGoal,
    this.getUnitGoal,
  });

  final StringCallback getUnitGoal;
  final StringCallback getGoal;
  @override
  _GoalDialogState createState() => _GoalDialogState();
}

class _GoalDialogState extends State<GoalDialog> {
  // List<String> _listDropdownItems = ['Không', 'Số lần', 'Thời gian'];
  //String _dropdownValue = 'Không';
  String _goal = '';
  String _unitGoal = '';
  //List<String> _listUnit = ['', 'lần', 'phút'];

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Mục tiêu',
      content: Row(
        children: [
          Spacer(
            flex: 1,
          ),
          Expanded(
            child: CustomTextField(
              typeInput: TextInputType.number,
              textAlign: TextAlign.center,
              hintText: '0',
              getText: (text) {
                this._goal = text;
              },
            ),
          ),
          Expanded(
            child: CustomTextField(
              typeInput: TextInputType.number,
              textAlign: TextAlign.center,
              hintText: 'lần',
              getText: (text) {
                this._unitGoal = text;
              },
            ),
          ),
        ],
      ),
      // content: DialogMenu(
      //   listDropdownItems: _listDropdownItems,
      //   dropdownValue: _dropdownValue,
      //   listUnit: _listUnit,
      //   getDropDownButtonValue: (value) => setState(() {
      //     this._dropdownValue = value;
      //   }),
      //   getText: (text) {
      //     this._goal = text;
      //   },
      // ),
      edited: () {
        this.widget.getGoal(_goal);
        this.widget.getUnitGoal(_unitGoal);
      },
    );
  }
}
