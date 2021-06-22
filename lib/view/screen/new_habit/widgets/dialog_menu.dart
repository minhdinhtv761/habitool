import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/widgets/custom_dropdown_button.dart';
import 'package:habitool/widgets/custom_textfield.dart';

class DialogMenu extends StatefulWidget {
  DialogMenu({
    @required this.listDropdownItems,
    @required this.dropdownValue,
    @required this.listUnit,
    this.getDropDownButtonValue,
    this.getText,
  });

  List<String> listDropdownItems;
  String dropdownValue;
  List<String> listUnit;

  StringCallback getDropDownButtonValue;
  StringCallback getText;

  @override
  _DialogMenuState createState() => _DialogMenuState();
}

StringCallback callback;

class _DialogMenuState extends State<DialogMenu> {
  String _unitValue;
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CustomDropdownButton(
          listDropdownItems: this.widget.listDropdownItems,
          dropdownValue: this.widget.dropdownValue,
          callback: (value) => setState(() {
            this.widget.dropdownValue = value;
            this.widget.getDropDownButtonValue(value);
            int index = this.widget.listDropdownItems.indexOf(value);
            if (index != 0) {
              _isVisible = true;
              _unitValue = this.widget.listUnit[index];
            }
          }),
        ),
        Visibility(
          visible: _isVisible,
          child: Expanded(
            child: Row(
              children: [
                Spacer(
                  flex: 2,
                ),
                Expanded(
                  child: CustomTextField(
                    typeInput: TextInputType.number,
                    textAlign: TextAlign.center,
                    hintText: '0',
                    getText: (text) {
                      this.widget.getText(text);
                    },
                  ),
                ),
                Text(
                  '$_unitValue',
                  style: TextStyle(
                    fontSize: 16,
                    color: CustomColors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
