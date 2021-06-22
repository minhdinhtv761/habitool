import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/model/methods.dart';
import 'package:habitool/model/profile/user_profile.dart';
import 'package:habitool/provider/user_provider.dart';
import 'package:provider/provider.dart';

class HelpScreen extends StatefulWidget {
  final UserData currentUser;

  HelpScreen({this.currentUser});

  @override
  _HelpScreen createState() => _HelpScreen();
}

class _HelpScreen extends State<HelpScreen> {
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
          'Báo cáo sự cố',
          style: TextStyle(
            color: CustomColors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
