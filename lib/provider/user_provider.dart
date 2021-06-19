import 'package:flutter/cupertino.dart';
import 'package:habitool/model/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habitool/model/profile/user_profile.dart';

class UserProvider with ChangeNotifier {
  UserData user;
  Future<void> login(
      {email, password, Function(UserData) success, Function fail}) async {
    var _user = await logIn(email, password);
    if (_user != null) {
      user = _user;
       notifyListeners();
      success(_user);
    } else
      fail();
   
 notifyListeners();
  }
}
