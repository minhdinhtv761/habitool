import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/functions/habit_functions.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/services/habit_services.dart';
import 'package:habitool/widgets/habit_slidable.dart';
import 'package:provider/provider.dart';

class FinishedHabit extends StatefulWidget {
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
  ];

  @override
  Widget build(BuildContext context) {
    HabitServices habitServices =
        Provider.of<HabitServices>(context, listen: false);
    _finishedHabitList = HabitFunctions.buildListWidgetFromModel(
        _finishedHabitList, habitServices.getFinishedHabitList().toList());

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          print(_finishedHabitList.length);
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
