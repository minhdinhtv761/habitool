import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart ';

class HabitModel {
  String _habitId;
  String _name;
  bool _isImportant;
  IconData _icon;
  int _goal;
  String _unitGoal;
  DateTime _startDate;
  DateTime _endDate;
  String _repeat;
  DateTime _time;
  String _note;
  String _userId;

  HabitModel() {
    DateTime dateTime = DateTime.now();

    this._isImportant = false;
    this._icon = Icons.ac_unit;
    this._goal = 0;
    this._unitGoal = 'lần';
    //this._startDate = DateTime.now();
    this._startDate = DateTime(dateTime.day, dateTime.month, dateTime.year);
    this._endDate = DateTime(dateTime.day, dateTime.month, dateTime.year);
    this._repeat = 'Hàng ngày';
    this._time = DateTime(dateTime.hour, dateTime.minute);
  }

  HabitModel.fromFirebase({
    Map<String, dynamic> data,
    String habitId,
  }) {
    this._habitId = habitId;
    this._name = data['name'];
    this._isImportant = data['isImportant'];
    this._icon = data['icon'];
    this._goal = data['targetNumber'];
    this._unitGoal = data['unit'];
    this._startDate = data['startDate'].toDate();
    this._endDate = data['endDate'].toDate();
    this._time = data['time'];
    this._note = data['note'];
    this._userId = data['uid'];
  }

  HabitModel.fromMyHabit(HabitModel myHabit) {
    this._habitId = myHabit._habitId;
    this._name = myHabit._name;
    this._isImportant = myHabit._isImportant;
    this._icon = myHabit._icon;
    this._goal = myHabit._goal;
    this._unitGoal = myHabit._unitGoal;
    this._startDate = myHabit._startDate;
    this._endDate = myHabit._endDate;
    this._repeat = myHabit._repeat;
    this._time = myHabit._time;
    this._note = myHabit._note;
    this._userId = myHabit._userId;
  }

  get habitId => this._habitId;

  get name => this._name;

  set name(value) => this._name = value;

  get isImportant => this._isImportant;

  set isImportant(value) => this._isImportant = value;

  get icon => this._icon;

  set icon(value) => this._icon = value;

  get goal => this._goal;

  set goal(value) => this._goal = value;

  get unitGoal => this._unitGoal;

  set unitGoal(value) => this._unitGoal = value;

  get startDate => this._startDate;

  set startDate(value) => this._startDate = value;

  get endDate => this._endDate;

  set endDate(value) => this._endDate = value;

  get repeat => this._repeat;

  set repeat(repeat) => this._repeat = repeat;

  get time => this._time;

  set time(value) => this._time = value;

  get note => this._note;

  set note(value) => this._note = value;

  get userId => this._userId;

  set userId(value) => this._userId = value;

  Map<String, dynamic> toJshon() {
    return {
      'habitId': _habitId,
      'name': _name,
      'isImportant': _isImportant,
      'icon': _icon.codePoint,
      'targetNumber': _goal,
      'unitGoal': _unitGoal,
      'startDate': _startDate.millisecondsSinceEpoch,
      'endDate': _endDate.millisecondsSinceEpoch,
      'time': _time.millisecondsSinceEpoch,
      'note': _note,
      'userId': _userId,
    };
  }

  Map<String, dynamic> updatedJshon() {
    return {
      'name': _name,
      'isImportant': _isImportant,
      'icon': _icon.codePoint,
      'targetNumber': _goal,
      'unitGoal': _unitGoal,
      'startDate': _startDate.millisecondsSinceEpoch,
      'endDate': _endDate.millisecondsSinceEpoch,
      'time': _time.millisecondsSinceEpoch,
      'note': _note,
    };
  }
}
