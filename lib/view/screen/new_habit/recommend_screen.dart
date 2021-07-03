import 'package:flutter/cupertino.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/widgets/habit_info.dart';

class RecommendScreen extends StatefulWidget {
  RecommendScreen({this.habitModel, this.habitCallback});
  HabitModel habitModel;
  HabitCallback habitCallback;
  @override
  _RecommendScreenState createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  @override
  Widget build(BuildContext context) {
    return HabitInfo(
      HabitModelMode.NEW,
      isRecommend: true,
      habitModel: this.widget.habitModel,
      habitCallback: (habitModel) {
        this.widget.habitCallback(habitModel);
      },
    );
  }
}
