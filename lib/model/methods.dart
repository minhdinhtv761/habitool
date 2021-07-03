import 'package:habitool/model/profile/user_profile.dart';
import 'package:habitool/view/screen/intro/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<User> createAccount(
    String email, String password, String repassword) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    User user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    if (user != null) {
      print("Account created Succesfull");

      user.updateProfile(displayName: email);

      await _firestore.collection('users').doc(_auth.currentUser.uid).set({
        "email": email,
        "password": password,
        "name": "Habiter",
        "status": "Unavalible",
        "uid": _auth.currentUser.uid,
        "address": '',
        "gender": 'Nam',
        "phone": '',
        "avatar": '',
        "DOB":'',
      });
      return user;
    } else {
      print("Account creation failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<UserData> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    User user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    UserData userData;
    if (user != null) {
      print("Login Sucessfull");
      await _firestore
          .collection('users')
          .doc(_auth.currentUser.uid)
          .get()
          .then((value) {
        userData = UserData.fromJson(value.data());
      });
    }

    return userData;
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LogInScreen()),
          (route) => false);
    });
  } catch (e) {
    print("error");
  }
}

Future<bool> validatePassword(String email,
    {@required String oldPassword,
    @required String newPassword,
    Function success}) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  print(email);
  try {
    User u = (await _auth.signInWithEmailAndPassword(
            email: email, password: oldPassword))
        .user;

    if (u != null) {
      // sửa pass ở đây
      u.updatePassword(newPassword);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(u.uid)
          .update({"password": newPassword});
      print("Thay đổi mật khẩu thành công");
      success();
      return true;
    }
  } catch (e) {
    print(e);
    return false;
  }
}

Future<void> updatePhonenumber(
    {@required String phone,
    @required uid,
    Function success,
    Function(String) fail}) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"phone": phone}).then((value) {
      print("Thay đổi sdt thành công");
      success();
    });
  } catch (e) {
    print(e);
    fail(e.toString());
  }
}

Future<void> updateAddress(
    {@required String address,
    @required uid,
    Function success,
    Function(String) fail}) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"address": address}).then((value) {
      print("Thay đổi dia chi thành công");
      success();
    });
  } catch (e) {
    print(e);
    fail(e.toString());
  }
}

Future<void> updateGender(
    {@required String gender,
    @required uid,
    Function success,
    Function(String) fail}) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"gender": gender}).then((value) {
      print("Thay đổi gioi tinh thành công");
      success();
    });
  } catch (e) {
    print(e);
    fail(e.toString());
  }
}

Future<void> updateName(
    {@required String name,
    @required uid,
    Function success,
    Function(String) fail}) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"name": name}).then((value) {
      print("Thay đổi ten thành công");
      success();
    });
  } catch (e) {
    print(e);
    fail(e.toString());
  }
}

Future<void> updateEmail(
    {@required String email,
    @required uid,
    Function success,
    Function(String) fail}) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"email": email}).then((value) {
      print("Thay đổi email thành công");
      success();
    });
  } catch (e) {
    print(e);
    fail(e.toString());
  }
}

Future<void> updateAvatar(
    {@required String avatar,
    @required uid,
    Function success,
    Function(String) fail}) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"avatar": avatar}).then((value) {
      print("Thay đổi avatar thành công");
      success();
    });
  } catch (e) {
    print(e);
    fail(e.toString());
  }
}

Future<String> updateDateOfBirth(
    {@required String date,
    @required uid,
    Function success,
    Function(String) fail}) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"DOB": date}).then((value) {
      print("Thay đổi ngày thành công");
      success();
    });
  } catch (e) {
    print(e);
    fail(e.toString());
  }
}

Future<void> updatePassword(String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var firebaseUser = await _auth.currentUser;
  firebaseUser.updatePassword(password);
}

Future<User> googleSignIn() async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
  var _authentication = await _googleSignInAccount.authentication;
  var _credential = GoogleAuthProvider.credential(
    idToken: _authentication.idToken,
    accessToken: _authentication.accessToken,
  );
  User user = (await _auth.signInWithCredential(_credential)).user;
  return user;
}

Map<String, dynamic> data = {
  "id": 123456,
  "email": "vietluu@gmail.com",
};
