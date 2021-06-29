import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/functions/dashboard_function.dart';
import 'package:habitool/functions/habit_functions.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/services/habit_services.dart';

import '../custom_values/custom_colors.dart';
import '../custom_values/custom_type.dart';
import '../widgets/habit_tile.dart';

import 'package:provider/provider.dart';

class HabitSlidable extends StatefulWidget {
  HabitModel habitModel;
  HabitTileType habitTileType;
  int goalCompleted;
  HabitStatus habitStatus;
  DateTime date;
  HabitSlidable({
    @required this.habitTileType,
    @required this.habitModel,
    this.date,
    this.goalCompleted,
    this.habitStatus,
  });
  @override
  _HabitSlidableState createState() => _HabitSlidableState();
}

class _HabitSlidableState extends State<HabitSlidable> {
  DateTime dateNow;

  @override
  Widget build(BuildContext context) {
    dateNow = DateTime(
        this.widget.date.year, this.widget.date.month, this.widget.date.day);

    List<Widget> _doingHabitPrimaryAction = [
      //Đánh dấu hoàn thành - Check
      IconSlideAction(
        onTap: () => DashboardFunction.handelHabitSelectedOption(
          this.widget.habitModel,
          HabitSelectedOption.CHECK,
          context,
          date: this.dateNow,
          completed: this.widget.goalCompleted,
        ),
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

      //Đánh dấu hủy - cancel
      IconSlideAction(
        onTap: () => DashboardFunction.handelHabitSelectedOption(
          this.widget.habitModel,
          HabitSelectedOption.CANCEL,
          context,
          date: this.dateNow,
          completed: this.widget.goalCompleted,
        ),
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

//Quay về ban đầu - Reset
    List<Widget> _doneHabitPrimaryAction = [
      IconSlideAction(
        onTap: () => DashboardFunction.handelHabitSelectedOption(
          this.widget.habitModel,
          HabitSelectedOption.RESET,
          context,
          date: this.dateNow,
        ),
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

//Quay về đang thực hiện - refresh
    List<Widget> _canceledHabitPrimaryAction = [
      IconSlideAction(
        onTap: () => DashboardFunction.handelHabitSelectedOption(
          this.widget.habitModel,
          HabitSelectedOption.REFRESH,
          context,
          date: this.dateNow,
          completed: this.widget.goalCompleted,
        ),
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
      //Xóa thói quen
      IconSlideAction(
        onTap: () => DashboardFunction.handelHabitSelectedOption(
            this.widget.habitModel, HabitSelectedOption.DEL, context,
            habitTileType: this.widget.habitTileType,
            habitStatus: this.widget.habitStatus),
        iconWidget: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            color: CustomColors.pink,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3.0),
          ),
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40.0,
          ),
        ),
        color: Colors.transparent,
      ),

//chuyển đến trang chỉnh sửa
      Visibility(
        visible: !(this.widget.habitTileType == HabitTileType.general &&
            this.widget.habitStatus == HabitStatus.done),
        child: IconSlideAction(
          onTap: () => DashboardFunction.handelHabitSelectedOption(
              this.widget.habitModel, HabitSelectedOption.EDIT, context,
              habitTileType: this.widget.habitTileType,
              habitStatus: this.widget.habitStatus),
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
      ),
    ];

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
        habitModel: this.widget.habitModel,
        goalCompleted: this.widget.goalCompleted,
        now: this.widget.date,
        habitStatus: this.widget.habitStatus,
        habitTileType: this.widget.habitTileType,
      ),
    );
  }
}
