import 'dart:async';

import 'package:habitool/view/screen/statistic/list_new.dart';
import 'package:habitool/view/screen/statistic/statistic_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
// navigate to listnew
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => ListNew()));
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Center(
            child: Container(
              width: width * 0.6,
              height: width * 0.6,

            )));
  }
}
