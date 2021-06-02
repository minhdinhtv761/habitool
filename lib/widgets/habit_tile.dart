import 'package:flutter/material.dart';

import 'package:habitool/Custom_Values/custom_colors.dart';

class HabitTile extends StatefulWidget {
  @override
  _HabitTileState createState() => _HabitTileState();
}

class _HabitTileState extends State<HabitTile> {
  String _habitName = "Habit's name";
  DateTime _habitTime = DateTime.now();
  String _goalUnit;
  int _goal;
  int _goalCompleted;
  bool _isImportant = false;
  bool _isCanceled;
  bool _isCompleted;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
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
              Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(
                          BorderSide(color: CustomColors.grey, width: 2.0)))),
              SizedBox(width: 5.0),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    IconButton(
                      padding: EdgeInsets.all(0.0),
                      icon: Icon(!this._isImportant
                          ? Icons.star_border_rounded
                          : Icons.star_rounded),
                      color:
                          !this._isImportant ? CustomColors.grey : Colors.amber,
                      iconSize: 18.0,
                      onPressed: () {
                        setState(() {
                          this._isImportant = !this._isImportant;
                        });
                      },
                    ),
                    Positioned(
                      top: 5.0,
                      left: 35.0,
                      child: Text(
                        this._habitName,
                        style: TextStyle(
                          color: CustomColors.black,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.alarm_rounded,
                      size: 16.0,
                      color: CustomColors.grey,
                    ),
                    Text(
                      this._habitTime.hour.toString() +
                          ':' +
                          this._habitTime.minute.toString(),
                      style: TextStyle(
                        color: CustomColors.grey,
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              )
              // Container(
              // margin: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
              // child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: <Widget>[
              //         IconButton(
              //           padding: EdgeInsets.all(8.0),
              //           icon: Icon(!this._isImportant ? Icons.star_border_rounded : Icons.star_rounded),
              //           color: !this._isImportant ? CustomColors.grey : Colors.amber,
              //           iconSize: 18.0,
              //           onPressed: () {
              //             setState(() {
              //               this._isImportant = !this._isImportant;
              //             });
              //           },
              //         ),
              //         Text(
              //           this._habitName,
              //           style: TextStyle(
              //             color: CustomColors.black,
              //             fontSize: 13.0,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ],
              //     ),
              //     Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: <Widget>[
              //         // Icon(
              //         //   Icons.alarm_rounded,
              //         //   size: 16.0,
              //         //   color: CustomColors.grey,
              //         // ),
              //         Text(
              //           this._habitTime.hour.toString() + ':' + this._habitTime.minute.toString(),
              //           style: TextStyle(
              //             color: CustomColors.grey,
              //             fontSize: 11.0,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // )
              // )
            ],
          )),
    );
  }
}
