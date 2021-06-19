import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../custom_values/custom_colors.dart';

class DatePicker extends StatefulWidget {
  String dateOfBirth;
  Function(String) edited;
  DatePicker({
    Key key,this.dateOfBirth,this.edited
  }) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  // AnimationController controller;
  // Animation<double> scaleAnimation;

  // @override
  // void initState() {
  //   super.initState();

  //   controller =
  //       AnimationController(vsync: this, duration: Duration(milliseconds: 450));
  //   scaleAnimation =
  //       CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

  //   controller.addListener(() {
  //     setState(() {});
  //   });

  //   controller.forward();
  // }

  // TextEditingController _dateController = TextEditingController();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _dateController.text = widget.dateOfBirth;
  // }

  DateTime date;

  String getText() {
    DateTime date = DateTime.parse("");
    date.toString();

    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('MM/dd/yyyy').format(date);
    }
  }

  DateRangePickerController _datePickerController = DateRangePickerController();

  final TextStyle _textStyleCurrentDate = new TextStyle(
    color: CustomColors.black,
    fontWeight: FontWeight.bold,
  );

  final TextStyle _textStyleTodayDate = new TextStyle(
    color: CustomColors.pink,
    fontWeight: FontWeight.bold,
  );
  final TextStyle _textStyleLeadTrailDate = new TextStyle(
    color: CustomColors.grey,
    fontWeight: FontWeight.bold,
  );
  final BoxDecoration _boxDecorationToday = new BoxDecoration(
    border: Border.all(
      color: CustomColors.pink,
    ),
    shape: BoxShape.circle,
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        margin: const EdgeInsets.fromLTRB(50, 150, 50, 150),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SfDateRangePicker(
            view: DateRangePickerView.month,
            showActionButtons: true,
            cancelText: 'CANCEl',
            confirmText: 'OK',
            onSubmit: (context) {},
            onCancel: () => Navigator.pop(context, 'Cancel'),
            controller: _datePickerController,
            navigationDirection: DateRangePickerNavigationDirection.horizontal,
            showNavigationArrow: true,
            selectionMode: DateRangePickerSelectionMode.single,
            selectionColor: CustomColors.pink,
            selectionTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            headerStyle: DateRangePickerHeaderStyle(
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                fontSize: 18,
                color: CustomColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            monthViewSettings: DateRangePickerMonthViewSettings(
              firstDayOfWeek: 1,
              dayFormat: 'EEE',
              showTrailingAndLeadingDates: true,
              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  textStyle: _textStyleCurrentDate),
            ),
            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: _textStyleCurrentDate,
              todayTextStyle: _textStyleTodayDate,
              todayCellDecoration: _boxDecorationToday,
              leadingDatesTextStyle: _textStyleLeadTrailDate,
              trailingDatesTextStyle: _textStyleLeadTrailDate,
            ),
            yearCellStyle: DateRangePickerYearCellStyle(
              todayTextStyle: _textStyleTodayDate,
              // todayCellDecoration: BoxDecoration(
              //   border: Border.all(
              //     color: CustomColors.pink,
              //   ),
              //   shape: BoxShape.circle,
              // ),
            ),
          ),
        ),
      ),
    );
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;

    setState(() => date = newDate);
  }
}
