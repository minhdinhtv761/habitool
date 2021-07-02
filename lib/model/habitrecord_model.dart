import 'package:flutter/material.dart';
import 'package:habitool/model/habit_model.dart';

class HabitRecord {
  DateTime date;
  int completed = 0;
  int status = 0;
  HabitRecord({this.date, this.completed, this.status});

  factory HabitRecord.fromJson(
    Map<String, dynamic> data,
  ) {
    return HabitRecord(
        date: data['date'].toDate(),
        completed: data['completed'],
        status: data['status']);
  }

  static List<HabitRecord> fromJsonArray(List<dynamic> jsonArray) {
    List<HabitRecord> habitRecordFromJson = [];
    jsonArray.forEach((jsonData) {
      habitRecordFromJson.add(HabitRecord.fromJson(jsonData));
    });
    return habitRecordFromJson;
  }
}
