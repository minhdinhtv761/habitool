import 'dart:io';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/functions/habit_functions.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/model/statistic_model.dart';
import 'package:habitool/services/habit_services.dart';
import 'package:habitool/services/statistic_services.dart';
import 'package:habitool/view/screen/dashboard/all_habit_list/finished_habit_list.dart';
import 'package:habitool/view/screen/dashboard/all_habit_list/future_habit_list.dart';
import 'package:habitool/view/screen/dashboard/all_habit_list/going_habit_list.dart';
import 'package:habitool/view/screen/dashboard/habit_list.dart';
import 'package:habitool/view/screen/dashboard/today_habit_list/canceled_habit_list.dart';
import 'package:habitool/view/screen/dashboard/today_habit_list/doing_habit_list.dart';
import 'package:habitool/view/screen/dashboard/today_habit_list/done_habit_list.dart';

import '../../../custom_values/custom_colors.dart';
import '../../../widgets/custom_dropdown_button.dart';
import 'dashboard_appbar.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  DashBoardScreen();
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DateTime _selectedDay = DateTime.now();

  List<String> _listShowDropdownItems = <String>['Hôm nay', 'Tất cả'];

  List<List<String>> _listTypeDropdownItems = <List<String>>[
    <String>[
      'Tất cả',
      'Chưa hoàn thành',
      'Đã hoàn thành',
      'Đã hủy',
    ],
    <String>[
      'Tất cả',
      'Đang thực hiện',
      'Sắp thực hiện',
      'Đã kết thúc',
    ]
  ];

  String _typeDropdownValue = 'Tất cả';
  String _showDropdownValue = 'Hôm nay';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
//
    HabitServices habitServices =
        Provider.of<HabitServices>(context, listen: false);
    habitServices.getTodayHabitFromFirebase(this._selectedDay);
    habitServices.getGoingHabitFromFirebase(this._selectedDay);
    habitServices.getFutureHabitFromFirebase(this._selectedDay);
    habitServices.getFinishedHabitFromFirebase(this._selectedDay);
    //
    StatisticServices statisticService =
        Provider.of<StatisticServices>(context, listen: false);
    statisticService.getData();
    statisticService.getDataToday();
    //
    return Consumer<HabitServices>(builder: (context, habitServices, child) {
      //
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: CustomColors.light,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            DashboardAppBar(
              callback: (value) => setState(() {
                this._selectedDay = value;
              }),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.075),
              sliver: SliverToBoxAdapter(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CustomDropdownButton(
                      listDropdownItems: this._listShowDropdownItems,
                      dropdownValue: this._showDropdownValue,
                      callback: (value) => setState(() {
                        this._showDropdownValue = value;
                        this._typeDropdownValue = 'Tất cả';
                      }),
                    ),
                    Spacer(),
                    CustomDropdownButton(
                      listDropdownItems: this._showDropdownValue == 'Hôm nay'
                          ? this._listTypeDropdownItems[0]
                          : this._listTypeDropdownItems[1],
                      dropdownValue: this._typeDropdownValue,
                      callback: (value) =>
                          setState(() => this._typeDropdownValue = value),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.075),
              sliver: this._typeDropdownValue == 'Tất cả' ||
                      this._typeDropdownValue == 'Đang thực hiện' ||
                      this._typeDropdownValue == 'Chưa hoàn thành'
                  ? (this._showDropdownValue == 'Hôm nay'
                      ? DoingHabit(this._selectedDay)
                      : GoingHabit(this._selectedDay))
                  : null,
            ),
            // Consumer<HabitServices>(
            //   builder: (context, habitServices, child) {
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.075),
              sliver: this._typeDropdownValue == 'Tất cả' ||
                      this._typeDropdownValue == 'Đã hoàn thành' ||
                      this._typeDropdownValue == 'Sắp thực hiện'
                  ? (this._showDropdownValue == 'Hôm nay'
                      ? DoneHabit(this._selectedDay)
                      : FutureHabit(this._selectedDay))
                  : null,
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.075),
              sliver: _typeDropdownValue == 'Tất cả' ||
                      _typeDropdownValue == 'Đã hủy' ||
                      _typeDropdownValue == 'Đã kết thúc'
                  ? (this._showDropdownValue == 'Hôm nay'
                      ? CanceledHabit(this._selectedDay)
                      : FinishedHabit(this._selectedDay))
                  : null,
            ),

            // SliverToBoxAdapter dùng để làm phần trống, tránh việc dữ liệu bị che dưới BottomAppBar
            SliverToBoxAdapter(
                child: Container(height: 100.0, color: Colors.transparent)),
          ],
        ),
      );
    });
  }
}
