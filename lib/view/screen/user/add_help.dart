import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/widgets/custom_appbar_pop.dart';

class AddHelp extends StatefulWidget {
  @override
  _AddHelpState createState() => _AddHelpState();
}

class _AddHelpState extends State<AddHelp> {
  String title;
  String des;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarPop(
          title: 'Trợ giúp gì?',
          actionText: 'Lưu',
          action: () {
            add();
          }),
      body: Container(
        padding: EdgeInsets.all(
          16.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Tiêu đề",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.pink),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
                color: CustomColors.pink,
              ),
              onChanged: (_val) {
                title = _val;
              },
            ),
            //
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              padding: const EdgeInsets.only(top: 12.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Nội dung",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.pink),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                style: TextStyle(
                  fontSize: 13.0,
                  color: CustomColors.black,
                ),
                onChanged: (_val) {
                  des = _val;
                },
                maxLines: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void add() async {
    // save to db
    CollectionReference ref = FirebaseFirestore.instance.collection('help');

    var data = {
      'title': title,
      'description': des,
      'created': DateTime.now(),
    };

    ref.add(data);

    //

    Navigator.pop(context);
  }
}
