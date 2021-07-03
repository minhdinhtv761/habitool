//import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/functions/habit_functions.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/services/habit_services.dart';
import 'package:habitool/view/screen/new_habit/recommend_newhabit.dart';
import 'package:habitool/view/screen/new_habit/recommend_screen.dart';
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
  HabitModel _habitModel = HabitModel(notif: false, isImportant: false);
  HabitFunctions _habitFunctions = HabitFunctions();
  bool isRecommend = false;
  @override
  Widget build(BuildContext context) {
    //
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
              RecommendNewHabit(getRecommendHabit: (habitModel) {
                setState(() {
                  _habitModel = habitModel;
                  this.isRecommend = true;
                });
              }),
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: this.isRecommend
                    ? RecommendScreen(
                        habitModel: _habitModel,
                        habitCallback: (habitModel) =>
                            this._habitModel = habitModel,
                      )
                    : HabitInfo(
                        HabitModelMode.NEW,
                        isRecommend: false,
                        habitCallback: (habitModel) {
                          this._habitModel = habitModel;
                        },
                      ),
              ),
            ],
          ),
        ));
  }
}
