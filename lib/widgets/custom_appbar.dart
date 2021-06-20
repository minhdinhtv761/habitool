import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key key, this.title, this.action})
      : preferredSize = Size.fromHeight(60.0),
        super(key: key);
  @override
  final Size preferredSize;
  final String title;
  final String action;
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: CustomColors.light,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: CustomColors.black),
          onPressed: () {},
        ),
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
            child: Text(this.widget.action,
                style: TextStyle(fontSize: 18, color: CustomColors.link)),
            onPressed: () {
              print('Saved');
            },
          )
        ]);
  }
}
