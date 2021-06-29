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

  Future<void> updateHabit(HabitModel habitModel, BuildContext context) {
    HabitServices habitServices =
        Provider.of<HabitServices>(context, listen: false);

    print('vào update');
    DateTime now = DateTime.now();
    DateTime dateNow = DateTime(now.year, now.month, now.day);

    if (habitModel.startDate.isAfter(dateNow.subtract(Duration(seconds: 5)))) {
      print('sửa ngày bắt đầu sau ngày hiện tại');

      return habitServices.updateStartDateIsAfter(habitModel, context);
    }
  }

  void createHabitRecords(HabitModel habitModel, BuildContext context) {
    HabitServices habitServices =
        Provider.of<HabitServices>(context, listen: false);
    DateTime date = habitModel.startDate;
    Duration duration = Duration(days: 1);
    while (date.isBefore(habitModel.endDate.add(Duration(days: 1)))) {
      habitServices.addHabitRecordData(habitModel, date, 0, 0);
      date = date.add(duration);
    }
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
            note: ''),
      ];
}
