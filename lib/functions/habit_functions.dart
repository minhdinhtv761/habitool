import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/services/habit_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habitool/view/screen/modify_habit/main_screen.dart';
import 'package:habitool/widgets/habit_slidable.dart';

import 'package:provider/provider.dart';

class HabitFunctions {
  static String covertIconDataToString(IconData iconData) {
    String result = iconData.toString();
    if ((result != null) && (result.length > 0)) {
      result = result.substring(0, result.length - 1);
    }
    result = result.replaceAll('IconData(', '');
    return result;
  }

  static DateTime convertToDateTime(Timestamp time) {
    return DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
  }

  static void handelHabitSelectedOption(
    HabitModel habitModel,
    HabitSelectedOption opt,
  ) {
    switch (opt) {
      case HabitSelectedOption.EDIT:
        break;
      default:
    }
  }

  static editHabit(HabitModel _habitModel, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ModifyHabitScreen(_habitModel)),
    );
  }

  static Future<void> addHabit(HabitModel _habitModel) {
    return HabitServices.addHabitData(_habitModel);
  }

  static void createHabitRecords(HabitModel habitModel) {
    DateTime date = habitModel.startDate;
    Duration duration = Duration(days: 1);
    while (date.isBefore(habitModel.endDate.add(Duration(days: 1)))) {
      HabitServices.addHabitRecordData(
          habitModel.habitId, date, date.weekday, habitModel.goal);
      date = date.add(duration);
    }
  }

  static List<Widget> buildListWidgetFromModel(
      List<Widget> listWidget, List<HabitModel> habitModelList) {
    List<Widget> _list = listWidget;
    habitModelList.forEach((habit) {
      _list.add(HabitSlidable(
          habitTileType: HabitTileType.general,
          name: habit.name,
          icon: habit.icon,
          time: habit.time,
          unitGoal: habit.unitGoal,
          goal: habit.goal,
          isImportant: habit.isImportant,
          startDate: habit.startDate,
          endDate: habit.endDate));
    });
    return _list;
  }
}
