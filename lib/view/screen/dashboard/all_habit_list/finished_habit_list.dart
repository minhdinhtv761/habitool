import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/view/screen/dashboard/habit_list.dart';
import 'package:habitool/widgets/habit_slidable.dart';

class FinishedHabit extends StatefulWidget {
  final DateTime date;
  FinishedHabit(this.date);
  @override
  _FinishedHabitState createState() => _FinishedHabitState();
}

class _FinishedHabitState extends State<FinishedHabit> {
  // List<Widget> _canceledHabitList = [
  //   Center(
  //     child: Text(
  //       'Đã hủy',
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
  //     habitStatus: HabitStatus.canceled,
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
  //     habitStatus: HabitStatus.canceled,
  //     isImportant: false,
  //     startDate: DateTime(2021, 6, 1),
  //     endDate: DateTime(2021, 7, 1),
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return HabitList(
      HabitTileType.general,
      HabitStatus.done,
      date: this.widget.date,
    );
  }
  //   return SliverList(
  //     delegate: SliverChildBuilderDelegate(
  //       (context, index) {
  //         if (_canceledHabitList.length == 1) {
  //           return null;
  //         } else {
  //           if (index.isOdd) {
  //             return this._canceledHabitList[index ~/ 2];
  //           } else {
  //             return SizedBox(height: 10.0);
  //           }
  //         }
  //       },
  //       childCount: this._canceledHabitList.length * 2 + 1,
  //     ),
  //   );
  // }
}
