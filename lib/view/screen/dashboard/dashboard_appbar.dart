import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/custom_values/custom_type.dart';
import 'package:habitool/model/profile/user_profile.dart';
import 'package:habitool/view/screen/dashboard/dashboard_calendar.dart';
import 'package:provider/provider.dart';
import 'package:habitool/provider/user_provider.dart';

class DashboardAppBar extends StatefulWidget {
  DashboardAppBar({Key key, this.callback}) : super(key: key);

  DateTimeCallback callback;

  @override
  _DashboardAppBarState createState() => _DashboardAppBarState();
}

class _DashboardAppBarState extends State<DashboardAppBar> {
  String email;
  UserData user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).user;
    email = user.email;
    //avatar = user.urlAvt;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
              email,
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
