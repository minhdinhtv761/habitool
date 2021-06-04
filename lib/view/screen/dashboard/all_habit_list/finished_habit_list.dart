import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/widgets/habit_slidable.dart';

class FinishedHabit extends StatefulWidget {
  const FinishedHabit({Key key}) : super(key: key);

  @override
  _FinishedHabitState createState() => _FinishedHabitState();
}

class _FinishedHabitState extends State<FinishedHabit> {
  List<Widget> _finishedHabitList = [
    Center(
      child: Text(
        'Đã kết thúc',
        style: TextStyle(
          color: CustomColors.darkgrey,
          fontSize: 13.0,
        ),
      ),
    ),
    HabitSlidable(
      habitName: "Habit's name",
      habitTime: DateTime.now(),
      goal: 5,
      goalCompleted: 3,
      goalUnit: 'ly',
      habitStatus: HabitStatus.canceled,
      isImportant: false,
    ),
    HabitSlidable(
      habitName: "Habit's name",
      habitTime: DateTime.now(),
      goal: 5,
      goalCompleted: 3,
      goalUnit: 'ly',
      habitStatus: HabitStatus.canceled,
      isImportant: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (_finishedHabitList.length == 1) {
            return null;
          } else {
            if (index.isOdd) {
              return this._finishedHabitList[index ~/ 2];
            } else {
              return SizedBox(height: 10.0);
            }
          }
        },
        childCount: this._finishedHabitList.length * 2 + 1,
      ),
    );
  }
}
