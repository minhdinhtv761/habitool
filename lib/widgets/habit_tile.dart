import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../custom_values/custom_colors.dart';
import '../custom_values/custom_type.dart';

class HabitTile extends StatefulWidget {
  String habitName;
  DateTime habitTime;
  String goalUnit;
  int goal;
  int goalCompleted;
  bool isImportant;
  HabitStatus habitStatus;

  HabitTile({
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
  _HabitTileState createState() => _HabitTileState();
}

class _HabitTileState extends State<HabitTile> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
                    percent: this.widget.habitStatus == HabitStatus.doing
                        ? this.widget.goalCompleted / this.widget.goal
                        : (this.widget.habitStatus == HabitStatus.done
                            ? 1.0
                            : 0.0),
                    center: Icon(
                      Icons.android_rounded,
                      color: CustomColors.blue,
                    ),
                    animation: false,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: this.widget.habitStatus == HabitStatus.doing
                        ? CustomColors.pink
                        : CustomColors.blue,
                    backgroundColor: CustomColors.grey,
                  ),
                ),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: this.widget.habitStatus == HabitStatus.doing
                          ? Colors.transparent
                          : Colors.white,
                    ),
                    child: Icon(
                      this.widget.habitStatus == HabitStatus.done
                          ? Icons.check_circle_rounded
                          : (this.widget.habitStatus == HabitStatus.canceled
                              ? Icons.cancel_rounded
                              : null),
                      color: this.widget.habitStatus == HabitStatus.done
                          ? CustomColors.blue
                          : CustomColors.pink,
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
                        onTap: () {
                          setState(() {
                            this.widget.isImportant = !this.widget.isImportant;
                          });
                        },
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        this.widget.habitName,
                        style: TextStyle(
                          color: this.widget.habitStatus == HabitStatus.doing
                              ? CustomColors.black
                              : (this.widget.habitStatus == HabitStatus.done
                                  ? CustomColors.blue
                                  : CustomColors.grey),
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
                    this.widget.goalCompleted.toString() +
                        '/' +
                        this.widget.goal.toString(),
                    style: TextStyle(
                        color: this.widget.habitStatus == HabitStatus.doing
                            ? CustomColors.pink
                            : (this.widget.habitStatus == HabitStatus.done
                                ? CustomColors.blue
                                : CustomColors.grey),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    this.widget.goalUnit.toString(),
                    style: TextStyle(
                      color: this.widget.habitStatus == HabitStatus.doing
                          ? CustomColors.pink
                          : (this.widget.habitStatus == HabitStatus.done
                              ? CustomColors.blue
                              : CustomColors.grey),
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
