import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/functions/habit_functions.dart';
import 'package:habitool/services/habit_services.dart';

import '../../custom_values/custom_colors.dart';
import 'achivement/achievement_screen.dart';
import 'dashboard/dashboard_screen.dart';
import 'new_habit/newhabit_screen.dart';
import 'statistic/statistic_screen.dart';
import 'user/user_screen.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;
  DateTime date = DateTime.now();
  //final Widget currentScreen = DashBoardScreen();

  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final List<Widget> tabs = [
      DashBoardScreen(),
      StatisticScreen(),
      AchievementScreen(),
      UserScreen(),
      NewHabitScreen()
    ];

    return Scaffold(
      backgroundColor: CustomColors.light,
      extendBody: true,
      body: PageStorage(
        child: tabs[currentTab],
        bucket: _bucket,
      ),
      bottomNavigationBar: buildBottomAppBar(size),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

// Hàm bulil FAB
  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: CustomColors.pink,
      child: Icon(
        Icons.add,
        size: 45.0,
        color: Colors.white,
      ),
      onPressed: () {
        setState(() {
          this.currentTab = 4;
        });
      },
    );
  }

// Hàm build BottomAppBar
  BottomAppBar buildBottomAppBar(Size size) {
    return BottomAppBar(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      notchMargin: 7.0,
      shape: CircularNotchedRectangle(),
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home_outlined),
              iconSize: 30.0,
              color:
                  currentTab == 0 ? CustomColors.blue : CustomColors.darkgrey,
              onPressed: () => setState(() {
                this.currentTab = 0;
              }),
            ),
            IconButton(
              icon: Icon(Icons.insert_chart_outlined_rounded),
              iconSize: 30.0,
              color:
                  currentTab == 1 ? CustomColors.blue : CustomColors.darkgrey,
              onPressed: () => setState(() {
                this.currentTab = 1;
              }),
            ),
            SizedBox(width: size.width * 0.1),
            IconButton(
              icon: Icon(Icons.star_border_rounded),
              iconSize: 30.0,
              color:
                  currentTab == 2 ? CustomColors.blue : CustomColors.darkgrey,
              onPressed: () => setState(() {
                this.currentTab = 2;
              }),
            ),
            IconButton(
              icon: Icon(Icons.person_outline_rounded),
              iconSize: 30.0,
              color:
                  currentTab == 3 ? CustomColors.blue : CustomColors.darkgrey,
              onPressed: () => setState(() {
                this.currentTab = 3;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
