import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:habitool/model/methods.dart';
import 'package:habitool/model/profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> loginGG({Function(UserData) success, Function fail}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    //
    var _user = await googleSignIn();
    if (_user != null) {
      DocumentSnapshot value =
          await _firestore.collection('users').doc(_user.uid).get();

      if (value.exists) {
        user = UserData.fromJson(value.data());
      } else {
        _firestore.collection('users').doc(_auth.currentUser.uid).set({
          "email": _user.email,
          "name": _user.displayName,
          "uid": _user.uid,
          "address": '',
          "gender": 'Nam',
          "phone": _user.phoneNumber,
          "avatar": _user.photoURL,
          "DOB": DateTime.now(),
        });
        user = new UserData(
            email: _user.email,
            displayName: _user.displayName,
            uid: _user.uid,
            address: '',
            gender: 'Nam',
            phoneNumber: _user.phoneNumber,
            urlAvt: _user.photoURL);
      }
    }

    notifyListeners();
    success(user);
  }

  void onChangeAvatar({UserData userData}) {
    if (userData.urlAvt != '') {
      user = userData;
      updateAvatar(user: userData);
      notifyListeners();
    }
  }
}
