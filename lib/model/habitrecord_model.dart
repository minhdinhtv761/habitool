import 'package:habitool/custom_values/enums.dart';

class HabitRecord {
  DateTime date;
  int completed;
  HabitRecord({this.date, this.completed});

  get getDateTime => this.date;

  set setDateTime(dateTime) => this.date = dateTime;

  get getCompleted => this.completed;

  set setCompleted(completed) => this.completed = completed;

  factory HabitRecord.fromJson(
    Map<String, dynamic> data,
  ) {
    return HabitRecord(
      date: data['date'].toDate(),
      completed: data['completed'],
    );
  }
}
