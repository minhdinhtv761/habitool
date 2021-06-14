import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/widgets/habit_slidable.dart';

class InFutureHabit extends StatefulWidget {
  const InFutureHabit({Key key}) : super(key: key);

  @override
  _InFutureHabitState createState() => _InFutureHabitState();
}

class _InFutureHabitState extends State<InFutureHabit> {
  List<Widget> _inFutureHabitList = [
    Center(
      child: Text(
        'Sắp thực hiện',
        style: TextStyle(
          color: CustomColors.darkgrey,
          fontSize: 13.0,
        ),
      ),
    ),
    HabitSlidable(
      habitTileType: HabitTileType.general,
      habitName: "Habit's name",
      habitTime: DateTime.now(),
      goal: 5,
      goalCompleted: 3,
      goalUnit: 'ly',
      habitStatus: HabitStatus.doing,
      isImportant: false,
      startDate: DateTime(2021, 7, 1),
      endDate: DateTime(2021, 8, 1),
    ),
    HabitSlidable(
      habitTileType: HabitTileType.general,
      habitName: "Habit's name",
      habitTime: DateTime.now(),
      goal: 5,
      goalCompleted: 3,
      goalUnit: 'ly',
      habitStatus: HabitStatus.doing,
      isImportant: false,
      startDate: DateTime(2021, 7, 1),
      endDate: DateTime(2021, 8, 1),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (_inFutureHabitList.length == 1) {
            return null;
          } else {
            if (index.isOdd) {
              return this._inFutureHabitList[index ~/ 2];
            } else {
              return SizedBox(height: 10.0);
            }
          }
        },
        childCount: this._inFutureHabitList.length * 2 + 1,
      ),
    );
  }
}
