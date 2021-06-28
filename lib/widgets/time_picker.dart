import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/widgets/custom_dialog.dart';

class TimePicker extends StatefulWidget {
  TimePicker({
    this.dateTimeCallback,
  });
  DateTimeCallback dateTimeCallback;
  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: CustomDialog(
        // margin: const EdgeInsets.fromLTRB(50, 300, 50, 150),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(20),
        // ),
        title: 'Thời gian thực hiện',
        content: SizedBox(
          height: size.height * 0.2,
          child: CupertinoTheme(
            data: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: TextStyle(color: CustomColors.pink),
              ),
            ),
            child: CupertinoDatePicker(
              initialDateTime: dateTime,
              mode: CupertinoDatePickerMode.time,
              // minuteInterval: 10,
              use24hFormat: true,
              onDateTimeChanged: (dateTime) {
                setState(() => this.dateTime = dateTime);
              },
            ),
          ),
        ),
        edited: () {
          this.widget.dateTimeCallback(this.dateTime);
        },
      ),
    );
  }
}
