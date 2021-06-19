import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/model/methods.dart';
import 'package:habitool/model/profile/user_profile.dart';
import 'package:habitool/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';

class ChangePasswordScreen extends StatefulWidget {
  final UserData currentUser;

  ChangePasswordScreen({this.currentUser});

  @override
  _ChangePasswordScreen createState() => _ChangePasswordScreen();
}

class _ChangePasswordScreen extends State<ChangePasswordScreen> {
  var _passwordController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _reNewPasswordController = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  bool checkCurrentPasswordValid = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _newPasswordController.dispose();
    _reNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final _user = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: CustomColors.light,
      appBar: AppBar(
        backgroundColor: CustomColors.light,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: CustomColors.black),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Đổi mật khẩu',
          style: TextStyle(
            color: CustomColors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                                    hintText: 'Mật khẩu cũ',
                                    errorText: checkCurrentPasswordValid
                                        ? null
                                        : "Kiểm tra lại mật khẩu",
                                    labelStyle: TextStyle(
                                      color: CustomColors.grey,
                                      fontSize: 20,
                                    ),
                                  ),
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return "Không được bỏ trống";

                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Nhập mật khẩu mới',
                                    labelStyle: TextStyle(
                                      color: CustomColors.grey,
                                      fontSize: 20,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        (_isObscure
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                      ),
                                      onPressed: _toggleObscure,
                                    ),
                                  ),
                                  controller: _newPasswordController,
                                  obscureText: _isObscure,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Nhập lại mật khẩu mới',
                                      labelStyle: TextStyle(
                                        color: CustomColors.grey,
                                        fontSize: 20,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          (_isObscure
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                        ),
                                        onPressed: _toggleObscure,
                                      ),
                                    ),
                                    obscureText: _isObscure,
                                    controller: _reNewPasswordController,
                                    validator: (value) {
                                      return _newPasswordController.text ==
                                              value
                                          ? null
                                          : "Vui lòng nhập lại đúng mật khẩu";
                                    }),
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
                        child: Text('Cập nhật mật khẩu',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await validatePassword(_user.user.email,
                                oldPassword: _passwordController.text,
                                newPassword: _newPasswordController.text,
                                success: () async {
                              var result = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: Text("Thay đổi thành công"),
                                      ));
                              if (result) {
                              } else {}
                            });
                          }
                        },
                        onLongPress: () {},
                      ),
                      SizedBox(height: 10.0),
                      TextButton(
                        child: Text(
                          'Quên mật khẩu ?',
                          style: TextStyle(
                            color: CustomColors.link,
                            fontSize: 15,
                          ),
                        ),
                        onPressed: () {},
                        onLongPress: () {},
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
