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
            'Điều khoản ứng dụng',
            style: TextStyle(
              color: CustomColors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/Điều khoản sử dụng.jpg',
              width: 200,
              height: 400,
              fit: BoxFit.contain,
            )
          ],
        ));
  }
}
