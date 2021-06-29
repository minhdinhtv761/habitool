import 'package:flutter/material.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/services/habit_services.dart';
import 'package:habitool/view/screen/modify_habit/main_screen.dart';
import 'package:habitool/widgets/message_box.dart';

import 'package:provider/provider.dart';

class DashboardFunction {
  static List<HabitModel> getListHabitModel(
      HabitServices habitService, HabitTileType type, HabitStatus status) {
    List<HabitModel> listHabitModel = [];

    bool isGeneral = (type == HabitTileType.general);
    switch (status) {
      case HabitStatus.future:
        listHabitModel = habitService.generalHabitListFuture.toList();
        break;
      case HabitStatus.done:
        listHabitModel = isGeneral
            ? habitService.generalHabitListFinished.toList()
            : habitService.todayHabitListDone.toList();
        break;
      case HabitStatus.doing:
        listHabitModel = isGeneral
            ? habitService.generalHabitListGoing
            : habitService.todayHabitListDoing.toList();
        break;
      default:
        listHabitModel = habitService.todayHabitListCancel.toList();
        break;
    }

    return listHabitModel;
  }

  static void handelHabitSelectedOption(
      HabitModel _habitModel, HabitSelectedOption opt, BuildContext context,
      {HabitTileType habitTileType,
      HabitStatus habitStatus,
      DateTime date,
      int completed}) {
    HabitServices habitServices =
        Provider.of<HabitServices>(context, listen: false);

    DateTime now = DateTime.now();
    DateTime dateNow = DateTime(now.year, now.month, now.day);

    switch (opt) {
      case HabitSelectedOption.EDIT:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ModifyHabitScreen(_habitModel, habitTileType, habitStatus)),
        );
        break;

      case HabitSelectedOption.DEL:
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => MessageBox.removeHabit(
            onSubmit: () {
              habitServices.removeHabit(
                  _habitModel, habitTileType, habitStatus, context);
            },
          ),
        );
        break;

      case HabitSelectedOption.CANCEL:
        if (date.isAtSameMomentAs(dateNow)) {
          habitServices.markAsCancelHabit(_habitModel, date, completed);
        } else {
          //cảnh báo thói quen không phải trong ngày
          showGeneralDialog(
            context: context,
            pageBuilder: (_, __, ___) => MessageBox.warningSelection(
              onSubmit: () {
                habitServices.markAsCancelHabit(_habitModel, date, completed);
              },
            ),
          );
        }

        break;

      case HabitSelectedOption.CHECK:
        if (date.isAtSameMomentAs(dateNow)) {
          habitServices.markAsDone(_habitModel, date, completed);
        } else {
          //cảnh báo thói quen không phải trong ngày
          showGeneralDialog(
            context: context,
            pageBuilder: (_, __, ___) => MessageBox.warningSelection(
              onSubmit: () {
                habitServices.markAsDone(_habitModel, date, completed);
              },
            ),
          );
        }
        break;

      case HabitSelectedOption.RESET:
        if (date.isAtSameMomentAs(dateNow)) {
          habitServices.markResetHabit(_habitModel, date);
        } else {
          //cảnh báo thói quen không phải trong ngày
          showGeneralDialog(
            context: context,
            pageBuilder: (_, __, ___) => MessageBox.warningSelection(
              onSubmit: () {
                habitServices.markResetHabit(_habitModel, date);
              },
            ),
          );
        }
        break;

      default:
        if (date.isAtSameMomentAs(dateNow)) {
          habitServices.markRefreshHabit(_habitModel, date, completed);
        } else {
          //cảnh báo thói quen không phải trong ngày
          showGeneralDialog(
            context: context,
            pageBuilder: (_, __, ___) => MessageBox.warningSelection(
              onSubmit: () {
                habitServices.markRefreshHabit(_habitModel, date, completed);
              },
            ),
          );
        }
    }
  }
}
