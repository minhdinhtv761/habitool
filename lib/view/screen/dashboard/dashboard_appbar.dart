import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/model/profile/user_profile.dart';
import 'package:habitool/view/screen/dashboard/dashboard_calendar.dart';
import 'package:provider/provider.dart';
import 'package:habitool/provider/user_provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardAppBar extends StatefulWidget {
  DashboardAppBar({Key key, this.callback}) : super(key: key);

  final DateTimeCallback callback;

  @override
  _DashboardAppBarState createState() => _DashboardAppBarState();
}

class _DashboardAppBarState extends State<DashboardAppBar> {
  String name;
  String avatar;
  UserData user;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //
    user = Provider.of<UserProvider>(context).user;
    avatar = user.urlAvt;
    name = user.displayName;
    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: false,
      toolbarHeight: 100.0,
      backgroundColor: CustomColors.blue,
      shadowColor: Colors.transparent,
      title: Row(children: <Widget>[
        Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
            color: CustomColors.grey,
            shape: BoxShape.circle,
          ),
          child: Consumer<UserProvider>(builder: (context, provider, child) {
            return ClipOval(
              child: provider.user.urlAvt != ""
                  ? Image.network(
                      provider.user.urlAvt,
                      fit: BoxFit.fill,
                    )
                  : Container(),
            );
          }),
          // child: ClipOval(
          //   child: avatar != null && avatar != ""
          //       ? Image.network(
          //           avatar,
          //           fit: BoxFit.fill,
          //         )
          //       : Container(),
          // ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Xin chào,',
              style: TextStyle(
                color: CustomColors.light,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              name,
              style: TextStyle(
                color: CustomColors.light,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ]),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          height: 100,
          decoration: BoxDecoration(
            color: CustomColors.blue,
          ),
        ),
      ),
      bottom: PreferredSize(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Container(
              height: 140.0,
              decoration: BoxDecoration(
                color: CustomColors.light,
              ),
            ),
            Container(
              height: 60.0,
              decoration: BoxDecoration(
                color: CustomColors.blue,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30.0)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 10),
              padding: EdgeInsets.only(right: 12, left: 12),
              width: size.width * 0.85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: DashboardCalendar(
                callback: this.widget.callback,
              ),
            ),
          ],
        ),
        preferredSize: Size.fromHeight(140.0),
      ),
    );
  }
}
