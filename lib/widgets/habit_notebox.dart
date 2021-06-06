import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../custom_values/custom_colors.dart';

class NoteBox extends StatefulWidget {
  @override
  _NoteBoxState createState() => _NoteBoxState();
}

class _NoteBoxState extends State<NoteBox> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.only(top: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          color: CustomColors.pink,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Ghi chú',
          hintStyle: TextStyle(
              color: CustomColors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold),
          prefixIcon: Icon(
            FontAwesomeIcons.stickyNote,
            color: CustomColors.grey,
          ),
        ),
      ),
    );
  }
}
