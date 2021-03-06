import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/model/habitrecord_model.dart';
import 'package:habitool/services/habit_services.dart';
import 'package:habitool/widgets/habit_slidable.dart';

import 'package:provider/provider.dart';

class HabitFunctions {
  Future<void> addHabit(HabitModel habitModel, BuildContext context) {
    HabitServices habitServices =
        Provider.of<HabitServices>(context, listen: false);
    return habitServices.addHabitData(habitModel, context);
  }

  Future<void> updateHabit(
      HabitModel newHabit, HabitModel oldHabit, BuildContext context) {
    HabitServices habitServices =
        Provider.of<HabitServices>(context, listen: false);

    DateTime now = DateTime.now();
    DateTime dateNow = DateTime(now.year, now.month, now.day);

    if (newHabit.startDate.isAfter(dateNow)) {
      return habitServices.updateStartDateIsAfter(newHabit, context);
    }
    return habitServices.updateStartDateIsBefore(newHabit, oldHabit, context);
  }

  static List<Widget> buildGeneralListWidget(List<Widget> listWidget,
      List<HabitModel> habitModelList, HabitStatus status, DateTime date) {
    List<Widget> _list = listWidget;
    habitModelList.forEach((habit) {
      _list.add(HabitSlidable(
        habitTileType: HabitTileType.general,
        habitModel: habit,
        habitStatus: status,
        date: date,
      ));
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
        //nếu thói quen có ngày trùng ngày yêu cầu
        if (habitRecord.date.isAtSameMomentAs(_date)) {
          int completed = habitRecord.completed;
          _list.add(HabitSlidable(
            habitTileType: HabitTileType.dailyProgress,
            habitModel: habitModel,
            habitStatus: status,
            goalCompleted: completed,
            date: date,
          ));
        }
      });
    });
    return _list;
  }

  static bool getOnGoingHabit(DateTime startDate, DateTime endDate) {
    DateTime now = DateTime.now();
    if (startDate.isAfter(now))
      return false;
    else if (endDate.isBefore(now)) return false;
    return true;
  }

  static List<HabitModel> getRecommendHabits() => <HabitModel>[
        HabitModel(
            name: 'Tập thể dục',
            isImportant: false,
            icon: Icons.fitness_center,
            goal: 30,
            unitGoal: 'phút',
            startDate: DateTime.now(),
            endDate: DateTime.now().add(Duration(days: 30)),
            repeat: [1, 2, 3, 4, 5, 6, 7],
            time: DateTime(1, 1, 1, 8, 0),
            notif: true,
            note: 'Vì đẹp và khỏe'),
        HabitModel(
            name: 'Uống nước',
            isImportant: true,
            icon: Icons.local_drink,
            goal: 5,
            unitGoal: 'ly',
            startDate: DateTime.now(),
            endDate: DateTime.now().add(Duration(days: 30)),
            repeat: [1, 2, 3, 4, 5, 6, 7],
            time: DateTime(1, 1, 1, 8, 0),
            notif: false,
            note: 'Vì sức khỏe'),
        HabitModel(
            name: 'Đọc sách',
            isImportant: false,
            icon: Icons.book,
            goal: 30,
            unitGoal: 'phút',
            startDate: DateTime.now(),
            endDate: DateTime.now().add(Duration(days: 30)),
            repeat: [1, 2, 3, 4, 5, 6, 7],
            time: DateTime(1, 1, 1, 8, 0),
            notif: false,
            note: 'Bổ sung kiến thức'),
        HabitModel(
            name: 'Viết nhật ký',
            isImportant: false,
            icon: Icons.drive_file_rename_outline,
            goal: 15,
            unitGoal: 'phút',
            startDate: DateTime.now(),
            endDate: DateTime.now().add(Duration(days: 30)),
            repeat: [1, 2, 3, 4, 5, 6, 7],
            time: DateTime(1, 1, 1, 8, 0),
            notif: false,
            note: ''),
      ];

  ///Convert List<bool> to List<int>
  static List<int> convertToIntList(List<bool> listSelected) {
    List<int> _list = [];
    int index = 0;
    for (bool data in listSelected) {
      if (data) {
        _list.add(index + 1);
      } else {
        _list.add(0);
      }
      index++;
    }

    return _list;
  }

//Convert List<int> to bool
  static List<bool> convertToBoolList(List<int> repeat) {
    List<bool> _list = [];
    repeat.forEach((data) {
      if (data != 0) {
        _list.add(true);
      } else {
        _list.add(false);
      }
    });

    return _list;
  }

  //Convert List<int> to list<string>
  static List<String> convertToStringList(List<int> repeat) {
    List<String> _list = [];
    repeat.forEach((data) {
      if (data != 0) _list.add(getWeekday(data));
    });
    return _list;
  }

  static String getWeekday(int data) {
    switch (data) {
      case 1:
        return ('T2');
        break;
      case 2:
        return ('T3');
        break;
      case 3:
        return ('T4');
        break;
      case 4:
        return ('T5');
        break;
      case 5:
        return ('T6');
        break;
      case 6:
        return ('T7');
        break;
      default:
        return ('CN');
        break;
    }
  }
}
