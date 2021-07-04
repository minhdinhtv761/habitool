import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/IconPicker/icons.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/model/methods.dart';
import 'package:habitool/model/profile/user_profile.dart';
import 'package:habitool/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:habitool/widgets/body_menu.dart';
import 'package:habitool/widgets/custom_card.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class SettingScreen extends StatefulWidget {
  final UserData currentUser;

  SettingScreen({this.currentUser});

  @override
  _SettingScreen createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.light,
      appBar: AppBar(
        backgroundColor: CustomColors.light,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: CustomColors.black),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Cài đặt ứng dụng',
          style: TextStyle(
            color: CustomColors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
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
                          child: Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.dark_mode,
                                    color: CustomColors.darkgrey,
                                  ),
                                  Expanded(
                                    child: Text(
                                      ' Chế độ ban đêm',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: CustomColors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  LiteRollingSwitch(
                                    //initial value
                                    value: true,
                                    textOn: 'On',
                                    textOff: 'Off',
                                    colorOn: Colors.green,
                                    colorOff: Colors.grey,
                                    iconOn: Icons.done,
                                    iconOff: Icons.remove_circle_outline,
                                    textSize: 14.0,
                                    onChanged: (bool state) {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        GestureDetector(
                          child: Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.notifications,
                                    color: CustomColors.darkgrey,
                                  ),
                                  Expanded(
                                    child: Text(
                                      ' Thông báo',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: CustomColors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  LiteRollingSwitch(
                                    //initial value
                                    value: true,
                                    textOn: 'On',
                                    textOff: 'Off',
                                    colorOn: Colors.green,
                                    colorOff: Colors.grey,
                                    iconOn: Icons.done,
                                    iconOff: Icons.remove_circle_outline,
                                    textSize: 14.0,
                                    onChanged: (bool state) {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        GestureDetector(
                          child: Container(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.mic_rounded,
                                    color: CustomColors.darkgrey,
                                  ),
                                  Expanded(
                                    child: Text(
                                      ' Âm thanh',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: CustomColors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  LiteRollingSwitch(
                                    //initial value
                                    value: true,
                                    textOn: 'On',
                                    textOff: 'Off',
                                    colorOn: Colors.green,
                                    colorOff: Colors.grey,
                                    iconOn: Icons.done,
                                    iconOff: Icons.remove_circle_outline,
                                    textSize: 14.0,
                                    onChanged: (bool state) {},
                                  ),
                                ],
                              ),
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
        ],
      ),
    );
  }
}
