import 'dart:async';

import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/view/screen/achivement/list_new.dart';
import 'package:flutter/material.dart';
import 'package:habitool/view/screen/achivement/social_page.dart';
import 'package:habitool/view/screen/home_screen.dart';

class SocialScreen extends StatefulWidget {
  @override
  _SocialScreenState createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Notes',
      theme: ThemeData.light().copyWith(
        primaryColor: CustomColors.blue,
        accentColor: CustomColors.blue,
        scaffoldBackgroundColor: CustomColors.light,
      ),
      debugShowCheckedModeBanner: false,

      home: SocialPage(),
      // which used to re-authenticate every time App was opened
      // earlier I was simply calling the Login page
      // fixed it here
      // home: LoginPage(),

    );
  }
}
