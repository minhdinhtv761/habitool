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
    @required this.habitName,
    @required this.habitTime,
    @required this.goalUnit,
    @required this.goal,
    @required this.isImportant,
    @required this.startDate,
    @required this.endDate,
    @required this.repeat,
    @required this.note,
  });

  String habitName;
  DateTime habitTime;
  String goalUnit;
  int goal;
  bool isImportant;
  DateTime startDate;
  DateTime endDate;
  String repeat;
  String note;

  @override
  _HabitInfo createState() => _HabitInfo();
}

class _HabitInfo extends State<HabitInfo> {
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

    List<BodyMenu> listBasicInfo = [startDate, goal, repetition, endDate];

    BodyMenu time = BodyMenu(
      icon: FontAwesomeIcons.clock,
      title: 'Thời gian thực hiện',
      content: '${selectedDate.hour}:${selectedDate.minute}',
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
