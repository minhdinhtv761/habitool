import 'package:habitool/view/screen/intro/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<User> createAccount(String email, String password ) async {
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
        "status": "Unavalible",
        "uid": _auth.currentUser.uid,
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

Future<User> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    User user = (await _auth.signInWithEmailAndPassword(
        email: email, password: password))
        .user;

    if (user != null) {
      print("Login Sucessfull");
      _firestore
          .collection('users')
          .doc(_auth.currentUser.uid)
          .get()
          .then((value) => user.updateProfile(displayName: value['name']));

      return user;
    } else {
      print("Login Failed");
      return user;
    }
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
          MaterialPageRoute(
              builder: (context) =>
                  LogInScreen()),
              (route) => false);
    });
  } catch (e) {
    print("error");
  }
}

Future<bool> validatePassword(String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var firebaseUser = _auth.currentUser;

    var authCredentials = EmailAuthProvider.credential(email: firebaseUser.email, password: password);
    try {
      var authResult = await firebaseUser
          .reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
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
    accessToken:  _authentication.accessToken,
  );
  User user = (await _auth.signInWithCredential(_credential)).user;
  return user;
}