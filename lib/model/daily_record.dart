import 'package:habitool/model/habit_record.dart';

class DailyRecord {
  DateTime dateTime;
  List<HabitRecord> habitRecords;

  DateTime get getDateTime => this.dateTime;

  set setDateTime(DateTime dateTime) => this.dateTime = dateTime;

  get getHabitRecords {
    List<HabitRecord> _list = [];
  }
}
