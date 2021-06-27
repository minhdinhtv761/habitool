import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/model/habitrecord_model.dart';
import 'package:habitool/services/habit_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habitool/view/screen/modify_habit/main_screen.dart';
import 'package:habitool/widgets/habit_slidable.dart';

import 'package:provider/provider.dart';

class HabitFunctions {
  static Future<void> getAllHabit(HabitServices habitServices) async {
    habitServices.getFinishedHabitFromFirebase();
    habitServices.getFutureHabitFromFirebase();
    habitServices.getGoingHabitFromFirebase();
    habitServices.getTodayHabitFromFirebase();
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

  static Future<void> addHabit(HabitModel habitModel) {
    return HabitServices.addHabitData(habitModel);
  }

  static void createHabitRecords(HabitModel habitModel) {
    DateTime date = habitModel.startDate;
    Duration duration = Duration(days: 1);
    while (date.isBefore(habitModel.endDate.add(Duration(days: 1)))) {
      HabitServices.addHabitRecordData(habitModel, date, 0);
      date = date.add(duration);
    }
  }

  static List<Widget> buildGeneralListWidget(
      List<Widget> listWidget, List<HabitModel> habitModelList) {
    print('build general ${habitModelList.length}');
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

  static List<Widget> buildDailyListWidget(List<Widget> listWidget,
      List<HabitModel> habitModelList, DateTime date, HabitStatus status) {
    List<Widget> _list = listWidget;
    //lấy giá trị ngày
    DateTime _date = DateTime(date.year, date.month, date.day);
    habitModelList.forEach((habitModel) {
      //tìm thói quen trong ngày
      habitModel.habitRecords.forEach((habitRecord) {
        print(habitRecord.date);
        //nếu thói quen có ngày trùng ngày yêu cầu
        if (habitRecord.date.isAtSameMomentAs(_date)) {
          int completed = habitRecord.completed;
          _list.add(HabitSlidable(
            habitTileType: HabitTileType.dailyProgress,
            name: habitModel.name,
            icon: habitModel.icon,
            time: habitModel.time,
            unitGoal: habitModel.unitGoal,
            goal: habitModel.goal,
            isImportant: habitModel.isImportant,
            startDate: habitModel.startDate,
            endDate: habitModel.endDate,
            habitStatus: status,
            goalCompleted: completed,
          ));
        }
      });
    });
    return _list;
  }

  // static HabitStatus getHabitStatus(int completed, int goal) {
  //   if (completed == -1)
  //     return HabitStatus.canceled;
  //   else if (completed == goal) return HabitStatus.done;
  //   return HabitStatus.doing;
  // }

  static bool getOnGoingHabit(DateTime startDate, DateTime endDate) {
    DateTime now = DateTime.now();
    if (startDate.isAfter(now))
      return false;
    else if (endDate.isBefore(now)) return false;
    return true;
  }
}
