import 'package:flutter/material.dart';
import 'package:habitool/custom_values/enums.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../custom_values/custom_colors.dart';
import '../custom_values/custom_type.dart';

class HabitTile extends StatefulWidget {
  HabitTileType habitTileType;
  String habitName;
  DateTime habitTime;
  IconData icon;
  String goalUnit;
  int goal;
  int goalCompleted;
  bool isImportant;
  DateTime startDate;
  DateTime endDate;
  HabitStatus habitStatus = HabitStatus.doing;

  HabitTile({
    Key key,
    @required this.habitTileType,
    @required this.habitName,
    @required this.icon,
    @required this.habitTime,
    @required this.goalUnit,
    @required this.goal,
    this.goalCompleted,
    @required this.isImportant,
    @required this.startDate,
    this.endDate,
    this.habitStatus,
  }) : super(key: key);

  @override
  _HabitTileState createState() => _HabitTileState();
}

class _HabitTileState extends State<HabitTile> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    //
    //progressColor
    //
    Color dailyColor = (this.widget.habitStatus == HabitStatus.doing
        ? CustomColors.pink
        : (this.widget.habitStatus == HabitStatus.done
            ? CustomColors.blue
            : CustomColors.grey));
    Color genderalColor = (DateTime.now().isBefore(this.widget.startDate)
        ? CustomColors.blue
        : (DateTime.now().isAfter(this.widget.endDate)
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
    Color genderalColorText = (DateTime.now().isBefore(this.widget.startDate)
        ? CustomColors.blue
        : (DateTime.now().isAfter(this.widget.endDate)
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
                        ? 0.0
                        : (this.widget.habitStatus == HabitStatus.doing
                            ? this.widget.goalCompleted / this.widget.goal
                            : (this.widget.habitStatus == HabitStatus.done
                                ? 1.0
                                : 0.0)),
                    center: Icon(
                      widget.icon,
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
                          ? (DateTime.now().isAfter(this.widget.startDate) &&
                                  (DateTime.now()
                                          .isBefore(this.widget.endDate) ||
                                      this.widget.endDate == null)
                              ? Colors.transparent
                              : Colors.white)
                          : (this.widget.habitStatus == HabitStatus.doing
                              ? Colors.transparent
                              : Colors.white),
                    ),
                    child: Icon(
                      this.widget.habitTileType == HabitTileType.general
                          ? (this.widget.endDate != null &&
                                  DateTime.now().isBefore(this.widget.startDate)
                              ? Icons.watch_later_outlined
                              : (DateTime.now().isAfter(this.widget.endDate)
                                  ? Icons.cancel_rounded
                                  : null))
                          : (this.widget.habitStatus == HabitStatus.done
                              ? Icons.check_circle_rounded
                              : (this.widget.habitStatus == HabitStatus.canceled
                                  ? Icons.cancel_rounded
                                  : null)),
                      color: this.widget.habitTileType == HabitTileType.general
                          ? (DateTime.now().isBefore(this.widget.startDate)
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
                          !this.widget.isImportant
                              ? Icons.star_border_rounded
                              : Icons.star_rounded,
                          size: 18.0,
                          color: !this.widget.isImportant
                              ? CustomColors.grey
                              : Colors.amber,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        this.widget.habitName,
                        style: TextStyle(
                          color:
                              this.widget.habitTileType == HabitTileType.general
                                  ? genderalColorText
                                  : dailyColorText,
                          fontSize: 13.0,
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
                        color: CustomColors.grey,
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        this.widget.habitTime.hour.toString() +
                            ':' +
                            this.widget.habitTime.minute.toString(),
                        style: TextStyle(
                          color: CustomColors.grey,
                          fontSize: 11.0,
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
                        ? this.widget.goal.toString()
                        : this.widget.goalCompleted.toString() +
                            '/' +
                            this.widget.goal.toString(),
                    style: TextStyle(
                        color: this.widget.habitTileType ==
                                HabitTileType.general
                            ? (DateTime.now().isAfter(this.widget.startDate) &&
                                    (DateTime.now()
                                            .isBefore(this.widget.endDate) ||
                                        this.widget.endDate == null)
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
                    this.widget.goalUnit.toString(),
                    style: TextStyle(
                      color: this.widget.habitTileType == HabitTileType.general
                          ? (DateTime.now().isAfter(this.widget.startDate) &&
                                  (DateTime.now()
                                          .isBefore(this.widget.endDate) ||
                                      this.widget.endDate == null)
                              ? CustomColors.pink
                              : CustomColors.grey)
                          : (this.widget.habitStatus == HabitStatus.doing
                              ? CustomColors.pink
                              : (this.widget.habitStatus == HabitStatus.done
                                  ? CustomColors.blue
                                  : CustomColors.grey)),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {},
      onLongPress: () {},
    );
  }
}
