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
    print('$type  $status');
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
    List<Widget> _title = [
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

    List<HabitModel> listHabitModel =
        habitServices.getHabitList(this.type, this.status).toList();

    List<Widget> list = (this.type == HabitTileType.general
        ? HabitFunctions.buildGeneralListWidget(_title, listHabitModel.toList())
        : HabitFunctions.buildDailyListWidget(
            _title, listHabitModel.toList(), DateTime.now(), this.status));

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (list.length == 1) {
            return null;
          } else {
            if (index.isOdd) {
              return list[index ~/ 2];
            } else {
              return SizedBox(height: 10.0);
            }
          }
        },
        childCount: list.length * 2 + 1,
      ),
    );
  }
}
