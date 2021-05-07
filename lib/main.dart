import 'package:flutter/material.dart';
import 'package:habitool/src/screens/home_screen.dart';

// import 'package:habitool/src/screens/login_screen.dart';
// import 'package:habitool/src/screens/sign_up_screen.dart';
import 'package:habitool/src/screens/home_screen.dart';
// import 'package:habitool/src/widgets/date_time_picker.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: HomeScreen(),
    )
  );
}