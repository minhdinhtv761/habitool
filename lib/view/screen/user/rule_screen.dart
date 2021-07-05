import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/model/methods.dart';
import 'package:habitool/model/profile/user_profile.dart';
import 'package:habitool/provider/user_provider.dart';
import 'package:provider/provider.dart';

class RuleScreen extends StatefulWidget {
  final UserData currentUser;

  RuleScreen({this.currentUser});

  @override
  _RuleScreen createState() => _RuleScreen();
}

class _RuleScreen extends State<RuleScreen> {
  @override
  Widget build(BuildContext context) {
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
            'Về chúng tôi',
            style: TextStyle(
              color: CustomColors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Padding(
              padding:
              EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
              child: Column(
                children: <Widget>[

                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30), top: Radius.circular(30)),
                      border: Border.all(
                        color: Colors.white, //                   <--- border color
                        width: 10.0,
                      ),
                    ),
                    child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Habitool là gì?',
                                style: TextStyle(
                                color: CustomColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Habitool là ứng dụng theo dõi thói quen miễn phí trên android, ứng dụng sẽ giúp bạn hình thành các thói quen mới và giữ được lịch trình hàng ngày một cách lí tưởng nhất. Với thiết kế tối giản và trực quan, Habitool sẽ khiến việc theo dõi cuộc sống của bạn trở nên dễ dàng hơn bao giờ hết.',
                              textAlign: TextAlign.center,
                              style: TextStyle(

                                color: CustomColors.darkgrey,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Version 1.0.0 - Release',
                                style: TextStyle(
                                color: CustomColors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              '© Habitool Inc.',
                              style: TextStyle(
                                color: CustomColors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              'Quản lý thói quen mỗi ngày!',
                              style: TextStyle(
                                color: CustomColors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        )

                  ),

                ],
              ),
            )

          ],
        ));
  }
}
