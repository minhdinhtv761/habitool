import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/view/screen/new_habit/widgets/dialog_datepicker.dart';
import 'package:habitool/widgets/custom_datepicker_button.dart';
import 'package:habitool/widgets/custom_dialog.dart';

import '../../../custom_values/custom_colors.dart';
import '../../../custom_values/custom_type.dart';
import '../../../custom_values/custom_type.dart';
import '../../../custom_values/custom_type.dart';
import 'widgets/dialog_menu.dart';

class RepetitionDialog extends StatefulWidget {
  RepetitionDialog({
    Key key,
    this.getUnit,
    this.getRepeat,
  }) : super(key: key);
  final StringCallback getUnit;
  final StringCallback getRepeat;
  @override
  _RepetitionDialogState createState() => _RepetitionDialogState();
}

class _RepetitionDialogState extends State<RepetitionDialog> {
  String _repeat = '';

  List<String> _listDropdownItems = [
    'Không',
    'Hàng ngày',
    'Hàng tuần',
    'Hàng tháng',
    'Hàng năm'
  ];
  String _dropdownValue = 'Không';
  List<String> _listUnit = ['', 'ngày/lần', 'tuần/lần', 'tháng/lần', 'năm/lần'];
  bool _isWeekly = false;

  void showWeekly() {
    if (this._dropdownValue == 'Hàng tuần')
      this._isWeekly = true;
    else
      _isWeekly = false;
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Lặp lại',
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DialogMenu(
              listDropdownItems: _listDropdownItems,
              dropdownValue: _dropdownValue,
              listUnit: _listUnit,
              getDropDownButtonValue: (value) => setState(() {
                this._dropdownValue = value;
                showWeekly();
              }),
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(visible: _isWeekly, child: DialogDatePicker()),
          ],
        ),
      ),
      edited: () {
        int index = _listDropdownItems.indexOf(_dropdownValue);
        String unitGoal = _listUnit[index];
        this.widget.getUnit(unitGoal);
        this.widget.getRepeat(this._repeat);
      },
    );
  }
}
