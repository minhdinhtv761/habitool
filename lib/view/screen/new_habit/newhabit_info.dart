import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/view/screen/new_habit/goal_dialog.dart';

import 'package:habitool/view/screen/new_habit/repetition_dialog.dart';
import 'package:habitool/view/screen/new_habit/widgets/habit_notebox.dart';

import '../../../custom_values/custom_colors.dart';
import '../../../widgets/body_menu.dart';
import '../../../widgets/body_menu.dart';
import '../../../widgets/body_menu.dart';
import '../../../widgets/body_menu.dart';
import 'widgets/habit_namebox.dart';
import '../../../widgets/body_menu.dart';
import '../../../widgets/date_picker.dart';

class NewHabitInfo extends StatefulWidget {
  @override
  _NewHabitInfo createState() => _NewHabitInfo();
}

class _NewHabitInfo extends State<NewHabitInfo> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    DateTime selectedDate = DateTime.now();
    bool showEndDate = false;

    BodyMenu startDate = BodyMenu(
      icon: Icons.calendar_today,
      title: 'Bắt đầu',
      content: '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
      press: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => DatePicker(),
        );
      },
    );
    BodyMenu goal = BodyMenu(
      icon: FontAwesomeIcons.bullseye,
      title: 'Mục tiêu',
      content: 'Không',
      press: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => GoalDialog(),
        );
      },
    );
    BodyMenu repetition = BodyMenu(
      icon: Icons.cached_rounded,
      title: 'Lặp lại',
      content: 'Không',
      press: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => RepetitionDialog(),
        );
      },
    );
    BodyMenu endDate = BodyMenu(
      title: 'Kết thúc lặp',
      content: 'Không',
      press: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => DatePicker(),
        );
      },
    );
    BodyMenu time = BodyMenu(
      icon: FontAwesomeIcons.clock,
      title: 'Thời gian thực hiện',
      content: '${selectedDate.hour}:${selectedDate.minute}',
    );
    List<BodyMenu> listBasicInfo = [startDate, goal, repetition];

    List<Widget> getMenuBasicInfo() {
      List<Widget> list = List();
      for (var basicInfo in listBasicInfo) {
        list.add(basicInfo);
        if (listBasicInfo.indexOf(basicInfo) != listBasicInfo.length - 1)
          list.add(Divider(height: 1));
      }
      // if (showEndDate) {
      //   list.add(Divider(height: 1));
      //   list.add(endDate);
      // }
      return list;
    }

//List <Widget> basicInfo =
    return Material(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          NameBox(),
          Card(
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.only(top: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: getMenuBasicInfo(),
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.only(top: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: time,
          ),
          NoteBox(),
        ],
      ),
    );
  }
}
