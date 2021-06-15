//import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/widgets/habit_info.dart';

import '../../../custom_values/custom_colors.dart';

enum MenuItems { save, delete }

class ModifyHabitScreen extends StatefulWidget {
  ModifyHabitScreen({
    Key key,
    @required this.habitName,
    @required this.habitTime,
    @required this.goalUnit,
    @required this.goal,
    @required this.isImportant,
    @required this.startDate,
    @required this.endDate,
    @required this.repeat,
    @required this.note,
  });

  String habitName;
  String habitTime;
  String goalUnit;
  String goal;
  bool isImportant;
  String startDate;
  String endDate;
  String repeat;
  String note;

  @override
  _ModifyHabitScreenState createState() => _ModifyHabitScreenState();
}

class _ModifyHabitScreenState extends State<ModifyHabitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.light,
        appBar: AppBar(
          backgroundColor: CustomColors.light,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: CustomColors.black),
            onPressed: () {},
          ),
          title: Text(
            this.widget.habitName,
            style: TextStyle(
              color: CustomColors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            PopupMenuButton<MenuItems>(
              onSelected: (value) => {setState(() {})},
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
                  habitName: this.widget.habitName,
                  time: this.widget.habitTime,
                  goalUnit: this.widget.goalUnit,
                  goal: this.widget.goal,
                  isImportant: this.widget.isImportant,
                  startDate: this.widget.startDate,
                  endDate: this.widget.endDate,
                  repeat: this.widget.note,
                  note: this.widget.note,
                ),
              )
            ],
          ),
        ));
  }
}
