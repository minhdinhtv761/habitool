import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/size_config.dart';

class AchievementScreen extends StatefulWidget {
  AchievementScreen();
  @override
  _AchievementScreenState createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: CustomColors.light,
        appBar: AppBar(
          backgroundColor: CustomColors.light,
          shadowColor: Colors.transparent,
          title: Text(
            'Thử thách',
            style: TextStyle(
              color: CustomColors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo_grey.png',
                height: size.width * 0.3,
              ),
              Text(
                'Tính năng đang phát triển',
                style: TextStyle(color: CustomColors.grey),
              ),
            ],
          ),
        ));
  }
}
