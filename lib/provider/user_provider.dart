import 'package:flutter/cupertino.dart';
import 'package:habitool/model/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider with ChangeNotifier {
  User user;
  Future<User> login({email, password}) async {
    user = await logIn(email, password);
    notifyListeners();

    return user;
  }
}
