import 'package:flutter/material.dart';

import 'package:habitool/Custom_Values/custom_colors.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObscure = true;

  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.light,
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: CustomColors.blue,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 115.0, left: 20.0, right: 20.0),
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
                              child: Text(
                                'Đăng ký',
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
                            Container(
                              child: TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: 'Tài khoản',
                                  labelStyle: TextStyle(
                                    color: CustomColors.grey,
                                    fontSize: 15,
                                  ),
                                  suffixIcon: _emailController.text.isEmpty
                                      ? Container(
                                          width: 0.0,
                                        )
                                      : IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () =>
                                              _emailController.clear(),
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Mật khẩu',
                                  labelStyle: TextStyle(
                                    color: CustomColors.grey,
                                    fontSize: 15,
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
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Nhập lại mật khẩu',
                                  labelStyle: TextStyle(
                                    color: CustomColors.grey,
                                    fontSize: 15,
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
                              ),
                            ),
                            SizedBox(height: 50.0),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: CustomColors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                minimumSize: Size(700, 50),
                              ),
                              child: Text('Đăng ký',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                              onPressed: () {},
                              onLongPress: () {},
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              minimumSize: Size(100, 50),
                            ),
                            icon: Image.asset(
                              'assets/images/google-logo.png',
                              height: 35.0,
                            ),
                            label: Text('Google',
                                style: TextStyle(
                                  color: CustomColors.darkgrey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                            onPressed: () {},
                            onLongPress: () {},
                          ),
                        ),
                        SizedBox(
                          width: 25.0,
                        ),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              minimumSize: Size(100, 50),
                            ),
                            icon: Image.asset(
                              'assets/images/facebook-logo.png',
                              height: 35.0,
                            ),
                            label: Text(
                              'Facebook',
                              style: TextStyle(
                                color: CustomColors.darkgrey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {},
                            onLongPress: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Bạn đã có tài khoản?',
                          style: TextStyle(
                            color: CustomColors.darkgrey,
                            fontSize: 13,
                          ),
                        ),
                        TextButton(
                          child: Text(
                            'Đăng nhập',
                            style: TextStyle(
                              color: CustomColors.link,
                              fontSize: 13,
                            ),
                          ),
                          onPressed: () {},
                          onLongPress: () {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
