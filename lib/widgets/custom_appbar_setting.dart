import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/view/screen/achivement/achievement_screen.dart';
import 'package:habitool/view/screen/achivement/social_screen.dart';
import 'package:habitool/view/screen/dashboard/dashboard_screen.dart';
import 'package:habitool/view/screen/home_screen.dart';
import 'package:habitool/view/screen/user/user_screen.dart';

class CustomAppBarUser extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBarUser({Key key, this.title, this.actionText, this.action})
      : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  final Size preferredSize;
  final String title;
  final String actionText;
  final Function action;

  @override
  _CustomAppBarUserState createState() => _CustomAppBarUserState();
}

class _CustomAppBarUserState extends State<CustomAppBarUser> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: CustomColors.light,
        shadowColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: CustomColors.black),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(context);
            }),
        title: Text(
          this.widget.title,
          style: TextStyle(
            color: CustomColors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(this.widget.actionText,
                style: TextStyle(fontSize: 14, color: CustomColors.link)),
            onPressed: this.widget.action,
          )
        ]);
  }
}
