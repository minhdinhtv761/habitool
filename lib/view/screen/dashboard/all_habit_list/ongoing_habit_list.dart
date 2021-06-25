import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/widgets/habit_slidable.dart';

class OnGoingHabit extends StatefulWidget {
  const OnGoingHabit({Key key}) : super(key: key);

  @override
  _OnGoingHabitState createState() => _OnGoingHabitState();
}

class _OnGoingHabitState extends State<OnGoingHabit> {
  List<Widget> _onGoingHabitList = [
    Center(
      child: Text(
        'Đang thực hiện',
        style: TextStyle(
          color: CustomColors.darkgrey,
          fontSize: 13.0,
        ),
      ),
    ),
    HabitSlidable(
      habitTileType: HabitTileType.general,
      name: "Habit's name",
      time: DateTime.now(),
      goal: 5,
      goalCompleted: 3,
      unitGoal: 'ly',
      habitStatus: HabitStatus.doing,
      isImportant: false,
      startDate: DateTime(2021, 6, 1),
      endDate: DateTime(2021, 7, 1),
    ),
    HabitSlidable(
      habitTileType: HabitTileType.general,
      name: "Habit's name",
      time: DateTime.now(),
      goal: 5,
      goalCompleted: 3,
      unitGoal: 'ly',
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
          if (_onGoingHabitList.length == 1) {
            return null;
          } else {
            if (index.isOdd) {
              return this._onGoingHabitList[index ~/ 2];
            } else {
              return SizedBox(height: 10.0);
            }
          }
        },
        childCount: this._onGoingHabitList.length * 2 + 1,
      ),
    );
  }
}
