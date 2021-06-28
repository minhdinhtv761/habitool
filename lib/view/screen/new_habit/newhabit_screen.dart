//import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/functions/habit_functions.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/services/habit_services.dart';
import 'package:habitool/view/screen/new_habit/recommend_newhabit.dart';
import 'package:habitool/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../custom_values/custom_colors.dart';
import '../../../widgets/habit_info.dart';
import '../home_screen.dart';

class NewHabitScreen extends StatefulWidget {
  @override
  _NewHabitScreenState createState() => _NewHabitScreenState();
}

class _NewHabitScreenState extends State<NewHabitScreen> {
  HabitModel _habitModel = HabitModel();
  HabitFunctions _habitFunctions = HabitFunctions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.light,
        appBar: CustomAppBar(
            title: 'Tạo mới thói quen',
            actionText: 'Lưu',
            action: () {
              _habitFunctions.addHabit(_habitModel, context);
            }),
        body: Padding(
          padding: const EdgeInsets.only(left: 21, top: 10, right: 21),
          child: ListView(
            children: <Widget>[
              RecommendNewHabit(),
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: HabitInfo(
                  HabitModelMode.NEW,
                  habitCallback: (habitModel) {
                    this._habitModel = habitModel;
                  },
                ),
              )
            ],
          ),
        ));
  }
}
