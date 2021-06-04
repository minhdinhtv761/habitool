import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/widgets/habit_slidable.dart';

class CanceledHabit extends StatefulWidget {
  const CanceledHabit({Key key}) : super(key: key);

  @override
  _CanceledHabitState createState() => _CanceledHabitState();
}

class _CanceledHabitState extends State<CanceledHabit> {
  List<Widget> _canceledHabitList = [
    Center(
      child: Text(
        'Đã hủy',
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
          if (_canceledHabitList.length == 1) {
            return null;
          } else {
            if (index.isOdd) {
              return this._canceledHabitList[index ~/ 2];
            } else {
              return SizedBox(height: 10.0);
            }
          }
        },
        childCount: this._canceledHabitList.length * 2 + 1,
      ),
    );
  }
}
