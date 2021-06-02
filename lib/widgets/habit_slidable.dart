import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../custom_values/custom_colors.dart';
import '../custom_values/custom_type.dart';
import '../widgets/habit_tile.dart';

class HabitSlidable extends StatefulWidget {
  String habitName;
  DateTime habitTime;
  String goalUnit;
  int goal;
  int goalCompleted;
  bool isImportant;
  HabitStatus habitStatus;

  HabitSlidable({
    Key key,
    @required this.habitName,
    @required this.habitTime,
    @required this.goalUnit,
    @required this.goal,
    @required this.goalCompleted,
    @required this.isImportant,
    @required this.habitStatus,
  }) : super(key: key);
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
      actions: this.widget.habitStatus == HabitStatus.doing
          ? _doingHabitPrimaryAction
          : (this.widget.habitStatus == HabitStatus.done
              ? _doneHabitPrimaryAction
              : _canceledHabitPrimaryAction),
      secondaryActions: _habitSecondaryAction,
      child: HabitTile(
        habitName: this.widget.habitName,
        habitTime: this.widget.habitTime,
        goal: this.widget.goal,
        goalCompleted: this.widget.goalCompleted,
        goalUnit: this.widget.goalUnit,
        habitStatus: this.widget.habitStatus,
        isImportant: this.widget.isImportant,
      ),
    );
  }
}
