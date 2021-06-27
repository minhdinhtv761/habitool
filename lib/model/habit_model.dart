import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/model/habitrecord_model.dart';
import 'package:meta/meta.dart ';

class HabitModel {
  String habitId;
  String name;
  bool isImportant;
  IconData icon;
  int goal;
  String unitGoal;
  DateTime startDate;
  DateTime endDate;
  List<int> repeat;
  DateTime time;
  String note;
  List habitRecords;

  List get getHabitRecords => this.habitRecords;

  set setHabitRecords(List habitRecords) => this.habitRecords = habitRecords;

  get getHabitId => this.habitId;

  set setHabitId(habitId) => this.habitId = habitId;

  get getName => this.name;

  set setName(name) => this.name = name;

  get getIsImportant => this.isImportant;

  set setIsImportant(isImportant) => this.isImportant = isImportant;

  get getIcon => this.icon;

  set setIcon(icon) => this.icon = icon;

  get getGoal => this.goal;

  set setGoal(goal) => this.goal = goal;

  get getUnitGoal => this.unitGoal;

  set setUnitGoal(unitGoal) => this.unitGoal = unitGoal;

  get getStartDate => this.startDate;

  set setStartDate(startDate) => this.startDate = startDate;

  get getEndDate => this.endDate;

  set setEndDate(endDate) => this.endDate = endDate;

  get getRepeat => this.repeat;

  set setRepeat(repeat) => this.repeat = repeat;

  get getTime => this.time;

  set setTime(time) => this.time = time;

  get getNote => this.note;

  set setNote(note) => this.note = note;

  HabitModel(
      {this.habitId,
      this.name,
      this.isImportant,
      this.icon,
      this.goal,
      this.unitGoal,
      this.startDate,
      this.endDate,
      this.repeat,
      this.time,
      this.note,
      this.habitRecords});

  factory HabitModel.fromJson(
    Map<String, dynamic> data,
  ) {
    return HabitModel(
      habitId: data['habitId'],
      name: data['name'],
      isImportant: data['isImportant'],
      icon: IconData(data['icon'], fontFamily: 'MaterialIcons'),
      goal: data['goal'],
      unitGoal: data['unitGoal'],
      startDate: data['startDate'].toDate(),
      endDate: data['endDate'].toDate(),
      time: data['time'].toDate(),
      repeat: List.from(data['repeat']),
      note: data['note'],
    );
  }

  Map<String, dynamic> createHabitRecord(DateTime date, int completed) {
    return {
      'habitRecords': FieldValue.arrayUnion([
        {
          "date": date,
          "completed": completed,
        },
      ])
    };
  }

  HabitModel.fromMyHabit(HabitModel myHabit) {
    this.habitId = myHabit.habitId;
    this.name = myHabit.name;
    this.isImportant = myHabit.isImportant;
    this.icon = myHabit.icon;
    this.goal = myHabit.goal;
    this.unitGoal = myHabit.unitGoal;
    this.startDate = myHabit.startDate;
    this.endDate = myHabit.endDate;
    this.repeat = myHabit.repeat;
    this.time = myHabit.time;
    this.note = myHabit.note;
  }
}
