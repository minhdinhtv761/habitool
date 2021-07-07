import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/provider/user_provider.dart';
import 'package:habitool/services/ad_helper.dart';
import 'package:habitool/view/screen/home_screen.dart';
import 'package:habitool/view/screen/intro/signup_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:habitool/widgets/field.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  //
  //Adding admob
  //
  BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  //
  @override
  void initState() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

//
//
  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

//
// End AdMobs
//
  bool _isObscure = true;
  DateTime _selectedDate;

  final _email = TextEditingController();
  final _password = TextEditingController();

  UserProvider _user;
  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    _user = Provider.of<UserProvider>(context);

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
                      height: 250,
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
                                      'Đăng nhập',
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
                                  Container(child: field(size, "", _email)),
                                  SizedBox(height: 20.0),
                                  Container(
                                    child: TextField(
                                      controller: _password,
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
                                  SizedBox(height: 50.0),
                                  customButton(size, "Đăng nhập")
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          if (_isBannerAdReady)
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: _bannerAd.size.width.toDouble(),
                                height: _bannerAd.size.height.toDouble(),
                                child: AdWidget(ad: _bannerAd),
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Bạn chưa có tài khoản?',
                                style: TextStyle(
                                  color: CustomColors.darkgrey,
                                  fontSize: 13,
                                ),
                              ),
                              TextButton(
                                child: Text(
                                  'Đăng ký',
                                  style: TextStyle(
                                    color: CustomColors.link,
                                    fontSize: 13,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpScreen()),
                                      (route) => false);
                                },
                                onLongPress: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget customButton(Size size, String text) {
    return GestureDetector(
      onTap: () {
        if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          _user.login(
              email: _email.text,
              password: _password.text,
              success: (u) {
                if (u != null) {
                  setState(() {
                    isLoading = false;
                  });

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false);
                } else {
                  print("Login Failed");
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text('Cảnh báo'),
                            content: Text(
                                'Vui lòng nhập đúng Tài khoản xác thực/Mật khẩu!'),
                          ));
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              fail: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text('Cảnh báo'),
                          content: Text(
                              'Vui lòng nhập đúng Tài khoản xác thực/Mật khẩu!'),
                        ));
                setState(() {
                  isLoading = false;
                });
                print("Please fill form correctly");
                print("Login Failed");
              });
        } else {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text('Cảnh báo'),
                    content:
                        Text('Vui lòng nhập đúng Tài khoản xác thực/Mật khẩu!'),
                  ));
          print("Please fill form correctly");
        }
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: CustomColors.blue,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}
