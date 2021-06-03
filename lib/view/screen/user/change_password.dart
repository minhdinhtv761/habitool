import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreen createState() => _ChangePasswordScreen();
}

class _ChangePasswordScreen extends State<ChangePasswordScreen> {
  // bool _isObscure = true;
  // @override
  // void _toggleObscure() {
  //   setState(() {
  //     _isObscure = !_isObscure;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.light,
      appBar: AppBar(
        backgroundColor: CustomColors.light,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: CustomColors.black),
          onPressed: () {},
        ),
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
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Mật khẩu cũ',
                                  labelStyle: TextStyle(
                                    color: CustomColors.grey,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Nhập mật khẩu mới',
                                  labelStyle: TextStyle(
                                    color: CustomColors.grey,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Nhập lại mật khẩu mới',
                                  labelStyle: TextStyle(
                                    color: CustomColors.grey,
                                    fontSize: 20,
                                  ),
                                ),
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
                      child: Text('Cập nhật mật khẩu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      onPressed: () {},
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
    );
  }
}
