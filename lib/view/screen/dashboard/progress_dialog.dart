import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/functions/dashboard_function.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/services/habit_services.dart';
import 'package:habitool/view/screen/dashboard/dashboard_screen.dart';
import 'package:habitool/view/screen/new_habit/widgets/dialog_menu.dart';
import 'package:habitool/widgets/custom_dialog.dart';
import 'package:habitool/widgets/custom_textfield.dart';
import 'package:habitool/widgets/message_box.dart';

import 'package:provider/provider.dart';
import '../../../custom_values/custom_colors.dart';

class ProgressDialog extends StatefulWidget {
  HabitModel habitModel;
  int completed;
  DateTime date;
  ProgressDialog({this.habitModel, this.completed, this.date});

  @override
  _ProgressDialogState createState() => _ProgressDialogState();
}

class _ProgressDialogState extends State<ProgressDialog> {
  String newCompleted;

  @override
  Widget build(BuildContext context) {
    HabitServices habitService =
        Provider.of<HabitServices>(context, listen: false);

    return CustomDialog(
        title: 'Mục tiêu',
        content: Row(
          children: [
            Spacer(
              flex: 1,
            ),
            Expanded(
              child: CustomTextField(
                typeInput: TextInputType.number,
                textAlign: TextAlign.center,
                hintText: this.widget.completed.toString(),
                getText: (text) {
                  this.newCompleted = text;
                },
              ),
            ),
            Expanded(
              child: Text(
                this.widget.habitModel.unitGoal,
                style: TextStyle(
                    color: CustomColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
        edited: () {
          if (newCompleted != null) {
            if (int.parse(newCompleted) > this.widget.habitModel.goal ||
                int.parse(newCompleted) <= 0) {
              showGeneralDialog(
                context: context,
                pageBuilder: (_, __, ___) => MessageBox.erroInputProgress(),
              );
            } else if (int.parse(newCompleted) == this.widget.habitModel.goal)
              DashboardFunction.handelHabitSelectedOption(
                  this.widget.habitModel, HabitSelectedOption.CHECK, context,
                  date: this.widget.date, completed: this.widget.completed);
            else {
              DashboardFunction.handelHabitSelectedOption(
                  this.widget.habitModel, HabitSelectedOption.PROGRESS, context,
                  date: this.widget.date,
                  completed: this.widget.completed,
                  newCompleted: int.parse(newCompleted));
            }
          }
        });
  }
}
