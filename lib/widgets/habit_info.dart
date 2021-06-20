import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/model/enums.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/view/screen/new_habit/goal_dialog.dart';

import 'package:habitool/view/screen/new_habit/repetition_dialog.dart';
import 'package:habitool/widgets/habit_notebox.dart';
import 'package:habitool/widgets/custom_card.dart';
import 'package:habitool/widgets/habit_namebox.dart';
import 'package:habitool/widgets/time_picker.dart';

import 'body_menu.dart';
import 'date_picker.dart';

class HabitInfo extends StatefulWidget {
  HabitInfo(this.mode, {this.habitModel});

  final HabitModelMode mode;
  HabitModel habitModel;

  @override
  _HabitInfo createState() => _HabitInfo();
}

DateTime dateTime = DateTime.now();

class _HabitInfo extends State<HabitInfo> {
  HabitModel _habitModel = HabitModel();
  bool edittingEnabled;

//Default value
  String _name = "";
  bool _isImportant = false;
  IconData _icon = Icons.ac_unit;
  int _goal = 0;
  String _unitGoal = 'lần';
  DateTime _startDate = dateTime;
  DateTime _endDate = dateTime;
  String _repeat = 'Hàng ngày';
  DateTime _time = dateTime;
  String _note = "";

  void initState() {
    super.initState();
    if (this.widget.mode == HabitModelMode.NEW) {
      edittingEnabled = true;
      createNewHabit();
    }
  }

  void createNewHabit() {
    _habitModel.name = _name;
    _habitModel.isImportant = _isImportant;
    _habitModel.icon = _icon;
    _habitModel.goal = _goal;
    _habitModel.unitGoal = _unitGoal;
    _habitModel.startDate = _startDate;
    _habitModel.endDate = _endDate;
    _habitModel.repeat = _repeat;
    _habitModel.time = _time;
    _habitModel.note = _note;
  }

  @override
  Widget build(BuildContext context) {
    BodyMenu startDate = BodyMenu(
      icon: Icons.calendar_today,
      title: 'Bắt đầu',
      content: '${_startDate.day}/${_startDate.month}/${_startDate.year}',
      press: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => DatePicker(
            callback: (value) {
              setState(() {
                _startDate = value;
              });
            },
          ),
        );
      },
    );

    BodyMenu goal = BodyMenu(
      icon: FontAwesomeIcons.bullseye,
      title: 'Mục tiêu',
      content: '${_goal.toString()} $_unitGoal',
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
      content: _habitModel.repeat,
      press: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => RepetitionDialog(),
        );
      },
    );

    BodyMenu endDate = BodyMenu(
      title: 'Kết thúc lặp',
      content: '${_endDate.day}/${_endDate.month}/${_endDate.year}',
      press: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => DatePicker(
            callback: (value) {
              setState(() {
                _endDate = value;
              });
            },
          ),
        );
      },
    );

    List<BodyMenu> listBasicInfo = [startDate, goal, repetition, endDate];

    BodyMenu time = BodyMenu(
      icon: FontAwesomeIcons.clock,
      title: 'Thời gian thực hiện',
      content: '${_time.hour}:${_time.minute}',
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
            enabled: edittingEnabled,
            icon: _icon,
            habitName: _name,
            isImportant: _isImportant,
            onValueChange: (text) => _name = text,
          ),
          CustomCard(
            child: Column(
              children: getMenuBasicInfo(),
            ),
          ),
          CustomCard(
            child: time,
          ),
          NoteBox(
            enabled: edittingEnabled,
            onValueChange: (text) => _note = text,
            note: _note,
          ),
        ],
      ),
    );
  }
}
