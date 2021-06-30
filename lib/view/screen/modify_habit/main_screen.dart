//import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/functions/dashboard_function.dart';
import 'package:habitool/functions/habit_functions.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/widgets/habit_info.dart';

import '../../../custom_values/custom_colors.dart';
import '../home_screen.dart';

enum MenuItems { save, delete }

class ModifyHabitScreen extends StatefulWidget {
  final HabitModel habitModel;
  final HabitTileType habitTileType;
  final HabitStatus habitStatus;
  ModifyHabitScreen(this.habitModel, this.habitTileType, this.habitStatus);
  @override
  _ModifyHabitScreenState createState() => _ModifyHabitScreenState();
}

class _ModifyHabitScreenState extends State<ModifyHabitScreen> {
  HabitModel newHabitModel;
  HabitFunctions habitFunctions = HabitFunctions();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.light,
        appBar: AppBar(
          backgroundColor: CustomColors.light,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: CustomColors.black),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false);
            },
          ),
          title: Text(
            this.widget.habitModel.name,
            style: TextStyle(
              color: CustomColors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            PopupMenuButton<MenuItems>(
              onSelected: (value) => {
                if (value == MenuItems.save)
                  {
                    habitFunctions.updateHabit(
                        this.newHabitModel, this.widget.habitModel, context)
                  }
                else
                  {
                    DashboardFunction.handelHabitSelectedOption(
                        this.widget.habitModel,
                        HabitSelectedOption.DEL,
                        context,
                        habitTileType: this.widget.habitTileType,
                        habitStatus: this.widget.habitStatus)
                  }
              },
              icon: Icon(
                Icons.more_vert_rounded,
                color: CustomColors.black,
              ),
              itemBuilder: (context) => <PopupMenuEntry<MenuItems>>[
                const PopupMenuItem<MenuItems>(
                  value: MenuItems.save,
                  child: Text(
                    'Lưu',
                    style: TextStyle(fontSize: 18, color: CustomColors.link),
                  ),
                ),
                const PopupMenuItem<MenuItems>(
                  value: MenuItems.delete,
                  child: Text(
                    'Xóa',
                    style: TextStyle(fontSize: 18, color: CustomColors.link),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 21, top: 10, right: 21),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: HabitInfo(
                  HabitModelMode.EDIT,
                  isRecommend: false,
                  habitModel: this.widget.habitModel,
                  habitCallback: (value) {
                    this.newHabitModel = value;
                  },
                ),
              )
            ],
          ),
        ));
  }
}
