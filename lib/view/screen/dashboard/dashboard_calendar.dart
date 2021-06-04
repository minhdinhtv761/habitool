import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardCalendar extends StatefulWidget {
  DashboardCalendar({Key key, this.callback}) : super(key: key);

  DateTimeCallback callback;

  @override
  _DashboardCalendarState createState() => _DashboardCalendarState();
}

class _DashboardCalendarState extends State<DashboardCalendar> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(1900, 1, 1),
      lastDay: DateTime.utc(2200, 12, 31),
      focusedDay: this._focusedDate,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarFormat: CalendarFormat.week,
      weekendDays: [],
      headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          headerPadding: EdgeInsets.symmetric(vertical: 0.0),
          titleTextStyle: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            color: CustomColors.black,
          ),
          leftChevronIcon: const Icon(
            Icons.chevron_left_rounded,
            size: 25.0,
          ),
          rightChevronIcon: const Icon(
            Icons.chevron_right_rounded,
            size: 25.0,
          )),
      daysOfWeekHeight: 20.0,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
          color: CustomColors.black,
        ),
        weekendStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
          color: CustomColors.black,
        ),
      ),
      rowHeight: 40.0,
      calendarStyle: CalendarStyle(
        outsideTextStyle: TextStyle(
          color: CustomColors.grey,
          fontFamily: 'Roboto',
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
        defaultTextStyle: TextStyle(
          color: CustomColors.black,
          fontFamily: 'Roboto',
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
        selectedTextStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
        selectedDecoration: BoxDecoration(
          color: CustomColors.pink,
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(
          color: this._selectedDate == DateTime.now()
              ? Colors.white
              : CustomColors.black,
          fontFamily: 'Roboto',
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
        todayDecoration: BoxDecoration(
            color: this._selectedDate == DateTime.now()
                ? Colors.pink
                : Colors.white,
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
                BorderSide(color: CustomColors.pink, width: 2.0))),
      ),
      selectedDayPredicate: (day) {
        return isSameDay(this._selectedDate, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          this._selectedDate = selectedDay;
          this._focusedDate = focusedDay;
          this.widget.callback(selectedDay);
        });
      },
    );
  }
}
