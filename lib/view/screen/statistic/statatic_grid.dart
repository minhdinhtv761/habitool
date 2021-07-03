import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/services/habit_services.dart';
import 'package:habitool/services/statistic_services.dart';

import 'package:provider/provider.dart';

class StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StatisticServices statisticService =
        Provider.of<StatisticServices>(context, listen: false);
    int totalHabit = statisticService.totalHabits;
    int totalCreateHabit = statisticService.totalCreateHabits;
    //
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Tổng quan",
            style: TextStyle(
              color: CustomColors.pink,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard('Tổng số thói quen', totalHabit,
                    CustomColors.yellow, CustomColors.yellow),
                _buildStatCard('Tổng số lần thực hiện', totalCreateHabit,
                    Colors.white, CustomColors.blue),
              ],
            ),
          ),
          Text(
            "Trong ngày",
            style: TextStyle(
              color: CustomColors.pink,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Consumer<StatisticServices>(builder: (context, statistic, child) {
            return Flexible(
              child: Row(
                children: <Widget>[
                  _buildStatCard('Đang thực hiện', statistic.doingToday,
                      CustomColors.pink, CustomColors.pink),
                  _buildStatCard('Đã hoàn thành', statistic.doneToday,
                      CustomColors.blue, CustomColors.blue),
                  _buildStatCard('Đã hủy', statistic.cancelToday,
                      CustomColors.grey, CustomColors.grey),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Expanded _buildStatCard(
      String title, int count, Color bgColor, Color border) {
    Color textColor =
        bgColor == Colors.white ? CustomColors.blue : Colors.white;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: border),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count.toString(),
              style: TextStyle(
                color: textColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
