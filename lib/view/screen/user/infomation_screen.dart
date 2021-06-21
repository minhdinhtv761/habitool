import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/view/screen/user/user_info.dart';
import 'package:habitool/view/screen/user/widgets/user_avatar.dart';
import 'package:habitool/widgets/custom_appbar.dart';

class InfomationUserScreen extends StatefulWidget {
  const InfomationUserScreen({Key key}) : super(key: key);

  @override
  _InfomationUserScreenState createState() => _InfomationUserScreenState();
}

class _InfomationUserScreenState extends State<InfomationUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.light,
      appBar: CustomAppBar(
        title: 'Thông tin cá nhân',
        actionText: 'Lưu',
      ),
      body: ListView(
        children: [
          //  UserAvatar(),
          UserInfo(),
        ],
      ),
    );
  }
}
