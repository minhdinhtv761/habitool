import 'package:habitool/custom_values/enums.dart';

class HabitRecord {
  DateTime dateTime;
  int day;
  int completed;
  int goal;
  HabitRecord({this.dateTime, this.day, this.completed, this.goal});

  get getDateTime => this.dateTime;

  set setDateTime(dateTime) => this.dateTime = dateTime;

  get getDay => this.day;

  set setDay(day) => this.day = day;

  get getCompleted => this.completed;

  set setCompleted(completed) => this.completed = completed;

  get getGoal => this.goal;

  set setGoal(goal) => this.goal = goal;
}
