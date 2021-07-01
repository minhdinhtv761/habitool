import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/model/methods.dart';
import 'package:habitool/view/screen/intro/login_screen.dart';
import 'package:habitool/view/screen/user/infomation_screen.dart';
import 'package:habitool/view/screen/user/setting_screen.dart';
import 'package:habitool/widgets/body_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:habitool/view/screen/user';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.light,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          buildSliverAppBar(size),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.075),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Cài đặt',
                style: TextStyle(
                  color: CustomColors.pink,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.035, vertical: size.height * 0.0005),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  Card(
                    color: Colors.white,
                    elevation: 0,
                    margin: EdgeInsets.only(
                        top: 20.0, bottom: 10, left: 15, right: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InfomationUserScreen()),
                            );
                          },
                          child: Container(
                            child: BodyMenu(
                              icon: Icons.person,
                              title: 'Thông tin cá nhân',
                              content: 'Nguyễn Văn B',
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        // BodyMenu(
                        //   icon: Icons.settings,
                        //   title: 'Cài đặt ứng dụng',
                        //   content: '',
                        // ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingScreen()),
                            );
                          },
                          child: Container(
                            child: BodyMenu(
                              icon: Icons.person,
                              title: 'Cài đặt ứng dụng',
                              content: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.075),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Trợ giúp & hỗ trợ',
                style: TextStyle(
                  color: CustomColors.pink,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.035, vertical: size.height * 0.0005),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  Card(
                    color: Colors.white,
                    elevation: 0,
                    margin: EdgeInsets.only(
                        top: 20.0, bottom: 10, left: 15, right: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        BodyMenu(
                          icon: Icons.help,
                          title: 'Trợ giúp',
                          content: '',
                        ),
                        Divider(
                          height: 1,
                        ),
                        BodyMenu(
                          icon: Icons.warning,
                          title: 'Báo cáo sự cố',
                          content: '',
                        ),
                        Divider(
                          height: 1,
                        ),
                        BodyMenu(
                          icon: Icons.book,
                          title: 'Điều khoản sử dụng',
                          content: '',
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: CustomColors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: Size(
                          size.width / 1.2,
                          size.height / 14,
                        ),
                      ),
                      child: Text('Đăng xuất',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogInScreen()),
                        );
                      },
                      onLongPress: () {},
                    ),
                  )
                ],
              ),
            ),
          ),

          // SliverToBoxAdapter dùng để làm phần trống, tránh việc dữ liệu bị che dưới BottomAppBar
          SliverToBoxAdapter(
              child: Container(height: 90.0, color: Colors.transparent)),
        ],
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: CustomColors.blue,
      child: Text(
        'Đăng xuất',
        style: TextStyle(
          color: CustomColors.light,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {},
    );
  }

  SliverAppBar buildSliverAppBar(Size size) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: false,
      toolbarHeight: 100.0,
      backgroundColor: CustomColors.blue,
      shadowColor: Colors.transparent,
      title: Row(children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Cá Nhân Hóa',
              style: TextStyle(
                color: CustomColors.light,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.0,
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
                height: 110.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: buildTableInfo() //Để tạm vài bữa sủa lại
                ),
          ],
        ),
        preferredSize: Size.fromHeight(140.0),
      ),
    );
  }

  Column buildTableInfo() {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Container(
              margin: EdgeInsets.all(20.0),
              width: 70.0,
              height: 70.0,
              decoration: BoxDecoration(
                color: CustomColors.grey,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Nguyễn Văn B',
                  style: TextStyle(
                    color: CustomColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Text(
                  'Logged in with facebook',
                  style: TextStyle(
                    color: CustomColors.darkgrey,
                    fontSize: 14,
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
