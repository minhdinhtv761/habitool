//import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/model/enums.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/view/screen/new_habit/recommend_newhabit.dart';
import 'package:habitool/widgets/custom_appbar.dart';

import '../../../custom_values/custom_colors.dart';
import '../../../widgets/habit_info.dart';

class NewHabitScreen extends StatefulWidget {
  @override
  _NewHabitScreenState createState() => _NewHabitScreenState();
}

class _NewHabitScreenState extends State<NewHabitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.light,

        appBar: CustomAppBar(
          title: 'Tạo mới thói quen',
          action: 'Lưu',
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 21, top: 10, right: 21),
          child: ListView(
            children: <Widget>[
              RecommendNewHabit(),
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: HabitInfo(HabitModelMode.NEW),
              )
            ],
          ),
        ));
  }
}
