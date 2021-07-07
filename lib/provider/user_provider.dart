import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:habitool/model/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habitool/model/profile/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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

  void onChangeAvatar({UserData userData}) {
    if (userData.urlAvt != '') {
      user = userData;
      updateAvatar(user: userData);
      notifyListeners();
    }
  }
}
