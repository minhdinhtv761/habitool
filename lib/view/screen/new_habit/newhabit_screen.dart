//import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/model/enums.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/view/screen/new_habit/recommend_newhabit.dart';
import 'package:habitool/widgets/custom_appbar.dart';

import 'package:habitool/model/profile/user_model.dart';
import 'package:habitool/view/screen/intro/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:habitool/model/services/database_service.dart';

import '../../../custom_values/custom_colors.dart';
import '../../../widgets/habit_info.dart';


class NewHabitScreen extends StatefulWidget {
  @override
  _NewHabitScreenState createState() => _NewHabitScreenState();
}

class _NewHabitScreenState extends State<NewHabitScreen> {
  HabitModel _habitModel = HabitModel();

  FirebaseAuth _auth = FirebaseAuth.instance;

  void UpdateDatabase () async {
    await DatabaseService(_auth.currentUser.uid).updateHabitData(_habitModel.name, _habitModel.isImportant, _habitModel.icon,_habitModel.goal,
        _habitModel.unitGoal, _habitModel.startDate, _habitModel.endDate, _habitModel.repeat, _habitModel.time, _habitModel.note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.light,
        appBar: CustomAppBar(
          title: 'Tạo mới thói quen',
          actionText: 'Lưu',
          action: () {
            // print(_habitModel.name);
            // print(_habitModel.isImportant);
            // print(_habitModel.goal);
            // print(_habitModel.unitGoal);
            // print(_habitModel.startDate);
            // print(_habitModel.endDate);
            // print(_habitModel.repeat);
            // print(_habitModel.time);
            // print(_habitModel.note);

            UpdateDatabase();
          },
          //action: chỗ này là một hàm lưu dữ liệu của _habitModel ,
          // ví dụ:
          // action: HabitModel.addNewHabit(_habitModel);
        ),
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
