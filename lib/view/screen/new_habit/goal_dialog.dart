import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/widgets/custom_dialog.dart';

import '../../../custom_values/custom_colors.dart';

class GoalDialog extends StatefulWidget {
  @override
  _GoalDialogState createState() => _GoalDialogState();
}

class _GoalDialogState extends State<GoalDialog> {
  List<String> _listDropdownItems = ['Không', 'Số lần', 'Tất cả'];
  String _dropdownValue = 'Không';
  bool _isNull = true;
  String _unit;

  void getDropdownItem() {
    this._isNull = false;
    switch (_dropdownValue) {
      case 'Không':
        this._isNull = true;
        break;
      case 'Số lần':
        this._unit = 'lần';
        break;
      default:
        this._unit = 'phút';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Mục tiêu',
      listDropdownItems: _listDropdownItems,
      dropdownValue: _dropdownValue,
      callback: (value) => setState(() {
        this._dropdownValue = value;
        this.getDropdownItem();
      }),
      value: Visibility(
        visible: !_isNull,
        child: Row(
          children: [
            Spacer(
              flex: 2,
            ),
            Expanded(
              child: TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                initialValue: '0',
                style: TextStyle(
                  color: CustomColors.pink,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: CustomColors.pink,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              '$_unit',
              style: TextStyle(
                fontSize: 16,
                color: CustomColors.black,
              ),
            )
          ],
        ),
      ),
      // showWeek: false,
    );
  }
}
