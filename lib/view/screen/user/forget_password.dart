import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/model/methods.dart';
import 'package:habitool/model/profile/user_profile.dart';
import 'package:habitool/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  final UserData currentUser;

  ForgetPasswordScreen({this.currentUser});

  @override
  _ForgetPasswordScreen createState() => _ForgetPasswordScreen();
}

class _ForgetPasswordScreen extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.light,
      appBar: AppBar(
        backgroundColor: CustomColors.light,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: CustomColors.black),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(context);
            }),
        title: Text(
          'Quên mật khẩu',
          style: TextStyle(
            color: CustomColors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 55.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 25.0, left: 20.0, right: 20.0, bottom: 25.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Nhập email',
                                    labelStyle: TextStyle(
                                      color: CustomColors.grey,
                                      fontSize: 20,
                                    ),
                                  ),
                                  controller: _emailController,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: CustomColors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: Size(350, 60),
                        ),
                        child: Text('Xác nhận',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
