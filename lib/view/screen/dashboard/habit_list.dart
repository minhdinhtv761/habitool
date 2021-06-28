import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/functions/habit_functions.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/services/habit_services.dart';
import 'package:habitool/widgets/habit_tile.dart';
import 'package:provider/provider.dart';

class HabitList extends StatefulWidget {
  HabitTileType type;
  HabitStatus status;
  HabitList(this.type, this.status);
  String title;
  @override
  _HabitListState createState() {
    print('$type $status');
    var generalTitle = {
      HabitStatus.doing: 'Đang thực hiện',
      HabitStatus.future: 'Sắp thực hiện',
      HabitStatus.done: 'Đã kết thúc'
    };

    var dailyTitle = {
      HabitStatus.doing: 'Chưa hoàn thành',
      HabitStatus.done: 'Đã hoàn thành',
      HabitStatus.canceled: 'Đã hủy'
    };

    var typeMap = {
      HabitTileType.dailyProgress: dailyTitle,
      HabitTileType.general: generalTitle
    };
    this.title = typeMap[this.type][this.status];
    return _HabitListState(this.type, this.status, this.title);
  }
}

class _HabitListState extends State<HabitList> {
  String title;
  HabitTileType type;
  HabitStatus status;
  _HabitListState(this.type, this.status, this.title);

  @override
  Widget build(BuildContext context) {
    List<Widget> title = [
      Center(
        child: Text(
          this.title,
          style: TextStyle(
            color: CustomColors.darkgrey,
            fontSize: 13.0,
          ),
        ),
      ),
    ];
    HabitServices habitServices =
        Provider.of<HabitServices>(context, listen: true);

    return Consumer<HabitServices>(builder: (context, habitService, child) {
      List<HabitModel> listHabitModel = [];
      bool isGeneral = (this.type == HabitTileType.general);
      switch (this.status) {
        case HabitStatus.future:
          listHabitModel = habitService.generalHabitListFuture.toList();
          break;
        case HabitStatus.done:
          listHabitModel = isGeneral
              ? habitService.generalHabitListFinished.toList()
              : habitService.todayHabitListDone.toList();
          break;
        case HabitStatus.doing:
          listHabitModel = isGeneral
              ? habitService.generalHabitListGoing
              : habitService.todayHabitListDoing.toList();
          break;
        default:
          listHabitModel = habitService.todayHabitListCancel.toList();
          break;
      }
      print('$type $status ${listHabitModel.length}');
      List<Widget> listWidget = [];

      if (this.type == HabitTileType.dailyProgress)
        listWidget = HabitFunctions.buildDailyListWidget(
            title, listHabitModel, DateTime.now(), this.status);
      else
        listWidget =
            HabitFunctions.buildGeneralListWidget(title, listHabitModel);

      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (listWidget.length == 1) {
              return null;
            } else {
              if (index.isOdd) {
                return listWidget[index ~/ 2];
              } else {
                return SizedBox(height: 10.0);
              }
            }
          },
          childCount: listWidget.length * 2 + 1,
        ),
      );
    });
  }
}
