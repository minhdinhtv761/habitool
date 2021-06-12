import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habitool/model/methods.dart';
import 'package:habitool/view/screen/dashboard/dashboard_screen.dart';
import 'package:habitool/view/screen/intro/signup_screen.dart';
import 'package:habitool/view/screen/user/change_password.dart';
import 'package:habitool/view/screen/user/user_screen.dart';
import 'package:provider/provider.dart';

import 'view/screen/home_screen.dart';
import 'view/screen/intro/login_screen.dart';

class WidgetTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user == null) {
      return SignUpScreen();
    }
    return LogInScreen();
  }
}
