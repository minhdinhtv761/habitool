import 'package:flutter/material.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:habitool/model/habit_model.dart';
import 'package:habitool/view/screen/dashboard/progress_dialog.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../custom_values/custom_colors.dart';
import '../custom_values/custom_type.dart';

class HabitTile extends StatefulWidget {
  HabitTileType habitTileType;
  HabitModel habitModel;
  int goalCompleted;
  HabitStatus habitStatus = HabitStatus.doing;
  DateTime now;

  HabitTile({
    this.habitTileType,
    this.habitModel,
    @required this.now,
    this.goalCompleted,
    this.habitStatus,
  });

  @override
  _HabitTileState createState() => _HabitTileState();
}

class _HabitTileState extends State<HabitTile> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    //Lấy ngày hôm nay (không lấy giờ)
    DateTime dateNow = DateTime(
        this.widget.now.year, this.widget.now.month, this.widget.now.day);
    //
    //progressColor
    //
    Color dailyColor = (this.widget.habitStatus == HabitStatus.doing
        ? CustomColors.pink
        : (this.widget.habitStatus == HabitStatus.done
            ? CustomColors.blue
            : CustomColors.grey));
    Color genderalColor = (dateNow.isBefore(this.widget.habitModel.startDate)
        ? CustomColors.blue
        : (dateNow.isAfter(this.widget.habitModel.endDate)
            ? CustomColors.grey
            : CustomColors.pink));
    //
    //NameColor
    //
    Color dailyColorText = (this.widget.habitStatus == HabitStatus.doing
        ? CustomColors.black
        : (this.widget.habitStatus == HabitStatus.done
            ? CustomColors.blue
            : CustomColors.grey));
    Color genderalColorText =
        (dateNow.isBefore(this.widget.habitModel.startDate)
            ? CustomColors.blue
            : (dateNow.isAfter(this.widget.habitModel.endDate)
                ? CustomColors.grey
                : CustomColors.black));
    return GestureDetector(
      child: Container(
        width: size.width * 0.85,
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(children: <Widget>[
                Container(
                  width: 60.0,
                  height: 60.0,
                  child: CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 3.0,
                    percent: this.widget.habitTileType == HabitTileType.general
                        ? 1.0
                        : (this.widget.habitStatus == HabitStatus.doing
                            ? this.widget.goalCompleted /
                                this.widget.habitModel.goal
                            : (this.widget.habitStatus == HabitStatus.done
                                ? 1.0
                                : 0.0)),
                    center: Icon(
                      this.widget.habitModel.icon,
                      color: (this.widget.habitTileType ==
                              HabitTileType.dailyProgress
                          ? dailyColor
                          : genderalColor),
                    ),
                    animation: false,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: (this.widget.habitTileType ==
                            HabitTileType.dailyProgress
                        ? dailyColor
                        : genderalColor),
                    backgroundColor: CustomColors.grey,
                  ),
                ),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: this.widget.habitTileType == HabitTileType.general
                          ? (dateNow.add(Duration(seconds: 5)).isAfter(
                                      this.widget.habitModel.startDate) &&
                                  (dateNow.isBefore(this
                                          .widget
                                          .habitModel
                                          .endDate
                                          .add(Duration(seconds: 5))) ||
                                      this.widget.habitModel.endDate == null)
                              ? Colors.transparent
                              : Colors.white)
                          : (this.widget.habitStatus == HabitStatus.doing
                              ? Colors.transparent
                              : Colors.white),
                    ),
                    child: Icon(
                      this.widget.habitTileType == HabitTileType.general
                          ? (this.widget.habitModel.endDate != null &&
                                  dateNow.isBefore(
                                      this.widget.habitModel.startDate)
                              ? Icons.watch_later_outlined
                              : (dateNow.isAfter(this.widget.habitModel.endDate)
                                  ? Icons.cancel_rounded
                                  : null))
                          : (this.widget.habitStatus == HabitStatus.done
                              ? Icons.check_circle_rounded
                              : (this.widget.habitStatus == HabitStatus.canceled
                                  ? Icons.cancel_rounded
                                  : null)),
                      color: this.widget.habitTileType == HabitTileType.general
                          ? (dateNow.isBefore(this.widget.habitModel.startDate)
                              ? CustomColors.blue
                              : CustomColors.pink)
                          : (this.widget.habitStatus == HabitStatus.done
                              ? CustomColors.blue
                              : CustomColors.pink),
                      size: 18.0,
                    ),
                  ),
                ),
              ]),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(
                          !this.widget.habitModel.isImportant
                              ? Icons.star_border_rounded
                              : Icons.star_rounded,
                          size: 18.0,
                          color: !this.widget.habitModel.isImportant
                              ? CustomColors.grey
                              : Colors.amber,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        this.widget.habitModel.name,
                        style: TextStyle(
                          color:
                              this.widget.habitTileType == HabitTileType.general
                                  ? genderalColorText
                                  : dailyColorText,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.alarm_rounded,
                        size: 16.0,
                        color: CustomColors.darkgrey,
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        this.widget.habitModel.time.hour.toString() +
                            ':' +
                            this.widget.habitModel.time.minute.toString(),
                        style: TextStyle(
                          color: CustomColors.darkgrey,
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    this.widget.habitTileType == HabitTileType.general
                        ? this.widget.habitModel.goal.toString()
                        : (this.widget.goalCompleted.toString() +
                            '/' +
                            this.widget.habitModel.goal.toString()),
                    style: TextStyle(
                        color: this.widget.habitTileType ==
                                HabitTileType.general
                            ? (dateNow.add(Duration(seconds: 5)).isAfter(
                                        this.widget.habitModel.startDate) &&
                                    (dateNow.isBefore(this
                                            .widget
                                            .habitModel
                                            .endDate
                                            .add(Duration(seconds: 5))) ||
                                        this.widget.habitModel.endDate == null)
                                ? CustomColors.pink
                                : CustomColors.grey)
                            : (this.widget.habitStatus == HabitStatus.doing
                                ? CustomColors.pink
                                : (this.widget.habitStatus == HabitStatus.done
                                    ? CustomColors.blue
                                    : CustomColors.grey)),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    this.widget.habitModel.unitGoal,
                    style: TextStyle(
                      color: this.widget.habitTileType == HabitTileType.general
                          ? (dateNow.add(Duration(seconds: 5)).isAfter(
                                      this.widget.habitModel.startDate) &&
                                  (dateNow.isBefore(this
                                          .widget
                                          .habitModel
                                          .endDate
                                          .add(Duration(seconds: 5))) ||
                                      this.widget.habitModel.endDate == null)
                              ? CustomColors.pink
                              : CustomColors.grey)
                          : (this.widget.habitStatus == HabitStatus.doing
                              ? CustomColors.pink
                              : (this.widget.habitStatus == HabitStatus.done
                                  ? CustomColors.blue
                                  : CustomColors.grey)),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        if (this.widget.habitTileType == HabitTileType.dailyProgress &&
            this.widget.habitStatus == HabitStatus.doing &&
            dateNow.isBefore(DateTime.now())) {
          showGeneralDialog(
              context: context,
              pageBuilder: (_, __, ___) => ProgressDialog(
                    habitModel: this.widget.habitModel,
                    completed: this.widget.goalCompleted,
                    date: dateNow,
                  ));
        }
      },
      onLongPress: () {},
    );
  }
}
