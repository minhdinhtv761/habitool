import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/widgets/custom_dialog.dart';

import '../../../custom_values/custom_colors.dart';
import '../../../custom_values/custom_type.dart';
import '../../../custom_values/custom_type.dart';
import '../../../custom_values/custom_type.dart';

class RepetitionDialog extends StatefulWidget {
  RepetitionDialog({
    Key key,
    this.callback,
  }) : super(key: key);
  BoolCallBack callback;

  @override
  _RepetitionDialogState createState() => _RepetitionDialogState();
}

class _RepetitionDialogState extends State<RepetitionDialog> {
  List<String> _listDropdownItems = [
    'Không',
    'Hàng ngày',
    'Hàng tuần',
    'Hàng tháng',
    'Hàng năm',
  ];

  String _dropdownValue = 'Không';
  bool _isNull = true;
  String _unit;

  void getDropdownItem() {
    this._isNull = false;
    switch (_dropdownValue) {
      case 'Không':
        this._isNull = true;
        break;
      case 'Hàng ngày':
        this._unit = 'ngày';
        break;
      case 'Hàng tháng':
        this._unit = 'tháng';
        break;
      case 'Hàng năm':
        this._unit = 'năm';
        break;
      default:
        this._unit = 'phút';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Lặp lại',
      listDropdownItems: _listDropdownItems,
      dropdownValue: _dropdownValue,
      callback: (value) => setState(() {
        this._dropdownValue = value;
        this.getDropdownItem();
        this.widget.callback(!_isNull);
      }),
      value: Visibility(
        visible: !_isNull,
        child: Row(
          children: [
            Spacer(
              flex: 1,
            ),
            Text(
              'Mỗi',
              style: TextStyle(
                fontSize: 16,
                color: CustomColors.black,
              ),
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
