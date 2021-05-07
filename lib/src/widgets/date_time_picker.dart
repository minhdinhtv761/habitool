import 'package:flutter/material.dart';

import 'package:habitool/src/custom_values/custom_colors.dart';

class HabitoolDateTimePicker extends StatefulWidget {
  @override
  _HabitoolDateTimePickerState createState() => _HabitoolDateTimePickerState();
}

class _HabitoolDateTimePickerState extends State<HabitoolDateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.blue,
      body: Container(
        height: 100.0,
        margin: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    color: CustomColors.black,
                    icon: Icon(Icons.arrow_back_ios_rounded),
                    onPressed: () {},
                  ),
                  Expanded(
                  )
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}