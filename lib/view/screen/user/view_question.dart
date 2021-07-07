import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/widgets/custom_appbar_pop.dart';
import 'package:habitool/widgets/custom_appbar_social.dart';

class ViewQuestion extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  ViewQuestion(this.data, this.time, this.ref);

  @override
  _ViewQuestionState createState() => _ViewQuestionState();
}

class _ViewQuestionState extends State<ViewQuestion> {
  String title;
  String des;

  bool edit = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    title = widget.data['title'];
    des = widget.data['description'];
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBarPop(title: '', actionText: '', action: () {}),
        resizeToAvoidBottomInset: false,
        //
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(
              12.0,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 12.0,
                ),
                //
                Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: "Tiêu đề",
                        ),
                        style: TextStyle(
                          fontSize: 32.0,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          color: CustomColors.pink,
                        ),
                        initialValue: widget.data['title'],
                        enabled: edit,
                        onChanged: (_val) {
                          title = _val;
                        },
                        validator: (_val) {
                          if (_val.isEmpty) {
                            return "Can't be empty !";
                          } else {
                            return null;
                          }
                        },
                      ),
                      //
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12.0,
                          bottom: 12.0,
                        ),
                        child: Text(
                          widget.time,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Roboto",
                            color: CustomColors.blue,
                          ),
                        ),
                      ),

                      //

                      TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: "Nội dung",
                        ),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Roboto",
                          color: CustomColors.black,
                        ),
                        initialValue: widget.data['description'],
                        enabled: edit,
                        onChanged: (_val) {
                          des = _val;
                        },
                        maxLines: 20,
                        validator: (_val) {
                          if (_val.isEmpty) {
                            return "Can't be empty !";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void delete() async {
    // delete from db
    await widget.ref.delete();
    Navigator.pop(context);
  }

  void save() async {
    if (key.currentState.validate()) {
      // TODo : showing any kind of alert that new changes have been saved
      await widget.ref.update(
        {'title': title, 'description': des},
      );
      Navigator.of(context).pop();
    }
  }
}
