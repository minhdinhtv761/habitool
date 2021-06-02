import 'package:flutter/material.dart';

import 'package:habitool/custom_values/custom_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:habitool/widgets/habit_tile.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  List<Widget> _habitList = [
    HabitTile(),
    SizedBox(height: 10.0),
    HabitTile(),
    SizedBox(height: 10.0),
    HabitTile(),
    SizedBox(height: 10.0),
    HabitTile(),
    SizedBox(height: 10.0),
    HabitTile(),
    SizedBox(height: 10.0),
    HabitTile(),
    SizedBox(height: 10.0),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.light,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          buildSliverAppBar(size),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.075),
            sliver:
                SliverList(delegate: SliverChildListDelegate.fixed(_habitList)),
          ),

          // SliverToBoxAdapter(
          //   child: Container(
          //     height: 80.0,
          //     width: size.width * 0.85,
          //     child: HabitTile(),
          //   ),
          // ),

          // SliverToBoxAdapter dùng để làm phần trống, tránh việc dữ liệu bị che dưới BottomAppBar
          SliverToBoxAdapter(
              child: Container(height: 90.0, color: Colors.transparent)),
        ],
      ),
    );
  }

// Hàm build AppBar cho DashBoardScreen
  SliverAppBar buildSliverAppBar(Size size) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: false,
      toolbarHeight: 100.0,
      backgroundColor: CustomColors.blue,
      shadowColor: Colors.transparent,
      title: Row(children: <Widget>[
        Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
            color: CustomColors.grey,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Xin chào,',
              style: TextStyle(
                color: CustomColors.light,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'Your name',
              style: TextStyle(
                color: CustomColors.light,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ]),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          height: 100,
          decoration: BoxDecoration(
            color: CustomColors.blue,
          ),
        ),
      ),
      bottom: PreferredSize(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Container(
              height: 140.0,
              decoration: BoxDecoration(
                color: CustomColors.light,
              ),
            ),
            Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: CustomColors.blue,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30.0)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 10),
              width: size.width * 0.85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: buildTableCalendar(),
            ),
          ],
        ),
        preferredSize: Size.fromHeight(140.0),
      ),
    );
  }

  TableCalendar buildTableCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(1900, 1, 1),
      lastDay: DateTime.utc(2200, 12, 31),
      focusedDay: this._focusedDay,
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
          color: this._selectedDay == DateTime.now()
              ? Colors.white
              : CustomColors.black,
          fontFamily: 'Roboto',
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
        todayDecoration: BoxDecoration(
            color: this._selectedDay == DateTime.now()
                ? Colors.pink
                : Colors.white,
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
                BorderSide(color: CustomColors.pink, width: 2.0))),
      ),
      selectedDayPredicate: (day) {
        return isSameDay(this._selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          this._selectedDay = selectedDay;
          this._focusedDay = focusedDay;
        });
      },
    );
  }
}
