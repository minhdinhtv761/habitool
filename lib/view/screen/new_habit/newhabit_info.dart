import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/custom_values/custom_colors.dart';

import '../../../widgets/body_menu.dart';
import 'date_picker.dart';

class NewHabitInfo extends StatefulWidget {
  @override
  _NewHabitInfo createState() => _NewHabitInfo();
}

class _NewHabitInfo extends State<NewHabitInfo> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Material(
      color: CustomColors.light,
      child: Column(
        children: <Widget>[
          NameBox(),
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
                  content: '21/05/2021',
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
                  content: 'Không',
                ),
                Divider(
                  height: 1,
                ),
                BodyMenu(
                  title: 'Kết thúc lặp',
                  content: 'Không',
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
              content: '11:24',
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

class NameBox extends StatefulWidget {
  @override
  _NameBoxState createState() => _NameBoxState();
}

class _NameBoxState extends State<NameBox> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool _isObscure = false;

    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.only(top: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
            color: CustomColors.pink,
            fontSize: 18,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Tên thói quen',
          hintStyle: TextStyle(
              color: CustomColors.grey,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          prefixIcon: IconButton(
            icon: !_isObscure ? Icon(Icons.star_border) : Icon(Icons.star),
            color: !_isObscure ? CustomColors.grey : Colors.yellow,
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5, right: 18),
            child: Material(
              type: MaterialType.transparency,
              child: Ink(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: CustomColors.pink,
                    width: 1,
                  ),
                ),
                child: IconButton(
                  icon: Icon(Icons.ac_unit),
                  color: CustomColors.pink,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
