import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/custom_values/enums.dart';
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
  HabitInfo(this.mode, {this.habitModel, this.habitCallback});

  final HabitModelMode mode;
  final HabitCallback habitCallback;
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
  IconData _icon = FontAwesomeIcons.heart;
  int _goal = 0;
  String _unitGoal = 'lần';
  DateTime _startDate = dateTime;
  DateTime _endDate = dateTime;
  List<int> _repeat = [1, 2, 3, 4, 5, 6, 7];

  List<String> _repeatString = [];
  DateTime _time = dateTime;
  String _note = "";

  void initState() {
    super.initState();
    if (this.widget.mode == HabitModelMode.NEW) {
      edittingEnabled = true;
    } else {
      edittingEnabled = true;
      //Gán giá trị
      onCreate();
    }
  }

  void onCreate() {
    _name = _habitModel.name;
    _isImportant = _habitModel.isImportant;
    _icon = _habitModel.icon;
    _goal = _habitModel.goal;
    _unitGoal = _habitModel.unitGoal;
    _startDate = _habitModel.startDate;
    _endDate = _habitModel.endDate;
    _repeat = _habitModel.repeat;
    _time = _habitModel.time;
    _note = _habitModel.note;
  }

  void onChanged() {
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

    this.widget.habitCallback(_habitModel);
  }

  List<String> getDate = ['T2', 'T3', 'T4', 'T5', 'T5', 'T7', 'CN'];
  void changeRepeatToString() {
    _repeatString.clear();
    _repeat.forEach((element) {
      int index = _repeat.indexOf(element);
      _repeatString.add(getDate[index]);
    });
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
            _startDate,
            callback: (value) {
              setState(() {
                _startDate = value;
              });
              onChanged();
            },
          ),
        );
      },
    );

    BodyMenu goal = BodyMenu(
      icon: FontAwesomeIcons.bullseye,
      title: 'Mục tiêu',
      content: '${_goal.toString()} ${_unitGoal}',
      press: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => GoalDialog(
            getGoal: (goal) {
              setState(() {
                _goal = int.parse(goal);
              });
              onChanged();
            },
            getUnitGoal: (unitGoal) {
              setState(() {
                _unitGoal = unitGoal;
              });
              onChanged();
            },
          ),
        );
      },
    );

    BodyMenu repetition = BodyMenu(
      icon: Icons.cached_rounded,
      title: 'Lặp lại',
      content: (_repeat.length == 7 ? 'Hàng ngày' : _repeatString.join(', ')),
      press: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => RepetitionDialog(
              // getRepeat: (repeat)
              // {
              //   setState(() {
              //     _habitModel.repeat = int.parse(repeat);
              //   });
              //   onChanged();
              // },
              ),
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
            _endDate,
            callback: (value) {
              setState(() {
                _endDate = value;
              });
              onChanged();
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
          pageBuilder: (_, __, ___) => TimePicker(
            dateTimeCallback: (time) {
              setState(() {
                _time = time;
              });
              onChanged();
            },
          ),
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
            onValueChange: (text) {
              _name = text;
              onChanged();
            },
            getIconData: (icon) {
              _icon = icon;
              onChanged();
            },
            getImportantValue: (value) {
              _isImportant = value;
              onChanged();
            },
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
            onValueChange: (text) {
              _note = text;
              onChanged();
            },
            note: _note,
          ),
        ],
      ),
    );
  }
}
