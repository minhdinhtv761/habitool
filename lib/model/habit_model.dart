import 'dart:convert';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart ';

class MyHabit {
  String _habitId;
  String _name;
  IconData _icon;
  int _goal;
  String _unitGoal;
  DateTime _startDate;
  DateTime _endDate;
  DateTime _time;
  String _note;
  String _userId;

  MyHabit() {
    Timestamp timestamp = Timestamp.now();
    this._icon = Icons.ac_unit;
    this._goal = 0;
    this._unitGoal = 'lần';
    this._startDate = timestamp.toDate();
    this._endDate = timestamp.toDate();
    this._time = DateTime(1, 1, 1, 08, 00);
  }

  MyHabit.fromFirebase({
    Map<String, dynamic> data,
    String habitId,
  }) {
    this._habitId = habitId;
    this._name = data['name'];
    this._icon = data['icon'];
    this._goal = data['targetNumber'];
    this._unitGoal = data['unit'];
    this._startDate = data['startDate'].toDate();
    this._endDate = data['endDate'].toDate();
    this._time = data['time'];
    this._note = data['note'];
    this._userId = data['uid'];
  }

  MyHabit.fromMyHabit(MyHabit myHabit) {
    this._habitId = myHabit._habitId;
    this._name = myHabit._name;
    this._icon = myHabit._icon;
    this._goal = myHabit._goal;
    this._unitGoal = myHabit._unitGoal;
    this._startDate = myHabit._startDate;
    this._endDate = myHabit._endDate;
    this._time = myHabit._time;
    this._note = myHabit._note;
    this._userId = myHabit._userId;
  }

  get habitId => this._habitId;

  get name => this._name;

  set name(value) => this._name = value;

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
