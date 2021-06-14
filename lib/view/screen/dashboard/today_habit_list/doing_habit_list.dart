import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/widgets/habit_slidable.dart';

class DoingHabit extends StatefulWidget {
  const DoingHabit({Key key}) : super(key: key);

  @override
  _DoingHabitState createState() => _DoingHabitState();
}

class _DoingHabitState extends State<DoingHabit> {
  List<Widget> _doingHabitList = [
    Center(
      child: Text(
        'Chưa hoàn thành',
        style: TextStyle(
          color: CustomColors.darkgrey,
          fontSize: 13.0,
        ),
      ),
    ),
    HabitSlidable(
      habitTileType: HabitTileType.dailyProgress,
      habitName: "Habit's name",
      habitTime: DateTime.now(),
      goal: 5,
      goalCompleted: 3,
      goalUnit: 'ly',
      habitStatus: HabitStatus.doing,
      isImportant: false,
      startDate: DateTime(2021, 6, 1),
      endDate: DateTime(2021, 7, 1),
    ),
    HabitSlidable(
      habitTileType: HabitTileType.dailyProgress,
      habitName: "Habit's name",
      habitTime: DateTime.now(),
      goal: 5,
      goalCompleted: 3,
      goalUnit: 'ly',
      habitStatus: HabitStatus.doing,
      isImportant: false,
      startDate: DateTime(2021, 6, 1),
      endDate: DateTime(2021, 7, 1),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (_doingHabitList.length == 1) {
            return null;
          } else {
            if (index.isOdd) {
              return this._doingHabitList[index ~/ 2];
            } else {
              return SizedBox(height: 10.0);
            }
          }
        },
        childCount: this._doingHabitList.length * 2 + 1,
      ),
    );
  }
}