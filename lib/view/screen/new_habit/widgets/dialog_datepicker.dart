import 'package:flutter/cupertino.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/widgets/custom_datepicker_button.dart';

class DialogDatePicker extends StatefulWidget {
  List<bool> repeat;
  ListBoolCallback getListRepeat;
  DialogDatePicker({this.repeat, this.getListRepeat});
  @override
  _DialogDatePickerState createState() => _DialogDatePickerState(this.repeat);
}

class _DialogDatePickerState extends State<DialogDatePicker> {
  List<bool> selectedDate;
  _DialogDatePickerState(this.selectedDate);
  //
  //
  List<String> _dateList = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
  //
  //
  List<Widget> _buildRowList() {
    List<Widget> list = List();
    for (var date in _dateList) {
      int index = _dateList.indexOf(date);
      list.add(Expanded(
          child: CustomDatePickerButton(
        text: date,
        selected: selectedDate[index],
        onSelected: (value) {
          selectedDate[index] = value;
          this.widget.getListRepeat(selectedDate);
        },
      )));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildRowList(),
    );
  }
}
