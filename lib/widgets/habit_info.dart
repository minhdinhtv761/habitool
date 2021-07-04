import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/functions/habit_functions.dart';
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
  HabitInfo(this.mode,
      {this.habitModel, this.habitCallback, @required this.isRecommend});

  final HabitModelMode mode;
  final HabitCallback habitCallback;
  final HabitModel habitModel;
  final bool isRecommend;
  @override
  _HabitInfo createState() => _HabitInfo(this.isRecommend);
}

DateTime dateTime = DateTime.now();
DateTime dateNow = DateTime(dateTime.year, dateTime.month, dateTime.day);

class _HabitInfo extends State<HabitInfo> {
  //khởi tạo
  bool isRecommend;
  _HabitInfo(this.isRecommend);
  //
  HabitModel _habitModel = HabitModel(notif: false, isImportant: false);
  bool edittingEnabled;
  bool edittingStartDate;

//Default value
  String _habitId = '';
  String _name = '';
  bool _isImportant = false;
  IconData _icon = Icons.ac_unit;
  int _goal = 1;
  String _unitGoal = 'lần';
  DateTime _startDate = dateNow;
  DateTime _endDate = dateNow;
  List<int> _repeat = [1, 2, 3, 4, 5, 6, 7];
  DateTime _time = dateTime;
  bool _notif = false;
  String _note = '';
  List<HabitRecord> _habitRecords = <HabitRecord>[];

  List<String> _repeatString;

  void initState() {
    //
    if (this.widget.mode == HabitModelMode.NEW) {
      if (this.isRecommend) {
        onCreate();
      }
      edittingEnabled = true;
      edittingStartDate = true;
      onChanged();
    } else {
      edittingEnabled = true;
      onCreate();
      edittingStartDate = canEditStartDate();
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
    _habitModel.time = DateTime(2021, 7, 4, _time.hour, _time.minute);
    _habitModel.notif = _notif;
    _habitModel.note = _note;
    _habitModel.habitRecords = _habitRecords;

    this.widget.habitCallback(_habitModel);
  }

  bool canEditStartDate() {
    if (_startDate.isAfter(dateNow)) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    //chuyển repeat sang chuỗi hiển thị
    _repeatString = HabitFunctions.convertToStringList(_repeat);
    //
    //Nếu đang chọn gợi ý

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
                  minDate: DateTime(2021, 1, 1),
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
      content:
          (_repeatString.length == 7 ? 'Hàng ngày' : _repeatString.join(', ')),
      press: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (_, __, ___) => RepetitionDialog(
              repeat: _repeat,
              getRepeat: (listSelected) {
                setState(() {
                  _repeat = HabitFunctions.convertToIntList(listSelected);
                });
                onChanged();
              }),
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
            minDate: _startDate,
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
