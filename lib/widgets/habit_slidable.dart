import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habitool/custom_values/enums.dart';

import '../custom_values/custom_colors.dart';
import '../custom_values/custom_type.dart';
import '../widgets/habit_tile.dart';

class HabitSlidable extends StatefulWidget {
  HabitTileType habitTileType;
  String name;
  IconData icon;
  DateTime time;
  String unitGoal;
  int goal;
  int goalCompleted;
  bool isImportant;
  DateTime startDate;
  DateTime endDate;
  HabitStatus habitStatus = HabitStatus.doing;

  HabitSlidable({
    @required this.habitTileType,
    @required this.name,
    @required this.icon,
    @required this.time,
    @required this.unitGoal,
    @required this.goal,
    this.goalCompleted,
    @required this.isImportant,
    @required this.startDate,
    @required this.endDate,
    this.habitStatus,
  });
  @override
  _HabitSlidableState createState() => _HabitSlidableState();
}

class _HabitSlidableState extends State<HabitSlidable> {
  List<Widget> _doingHabitPrimaryAction = [
    IconSlideAction(
      iconWidget: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          color: CustomColors.blue,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3.0),
        ),
        child: Icon(
          Icons.check_rounded,
          color: Colors.white,
          size: 40.0,
        ),
      ),
      color: Colors.transparent,
    ),
    IconSlideAction(
      iconWidget: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          color: CustomColors.pink,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3.0),
        ),
        child: Icon(
          Icons.clear_rounded,
          color: Colors.white,
          size: 40.0,
        ),
      ),
      color: Colors.transparent,
    ),
  ];

  List<Widget> _doneHabitPrimaryAction = [
    IconSlideAction(
      iconWidget: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          color: CustomColors.yellow,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3.0),
        ),
        child: Icon(
          Icons.cached_rounded,
          color: Colors.white,
          size: 40.0,
        ),
      ),
      color: Colors.transparent,
    ),
  ];

  List<Widget> _canceledHabitPrimaryAction = [
    IconSlideAction(
      iconWidget: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          color: CustomColors.yellow,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3.0),
        ),
        child: Icon(
          Icons.refresh_rounded,
          color: Colors.white,
          size: 40.0,
        ),
      ),
      color: Colors.transparent,
    ),
  ];

  List<Widget> _habitSecondaryAction = [
    IconSlideAction(
      iconWidget: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          color: CustomColors.yellow,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3.0),
        ),
        child: Icon(
          Icons.create_rounded,
          color: Colors.white,
          size: 40.0,
        ),
      ),
      color: Colors.transparent,
    ),
    IconSlideAction(
      iconWidget: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          color: CustomColors.pink,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3.0),
        ),
        child: Icon(
          Icons.delete_outline_rounded,
          color: Colors.white,
          size: 40.0,
        ),
      ),
      color: Colors.transparent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Slidable(
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 0.15,
      direction: Axis.horizontal,
      actions: this.widget.habitTileType == HabitTileType.general
          ? null
          : (this.widget.habitStatus == HabitStatus.doing
              ? _doingHabitPrimaryAction
              : (this.widget.habitStatus == HabitStatus.done
                  ? _doneHabitPrimaryAction
                  : _canceledHabitPrimaryAction)),
      secondaryActions: _habitSecondaryAction,
      child: HabitTile(
        habitTileType: this.widget.habitTileType,
        habitName: this.widget.name,
        icon: this.widget.icon,
        habitTime: this.widget.time,
        goal: this.widget.goal,
        goalCompleted: this.widget.goalCompleted,
        goalUnit: this.widget.unitGoal,
        habitStatus: this.widget.habitStatus,
        isImportant: this.widget.isImportant,
        startDate: this.widget.startDate,
        endDate: this.widget.endDate,
      ),
    );
  }
}
