import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/model/methods.dart';
import 'package:habitool/model/profile/user_profile.dart';
import 'package:habitool/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/model/methods.dart';
import 'package:habitool/model/profile/user_profile.dart';
import 'package:habitool/provider/user_provider.dart';
import 'package:mailer/smtp_server.dart';
import 'package:provider/provider.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportScreen extends StatefulWidget {
  final UserData currentUser;

  ReportScreen({this.currentUser});

  @override
  _ReportScreen createState() => _ReportScreen();
}

class _ReportScreen extends State<ReportScreen> {
  final TextEditingController _emailController = TextEditingController();
  String email;
  String des;
  @override
  Widget build(BuildContext context) {
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
          'Trợ giúp',
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
                                    hintText: 'Nhập email hoặc tên của bạn',
                                    labelStyle: TextStyle(
                                      color: CustomColors.grey,
                                      fontSize: 20,
                                    ),
                                  ),
                                  controller: _emailController,
                                  onChanged: (_val) {
                                    email = _val;
                                  },
                                ),
                              ),
                              Container(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Nhập nội dung',
                                    labelStyle: TextStyle(
                                      color: CustomColors.grey,
                                      fontSize: 20,
                                    ),
                                  ),
                                  onChanged: (_val) {
                                    des = _val;
                                  },
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
                        onPressed: () {
                          add();
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                content: Text('Gửi thành công'),
                              ));

                        },
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
  void add() async {
    // save to db
    CollectionReference ref = FirebaseFirestore.instance.collection('bug');

    var data = {
      'email': email,
      'description': des,
      'created': DateTime.now(),
    };

    ref.add(data);

    //

    Navigator.pop(context);
  }
}

