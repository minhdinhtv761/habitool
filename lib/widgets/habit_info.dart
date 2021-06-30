import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/model/habitrecord_model.dart';
import 'package:habitool/view/screen/new_habit/goal_dialog.dart';
import 'package:habitool/view/screen/new_habit/notification_dialog.dart';

import 'package:habitool/view/screen/new_habit/repetition_dialog.dart';
import 'package:habitool/widgets/custom_dialog.dart';
import 'package:habitool/widgets/habit_notebox.dart';
import 'package:habitool/widgets/custom_card.dart';
import 'package:habitool/widgets/habit_namebox.dart';
import 'package:habitool/widgets/message_box.dart';
import 'package:habitool/widgets/time_picker.dart';

import 'body_menu.dart';
import 'date_picker.dart';

class HabitInfo extends StatefulWidget {
  HabitInfo(this.mode, {this.habitModel, this.habitCallback, this.isRecommend});

  final HabitModelMode mode;
  final HabitCallback habitCallback;
  final HabitModel habitModel;
  final bool isRecommend;
  @override
  _HabitInfo createState() => _HabitInfo();
}

DateTime dateTime = DateTime.now();
DateTime dateNow = DateTime(dateTime.year, dateTime.month, dateTime.day);

class _HabitInfo extends State<HabitInfo> {
  HabitModel _habitModel = HabitModel();
  bool edittingEnabled;
  bool edittingStartDate;

//Default value
  String _habitId = '';
  String _name = '';
  bool _isImportant = false;
  IconData _icon = Icons.ac_unit;
  int _goal = 0;
  String _unitGoal = 'lần';
  DateTime _startDate = dateNow;
  DateTime _endDate = dateNow;
  List<int> _repeat = [1, 2, 3, 4, 5, 6, 7];
  DateTime _time = dateTime;
  bool _notif = false;
  String _note = '';
  List<HabitRecord> _habitRecords = <HabitRecord>[];

  List<String> _repeatString = [];

  void initState() {
    if (this.widget.mode == HabitModelMode.NEW) {
      edittingEnabled = true;
      edittingStartDate = true;
    } else {
      edittingEnabled = true;
      onCreate();
      edittingStartDate = isEditStartDate();
    }
    super.initState();
  }

  void onCreate() {
    _habitId = this.widget.habitModel.habitId;
    _name = this.widget.habitModel.name;
    _isImportant = this.widget.habitModel.isImportant;
    _icon = this.widget.habitModel.icon;
    _goal = this.widget.habitModel.goal;
    _unitGoal = this.widget.habitModel.unitGoal;
    _startDate = this.widget.habitModel.startDate;
    _endDate = this.widget.habitModel.endDate;
    _repeat = this.widget.habitModel.repeat;
    _time = this.widget.habitModel.time;
    _notif = this.widget.habitModel.notif;
    _note = this.widget.habitModel.note;
    _habitRecords = this.widget.habitModel.habitRecords;
  }

  void onChanged() {
    _habitModel.habitId = _habitId;
    _habitModel.name = _name;
    _habitModel.isImportant = _isImportant;
    _habitModel.icon = _icon;
    _habitModel.goal = _goal;
    _habitModel.unitGoal = _unitGoal;
    _habitModel.startDate =
        DateTime(_startDate.year, _startDate.month, _startDate.day);
    _habitModel.endDate = DateTime(_endDate.year, _endDate.month, _endDate.day);
    _habitModel.repeat = _repeat;
    _habitModel.time = DateTime(1, 1, 1, _time.hour, _time.minute);
    _habitModel.notif = _notif;
    _habitModel.note = _note;
    _habitModel.habitRecords = _habitRecords;

    this.widget.habitCallback(_habitModel);
  }

  bool isEditStartDate() {
    if (_startDate.isAfter(dateNow)) return true;
    return false;
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
    if (this.widget.isRecommend)
      setState(() {
        edittingEnabled = true;
        onCreate();
        edittingStartDate = true;
      });

    Widget nameBox = NameBox(
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
    );

    BodyMenu startDate = BodyMenu(
      icon: Icons.calendar_today,
      title: 'Bắt đầu',
      content: '${_startDate.day}/${_startDate.month}/${_startDate.year}',
      press: () {
        showGeneralDialog(
            context: context,
            pageBuilder: (_, __, ___) {
              if (this.edittingStartDate) {
                return DatePicker(
                  _startDate,
                  minDate: dateNow,
                  callback: (value) {
                    setState(() {
                      _startDate = value;
                    });
                    onChanged();
                  },
                );
              } else
                return MessageBox.messageDialog;
            });
      },
    );

    BodyMenu goal = BodyMenu(
      icon: FontAwesomeIcons.bullseye,
      title: 'Mục tiêu',
      content: '${_goal.toString()} ${_unitGoal}',
      press: () {
        showGeneralDialog(
            context: context,
            pageBuilder: (_, __, ___) {
              if (this.edittingStartDate) {
                return GoalDialog(
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
                );
              } else
                return MessageBox.messageDialog;
            });
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
            minDate: this.edittingEnabled ? _startDate : dateNow,
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

    BodyMenu notification = BodyMenu(
      icon: FontAwesomeIcons.bell,
      title: 'Nhắc nhở',
      content: _notif ? 'Bật' : 'Tắt',
      press: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => NotificationDialog(
            _notif ? 'Bật' : 'Tắt',
            getNotif: (value) {
              setState(() {
                _notif = value == 'Bật';
              });
            },
          ),
        );
      },
    );

//Thời gian/Nhắc nhở
    List<BodyMenu> listTime = [time, notification];

    List<Widget> getMenuList(List<BodyMenu> list) {
      List<Widget> _list = List();
      for (var item in list) {
        _list.add(item);
        if (list.indexOf(item) != list.length - 1)
          _list.add(Divider(height: 1));
      }
      return _list;
    }

    Widget noteBox = NoteBox(
      enabled: edittingEnabled,
      onValueChange: (text) {
        _note = text;
        onChanged();
      },
      note: _note,
    );

    //List <Widget> basicInfo =
    return Material(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          nameBox,
          CustomCard(
            child: Column(
              children: getMenuList(listBasicInfo.toList()),
            ),
          ),
          CustomCard(
            child: Column(
              children: getMenuList(listTime.toList()),
            ),
          ),
          noteBox,
        ],
      ),
    );
  }
}
