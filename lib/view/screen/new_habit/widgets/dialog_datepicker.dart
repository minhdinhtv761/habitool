import 'package:flutter/cupertino.dart';
import 'package:habitool/widgets/custom_datepicker_button.dart';

class DialogDatePicker extends StatefulWidget {
  const DialogDatePicker({Key key}) : super(key: key);

  @override
  _DialogDatePickerState createState() => _DialogDatePickerState();
}

class _DialogDatePickerState extends State<DialogDatePicker> {
  List<String> _dateList = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
  List<Widget> _buildRowList() {
    List<Widget> list = List();
    for (var date in _dateList) {
      list.add(Expanded(child: CustomDatePickerButton(text: date)));
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
