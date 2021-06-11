import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../custom_values/custom_colors.dart';
import '../../../widgets/habit_namebox.dart';
import '../../../widgets/body_menu.dart';
import '../../../widgets/date_picker.dart';

class HabitInfo extends StatefulWidget {
  HabitInfo(
      {Key key,
      @required this.habitName,
      @required this.habitTime,
      @required this.goalUnit,
      @required this.goal,
      @required this.isImportant,
      @required this.startDate,
      @required this.endDate,
      @required this.repeat,
      @required this.note});

  String habitName;
  DateTime habitTime;
  String goalUnit;
  int goal;
  bool isImportant;
  DateTime startDate;
  DateTime endDate;
  String repeat;
  String note;

  @override
  _HabitInfo createState() => _HabitInfo();
}

class _HabitInfo extends State<HabitInfo> {
  DateTime selectedDate = DateTime.now();

  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    this._noteController.text = this.widget.note;
  }

  @override
  void dispose() {
    this._noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Material(
      color: CustomColors.light,
      child: Column(
        children: <Widget>[
          NameBox(
            habitName: this.widget.habitName,
            isImportant: this.widget.isImportant,
          ),
          Card(
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.only(top: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: <Widget>[
                BodyMenu(
                  icon: Icons.calendar_today,
                  title: 'Bắt đầu',
                  content: this.widget.startDate.day.toString() +
                      '/' +
                      this.widget.startDate.month.toString() +
                      '/' +
                      this.widget.startDate.year.toString(),
                  press: () {
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (_, __, ___) => DatePicker(
                        height: size.height * 0.45,
                        width: size.width * 0.8,
                      ),
                      transitionBuilder: (_, anim, __, child) {
                        return SlideTransition(
                          position:
                              Tween(begin: Offset(0, 1), end: Offset(0, 0))
                                  .animate(anim),
                          child: child,
                        );
                      },
                    );
                  },
                ),
                Divider(
                  height: 1,
                ),
                BodyMenu(
                  icon: FontAwesomeIcons.bullseye,
                  title: 'Mục tiêu',
                  content:
                      this.widget.goal.toString() + ' ' + this.widget.goalUnit,
                ),
                Divider(
                  height: 1,
                ),
                BodyMenu(
                  title: 'Kết thúc lặp',
                  content: this.widget.endDate == null
                      ? 'Không'
                      : this.widget.endDate.day.toString() +
                          '/' +
                          this.widget.endDate.month.toString() +
                          '/' +
                          this.widget.endDate.year.toString(),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.only(top: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: BodyMenu(
              icon: FontAwesomeIcons.clock,
              title: 'Thời gian thực hiện',
              content: this.widget.habitTime.hour.toString() +
                  ':' +
                  this.widget.habitTime.minute.toString(),
            ),
          ),
          Card(
              color: Colors.white,
              elevation: 0,
              margin: EdgeInsets.only(top: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: this._noteController,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  color: CustomColors.pink,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Ghi chú',
                  hintStyle: TextStyle(
                      color: CustomColors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  prefixIcon: Icon(
                    FontAwesomeIcons.stickyNote,
                    color: CustomColors.grey,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
