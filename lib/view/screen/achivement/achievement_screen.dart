import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/view/screen/achivement/card_item.dart';

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
      body: Column(
        children: [_buildDashboardCards()],
      ),
    );
  }

  Widget _buildDashboardCards() {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: CustomColors.light,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        child: Column(
          children: [
            CardItem(
                primaryColor: CustomColors.blue,
                color1: CustomColors.pink,
                color2: CustomColors.grey.withOpacity(0.5),
                color3: CustomColors.yellow,
                color4: CustomColors.black,
                iconPath: FontAwesomeIcons.cloudSun,
                metricType: 'Chào ngày mới',
                metricCount1: '0',
                metricCount2: '30'),
            CardItem(
                primaryColor: CustomColors.yellow,
                color1: CustomColors.grey.withOpacity(0.5),
                color2: CustomColors.black,
                color3: CustomColors.pink,
                color4: CustomColors.blue,
                iconPath: FontAwesomeIcons.heartbeat,
                metricType: 'Ăn sạch, sống khỏe',
                metricCount1: '1',
                metricCount2: '30'),
          ],
        ),
      ),
    );
  }
}
