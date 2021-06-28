import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/widgets/habit_slidable.dart';

import '../habit_list.dart';

class GoingHabit extends StatefulWidget {
  const GoingHabit({Key key}) : super(key: key);

  @override
  _GoingHabitState createState() => _GoingHabitState();
}

class _GoingHabitState extends State<GoingHabit> {
  // List<Widget> _doneHabitList = [
  //   Center(
  //     child: Text(
  //       'Đã hoàn thành',
  //       style: TextStyle(
  //         color: CustomColors.darkgrey,
  //         fontSize: 13.0,
  //       ),
  //     ),
  //   ),
  //   HabitSlidable(
  //     habitTileType: HabitTileType.dailyProgress,
  //     name: "Habit's name",
  //     time: DateTime.now(),
  //     goal: 5,
  //     goalCompleted: 3,
  //     unitGoal: 'ly',
  //     habitStatus: HabitStatus.done,
  //     isImportant: false,
  //     startDate: DateTime(2021, 6, 1),
  //     endDate: DateTime(2021, 7, 1),
  //   ),
  //   HabitSlidable(
  //     habitTileType: HabitTileType.dailyProgress,
  //     name: "Habit's name",
  //     time: DateTime.now(),
  //     goal: 5,
  //     goalCompleted: 3,
  //     unitGoal: 'ly',
  //     habitStatus: HabitStatus.done,
  //     isImportant: false,
  //     startDate: DateTime(2021, 6, 1),
  //     endDate: DateTime(2021, 7, 1),
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    //   return SliverList(
    return HabitList(HabitTileType.general, HabitStatus.doing);
  }
  //     delegate: SliverChildBuilderDelegate(
  //       (context, index) {
  //         if (_doneHabitList.length == 1) {
  //           return null;
  //         } else {
  //           if (index.isOdd) {
  //             return this._doneHabitList[index ~/ 2];
  //           } else {
  //             return SizedBox(height: 10.0);
  //           }
  //         }
  //       },
  //       childCount: this._doneHabitList.length * 2 + 1,
  //     ),
  //   );
  // }
}
