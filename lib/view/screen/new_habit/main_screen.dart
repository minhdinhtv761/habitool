//import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/view/screen/new_habit/recommend_newhabit.dart';

import '../../../custom_values/custom_colors.dart';
import 'newhabit_info.dart';

class NewHabitScreen extends StatefulWidget {
  @override
  _NewHabitScreenState createState() => _NewHabitScreenState();
}

class _NewHabitScreenState extends State<NewHabitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.light,
        appBar: AppBar(
            backgroundColor: CustomColors.light,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: CustomColors.black),
              onPressed: () {},
            ),
            title: Text(
              'Tạo mới thói quen',
              style: TextStyle(
                color: CustomColors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Lưu',
                    style: TextStyle(fontSize: 18, color: CustomColors.link)),
                onPressed: () {},
              )
            ]),
        body: Padding(
          padding: const EdgeInsets.only(left: 21, top: 10, right: 21),
          child: ListView(
            children: <Widget>[
              RecommendNewHabit(),
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: NewHabitInfo(),
              )
            ],
          ),
        ));
  }
}
