import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/widgets/habit_slidable.dart';

import '../habit_list.dart';

class FutureHabit extends StatefulWidget {
  final DateTime date;
  FutureHabit(this.date);

  @override
  _FutureHabitState createState() => _FutureHabitState();
}

class _FutureHabitState extends State<FutureHabit> {
  // List<Widget> _doingHabitList = [
  //   Center(
  //     child: Text(
  //       'Chưa hoàn thành',
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
  //     habitStatus: HabitStatus.doing,
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
  //     habitStatus: HabitStatus.doing,
  //     isImportant: false,
  //     startDate: DateTime(2021, 6, 1),
  //     endDate: DateTime(2021, 7, 1),
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return HabitList(HabitTileType.general, HabitStatus.future,
        date: this.widget.date);
  }
  //   return SliverList(
  //     delegate: SliverChildBuilderDelegate(
  //       (context, index) {
  //         if (_doingHabitList.length == 1) {
  //           return null;
  //         } else {
  //           if (index.isOdd) {
  //             return this._doingHabitList[index ~/ 2];
  //           } else {
  //             return SizedBox(height: 10.0);
  //           }
  //         }
  //       },
  //       childCount: this._doingHabitList.length * 2 + 1,
  //     ),
  //   );
  // }
}
