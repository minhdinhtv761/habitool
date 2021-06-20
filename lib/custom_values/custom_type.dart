import 'package:habitool/model/habit_model.dart';

enum HabitStatus { doing, done, canceled }
enum HabitTileType { dailyProgress, general }

typedef void DateTimeCallback(DateTime value);

typedef void StringCallback(String value);

typedef void HabitCallback(HabitModel habitModel);
