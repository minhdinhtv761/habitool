import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/view/screen/achivement/view_note.dart';
import 'package:habitool/view/screen/user/add_help.dart';
import 'package:habitool/view/screen/user/view_question.dart';
import 'package:habitool/widgets/custom_appbar_setting.dart';
import 'package:habitool/widgets/custom_appbar_social.dart';
import 'package:intl/intl.dart';


class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  CollectionReference ref = FirebaseFirestore.instance.collection('help');

  List<Color> myColors = [
    CustomColors.blue,
  ];
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context)
      //         .push(
      //       MaterialPageRoute(
      //         builder: (context) => AddNote(),
      //       ),
      //     )
      //         .then((value) {
      //       print("Calling Set  State !");
      //       setState(() {});
      //     });
      //   },
      //   child: Icon(
      //     Icons.add,
      //     color: CustomColors.light,
      //   ),
      //
      //   backgroundColor: CustomColors.blue,
      //
      //
      // ),
      //
      appBar: CustomAppBarUser(
          title: 'Trợ giúp',
          actionText: 'Thêm trợ giúp ',
          action: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => AddHelp(),
              ),
            )
                .then((value) {
              print("Calling Set  State !");
              setState(() {});
            });
          }),
      //
      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length == 0) {
              return Center(
                child: Text(
                  "You have no saved Notes !",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                Random random = new Random();
                Color bg = myColors[random.nextInt(1)];
                Map data = snapshot.data.docs[index].data();
                DateTime mydateTime = data['created'].toDate();
                String formattedTime =
                DateFormat.yMMMd().add_jm().format(mydateTime);

                return InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => ViewQuestion(
                          data,
                          formattedTime,
                          snapshot.data.docs[index].reference,
                        ),),
                            (route) => false);
                    // Navigator.of(context)
                    //     .push(
                    //   MaterialPageRoute(
                    //     builder: (context) => ViewQuestion(
                    //       data,
                    //       formattedTime,
                    //       snapshot.data.docs[index].reference,
                    //     ),
                    //   ),
                    // )
                    //     .then((value) {
                    //   setState(() {});
                    // });
                  },
                  child: Card(
                    color: bg,
                    elevation: 0,
                    margin: EdgeInsets.only(top: 14, left: 16, right: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data['title']}",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          //
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "Roboto",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                "Loading...",
                style: TextStyle(color: CustomColors.grey),
              ),
            );
          }
        },
      ),
    );
  }
}
