import 'package:habitool/model/habitrecord_model.dart';

class DailyRecord {
  DateTime dateTime;
  List<HabitRecord> habitRecords;

  DateTime get getDateTime => this.dateTime;

  set setDateTime(DateTime dateTime) => this.dateTime = dateTime;

  get getHabitRecords {
    List<HabitRecord> _list = [];
  }
}
