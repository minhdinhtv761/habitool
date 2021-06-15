import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/view/screen/new_habit/goal_dialog.dart';

import 'package:habitool/view/screen/new_habit/repetition_dialog.dart';
import 'package:habitool/widgets/habit_notebox.dart';
import 'package:habitool/widgets/custom_card.dart';
import 'package:habitool/widgets/habit_namebox.dart';
import 'package:habitool/widgets/time_picker.dart';

import 'body_menu.dart';
import 'date_picker.dart';

class HabitInfo extends StatefulWidget {
  HabitInfo({
    Key key,
    this.habitName,
    this.time,
    this.goalUnit,
    this.goal,
    this.isImportant,
    this.startDate,
    this.endDate,
    this.repeat,
    this.note,
  });

  String habitName;
  String time;
  String goalUnit;
  String goal;
  bool isImportant;
  String startDate;
  String endDate;
  String repeat;
  String note;

  @override
  _HabitInfo createState() => _HabitInfo();
}

class _HabitInfo extends State<HabitInfo> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    BodyMenu startDate = BodyMenu(
      icon: Icons.calendar_today,
      title: 'Bắt đầu',
      content: this.widget.startDate,
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
      content: this.widget.goal,
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
      content: this.widget.repeat,
      press: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => RepetitionDialog(),
        );
      },
    );
    
    BodyMenu endDate = BodyMenu(
      title: 'Kết thúc lặp',
      content: this.widget.endDate,
      press: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => DatePicker(),
        );
      },
    );

    List<BodyMenu> listBasicInfo = [startDate, goal, repetition, endDate];

    BodyMenu time = BodyMenu(
      icon: FontAwesomeIcons.clock,
      title: 'Thời gian thực hiện',
      content: this.widget.time,
      press: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => TimePicker(),
        );
      },
    );

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
          NameBox(
            habitName: this.widget.habitName,
            isImportant: this.widget.isImportant,
          ),
          CustomCard(
            child: Column(
              children: getMenuBasicInfo(),
            ),
          ),
          CustomCard(
            child: time,
          ),
          NoteBox(note: this.widget.note),
        ],
      ),
    );
  }
}
