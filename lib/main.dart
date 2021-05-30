import 'package:flutter/material.dart';

// import 'package:habitool/src/views/screens/intro/login_screen.dart';
// import 'package:habitool/src/views/screens/intro/signup_screen.dart';
import 'src/views/screens/home_screen.dart';
// import 'package:habitool/src/views/widgets/date_time_picker.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Roboto',
    ),
    home: HomeScreen(),
  ));
}
