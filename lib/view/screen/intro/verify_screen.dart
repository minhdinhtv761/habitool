import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/view/screen/intro/login_screen.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;
  bool isLoading = false;
  @override
  void initState() {
    user = auth.currentUser;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.light,
      body: isLoading
          ? Center(
        child: Container(
          height: size.height / 20,
          width: size.height / 20,
          child: CircularProgressIndicator(),
        ),
      )
          : SingleChildScrollView(
        child: Container(
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: CustomColors.blue,
                  borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(30)),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(top: 115.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 25.0,
                            left: 20.0,
                            right: 20.0,
                            bottom: 25.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Đăng Ký',
                                style: TextStyle(
                                  color: CustomColors.black,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'Vui lòng vào email ${user.email} để xác thực tài khoản',
                              style: TextStyle(
                                color: CustomColors.blue,
                                fontSize: 15,
                               // fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 25.0),


                  ],
                ),
              ),
            ],
          ),
        ),


      //   child: Text(
      //       'Vui lòng vào email ${user.email} để xác thực tài khoản'),
      // ),
            ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      //timer.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LogInScreen()));
    }
    else {
     // timer.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LogInScreen()));
    }
  }
}